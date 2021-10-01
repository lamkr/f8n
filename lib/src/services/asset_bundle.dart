// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:typed_data';
import 'dart:async';
import 'package:f8n/foundation.dart';
import 'package:collection/collection.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';
import 'dart:convert';

/// A collection of resources used by the application.
///
/// Asset bundles contain resources, such as images and strings, that can be
/// used by an application. Access to these resources is asynchronous so that
/// they can be transparently loaded over a network (e.g., from a
/// [NetworkAssetBundle]) or from the local file system without blocking the
/// application's user interface.
///
/// Applications have a [rootBundle], which contains the resources that were
/// packaged with the application when it was built. To add resources to the
/// [rootBundle] for your application, add them to the `assets` subsection of
/// the `flutter` section of your application's `pubspec.yaml` manifest.
///
/// For example:
///
/// ```yaml
/// name: my_awesome_application
/// flutter:
///   assets:
///    - images/hamilton.jpeg
///    - images/lafayette.jpeg
/// ```
///
/// Rather than accessing the [rootBundle] global static directly, consider
/// obtaining the [AssetBundle] for the current [BuildContext] using
/// [DefaultAssetBundle.of]. This layer of indirection lets ancestor widgets
/// substitute a different [AssetBundle] (e.g., for testing or localization) at
/// runtime rather than directly replying upon the [rootBundle] created at build
/// time. For convenience, the [WidgetsApp] or [MaterialApp] widget at the top
/// of the widget hierarchy configures the [DefaultAssetBundle] to be the
/// [rootBundle].
///
/// See also:
///
///  * [DefaultAssetBundle]
///  * [NetworkAssetBundle]
///  * [rootBundle]
abstract class AssetBundle {
  /// Retrieve a binary resource from the asset bundle as a data stream.
  ///
  /// Throws an exception if the asset is not found.
  Future<ByteData> load(String key);

  /// Retrieve a string from the asset bundle.
  ///
  /// Throws an exception if the asset is not found.
  ///
  /// If the `cache` argument is set to false, then the data will not be
  /// cached, and reading the data may bypass the cache. This is useful if the
  /// caller is going to be doing its own caching. (It might not be cached if
  /// it's set to true either, depending on the asset bundle implementation.)
  ///
  /// The function expects the stored string to be UTF-8-encoded as
  /// [Utf8Codec] will be used for decoding the string. If the string is
  /// larger than 50 KB, the decoding process is delegated to an
  /// isolate to avoid jank on the main thread.
  Future<String> loadString(String key, {bool cache = true}) async {
    final ByteData? data = await load(key);
    if (data == null) {
      throw Exception('Unable to load asset: $key');
    }
    // 50 KB of data should take 2-3 ms to parse on a Moto G4, and about 400 μs
    // on a Pixel 4.
    if (data.lengthInBytes < 50 * 1024) {
      return utf8.decode(data.buffer.asUint8List());
    }
    // For strings larger than 50 KB, run the computation in an isolate to
    // avoid causing main thread jank.
    return compute(_utf8decode, data, debugLabel: 'UTF8 decode for "$key"');
  }

  static String _utf8decode(ByteData data) {
    return utf8.decode(data.buffer.asUint8List());
  }

  /// Retrieve a string from the asset bundle, parse it with the given function,
  /// and return the function's result.
  ///
  /// Implementations may cache the result, so a particular key should only be
  /// used with one parser for the lifetime of the asset bundle.
  Future<T> loadStructuredData<T>(
      String key, Future<T> Function(String value) parser);

  /// If this is a caching asset bundle, and the given key describes a cached
  /// asset, then evict the asset from the cache so that the next time it is
  /// loaded, the cache will be reread from the asset bundle.
  void evict(String key) {}

  @override
  String toString() => '${describeIdentity(this)}()';
}

/// An [AssetBundle] that permanently caches string and structured resources
/// that have been fetched.
///
/// Strings (for [loadString] and [loadStructuredData]) are decoded as UTF-8.
/// Data that is cached is cached for the lifetime of the asset bundle
/// (typically the lifetime of the application).
///
/// Binary resources (from [load]) are not cached.
abstract class CachingAssetBundle extends AssetBundle {
  // TODO(ianh): Replace this with an intelligent cache, see https://github.com/flutter/flutter/issues/3568
  final Map<String, Future<String>> _stringCache = <String, Future<String>>{};
  final Map<String, Future<dynamic>> _structuredDataCache = <String, Future<dynamic>>{};

  @override
  Future<String> loadString(String key, { bool cache = true }) {
    if (cache) {
      return _stringCache.putIfAbsent(key, () => super.loadString(key));
    }
    return super.loadString(key);
  }

  /// Retrieve a string from the asset bundle, parse it with the given function,
  /// and return the function's result.
  ///
  /// The result of parsing the string is cached (the string itself is not,
  /// unless you also fetch it with [loadString]). For any given `key`, the
  /// `parser` is only run the first time.
  ///
  /// Once the value has been parsed, the future returned by this function for
  /// subsequent calls will be a [SynchronousFuture], which resolves its
  /// callback synchronously.
  @override
  Future<T> loadStructuredData<T>(String key, Future<T> Function(String value) parser) {
    if (_structuredDataCache.containsKey(key)) {
      return _structuredDataCache[key]! as Future<T>;
    }
    Completer<T>? completer;
    Future<T>? result;
    loadString(key, cache: false).then<T>(parser).then<void>((T value) {
      result = SynchronousFuture<T>(value);
      _structuredDataCache[key] = result!;
      if (completer != null) {
        // We already returned from the loadStructuredData function, which means
        // we are in the asynchronous mode. Pass the value to the completer. The
        // completer's future is what we returned.
        completer.complete(value);
      }
    });
    if (result != null) {
      // The code above ran synchronously, and came up with an answer.
      // Return the SynchronousFuture that we created above.
      return result!;
    }
    // The code above hasn't yet run its "then" handler yet. Let's prepare a
    // completer for it to use when it does run.
    completer = Completer<T>();
    _structuredDataCache[key] = completer.future;
    return completer.future;
  }

  @override
  void evict(String key) {
    _stringCache.remove(key);
    _structuredDataCache.remove(key);
  }
}

/// An [AssetBundle] that loads resources using platform messages.
class PlatformAssetBundle extends CachingAssetBundle
{
  static const notFound = -1;
  static const _pubspec = 'pubspec.yaml';

  final String _packagePath;
  List<String>? _assets;

  final String metadata;

  PlatformAssetBundle({this.metadata=''})
    : _packagePath = Directory.current.path;

  @override
  Future<ByteData> load(String key) async {
    await _loadAssets();
    if( binarySearch(_assets!, key) == notFound ) {
      throw Exception('Unable to load asset: $key');
    }
    final filepath = _packagePath + path.separator + key;
    final bytes = await File(filepath).readAsBytes();
    return ByteData.view(bytes.buffer);
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    await _loadAssets();
    return super.loadString(key, cache: cache);
  }

  @override
  Future<T> loadStructuredData<T>(String key, Future<T> Function(String value) parser)
  async {
    await _loadAssets();
    return super.loadStructuredData(key, parser);
  }

  Future _loadAssets() async {
    if( _assets == null ) {
      final pubspecPath = _packagePath + path.separator + _pubspec;
      var text = await File(pubspecPath).readAsString();
      var yaml = loadYaml(text);
      if (metadata.isNotEmpty) {
        yaml = _parseMetadata(yaml, metadata);
      }
      if (yaml is YamlList) {
        _assets = _parseAndSortList(yaml);
      }
      else {
        _assets = <String>[];
      }
    }
  }

  dynamic _parseMetadata(dynamic yaml, String metadata) {
    final keys = metadata.split('/');
    for( var key in keys ) {
      try {
        yaml = yaml[key];
      }
      catch (_) {
        return null;
      }
    }
    return yaml;
  }

  List<String> _parseAndSortList(YamlList yaml) {
    return yaml.map((element) => element.toString()).toList()..sort();
  }
}

AssetBundle _initRootBundle() {
  return PlatformAssetBundle(metadata: 'flutter/assets');
}

/// The [AssetBundle] from which this application was loaded.
///
/// The [rootBundle] contains the resources that were packaged with the
/// application when it was built. To add resources to the [rootBundle] for your
/// application, add them to the `assets` subsection of the `flutter` section of
/// your application's `pubspec.yaml` manifest.
///
/// For example:
///
/// ```yaml
/// name: my_awesome_application
/// flutter:
///   assets:
///    - images/hamilton.jpeg
///    - images/lafayette.jpeg
/// ```
///
/// Rather than using [rootBundle] directly, consider obtaining the
/// [AssetBundle] for the current [BuildContext] using [DefaultAssetBundle.of].
/// This layer of indirection lets ancestor widgets substitute a different
/// [AssetBundle] at runtime (e.g., for testing or localization) rather than
/// directly replying upon the [rootBundle] created at build time. For
/// convenience, the [WidgetsApp] or [MaterialApp] widget at the top of the
/// widget hierarchy configures the [DefaultAssetBundle] to be the [rootBundle].
///
/// See also:
///
///  * [DefaultAssetBundle]
///  * [NetworkAssetBundle]
final AssetBundle rootBundle = _initRootBundle();

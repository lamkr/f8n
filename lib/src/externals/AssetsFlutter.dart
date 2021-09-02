import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

import 'package:f8n/assets.dart';

class AssetsFlutter implements IAssets
{
  /// Loads a json asset content from [filename] in the folder `assets`
  /// using native functions.
  @override
  Future<dynamic> loadJson(String filename) async {
    if( ! filename.toLowerCase().endsWith('.json') ) {
      filename += '.json';
    }
    var path = 'assets';
    path += '/$filename';
    var content = await rootBundle.loadString(path, cache: false);
    return json.decode(content);
  }

  @override
  Future<dynamic> loadJsonFromUri(Uri uri) async {
    var content = await loadTextFromUri(uri);
    return json.decode(content);
  }

  @override
  Future<dynamic> loadJsonFromRelativePath(String path) async {
    var content = await loadTextFromRelativePath(path);
    return json.decode(content);
  }

  @override
  Future loadText(String filename) async {
    final path = 'assets/$filename';
    var content = await rootBundle.loadString(path, cache: false);
    return content;
  }

  @override
  Future loadTextFromRelativePath(String path) async {
    var content = await rootBundle.loadString(path, cache: false);
    return content;
  }

  @override
  Future loadTextFromUri(Uri uri) async {
    var content = await File.fromUri(uri).readAsString();
    return content;
  }
}
/*import 'dart:convert';
import 'dart:io';

import 'package:f8n/services.dart';

class AssetsDart implements IAssets
{
  /// Loads a json asset content from [filename] in the folder `assets`
  /// using native functions.
  @override
  Future<dynamic> loadJson(String filename) async {
    if (!filename.toLowerCase().endsWith('.json')) {
      filename += '.json';
    }
    var path = 'assets';
    // When runs unit tests, the current directory change to correct folder.
    if( Directory.current.path.replaceAll('\\','/').endsWith('/test') ) {
      path = '../$path';
    }
    else {
      path = '$path/$filename';
    }
    var content = await File(path).readAsString();
    return json.decode(content);
  }

  /// Loads a json asset content from [uri]. This method loads the file
  /// using native functions.
  @override
  Future<dynamic> loadJsonFromUri(Uri uri) async {
    var content = await File.fromUri(uri).readAsString();
    return json.decode(content);
  }

  @override
  Future<dynamic> loadJsonFromRelativePath(String path) async {
    var content = await File(path).readAsString();
    return json.decode(content);
  }

  /// Loads a text asset content with [filename]. This method loads the file
  /// using native functions.
  @override
  Future loadText(String filename) async {
    final path = 'assets/$filename';
    final content = await File(path).readAsString();
    return content;
  }

  @override
  Future loadTextFromRelativePath(String path) async {
    var content = await File(path).readAsString();
    return content;
  }

  @override
  Future loadTextFromUri(Uri uri) async {
    final content = await File.fromUri(uri).readAsString();
    return content;
  }
}*/
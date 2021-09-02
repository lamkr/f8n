abstract class IAssets
{
  Future<dynamic> loadJson(String filename);

  Future<dynamic> loadJsonFromUri(Uri uri);

  Future<dynamic> loadJsonFromRelativePath(String path);

  Future<dynamic> loadText(String filename);

  Future<dynamic> loadTextFromUri(Uri uri);

  Future<dynamic> loadTextFromRelativePath(String path);
}


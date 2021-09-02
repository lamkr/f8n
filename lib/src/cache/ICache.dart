abstract class ICache
{
  dynamic operator [](String key);

  void operator []=(String key, dynamic value);
}
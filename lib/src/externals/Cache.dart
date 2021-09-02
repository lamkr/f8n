import 'package:f8n/cache.dart';

class Cache implements ICache
{
  final _store = <String, dynamic>{};

  @override
  dynamic operator [](String key) {
    return _store[key];
  }

  @override
  void operator []=(String key, value) {
    _store[key] = value;
  }
}
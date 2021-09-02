import 'package:cleanarch/log.dart';
import 'package:flutter/foundation.dart';

class DeveloperLogger implements ILogger
{
  String get _now => DateTime.now().toIso8601String();

  @override
  void error(String text, {Map<String,dynamic> args=const <String,dynamic>{},
    Object? error, StackTrace? stackTrace}) {
    debugPrint('[ERROR] $_now: $text');
  }

  @override
  void info(String text, {Map<String,dynamic> args=const <String,dynamic>{}}) {
    debugPrint('[INFO] $_now: $text');
  }

  @override
  void warn(String text, {Map<String,dynamic> args=const <String,dynamic>{},
    Object? error, StackTrace? stackTrace}) {
    debugPrint('[WARN] $_now: $text');
  }

  @override
  void dispose() {
  }
}
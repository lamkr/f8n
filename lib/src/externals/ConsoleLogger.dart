import 'package:f8n/log.dart';

class ConsoleLogger implements ILogger
{
  String get _now => DateTime.now().toIso8601String();

  @override
  void error(String text, {Map<String,dynamic> args=const <String,dynamic>{},
    Object? error, StackTrace? stackTrace}) {
    print('[ERROR] $_now: $text');
  }

  @override
  void info(String text, {Map<String,dynamic> args=const <String,dynamic>{}}) {
    print('[INFO] $_now: $text');
  }

  @override
  void warn(String text, {Map<String,dynamic> args=const <String,dynamic>{},
    Object? error, StackTrace? stackTrace}) {
    print('[WARN] $_now: $text');
  }

  @override
  void dispose() {
  }
}
import 'package:f8n/log.dart';

class ConsoleLogger implements ILogger
{
  String get _now => DateTime.now().toIso8601String();

  final _buf = StringBuffer();

  @override
  void error(String text, {Map<String,dynamic> args=const <String,dynamic>{},
    Object? error, StackTrace? stackTrace}) {
    _buf.clear();
    _buf.write('[ERROR] $_now: $text');
    _buf.write('\terror=${error.toString()}');
    _buf.write('\targs=${_buildArgs(args)}');
  }

  @override
  void info(String text, {Map<String,dynamic> args=const <String,dynamic>{}}) {
    _buf.clear();
    _buf.write('[INFO] $_now: $text');
    _buf.write('\targs=${_buildArgs(args)}');
    print(_buf.toString());
  }

  @override
  void warn(String text, {Map<String,dynamic> args=const <String,dynamic>{},
    Object? error, StackTrace? stackTrace}) {
    _buf.clear();
    _buf.write('[WARN] $_now: $text');
    _buf.write('\terror=${error.toString()}');
    _buf.write('\targs=${_buildArgs(args)}');
    print(_buf.toString());
  }

  @override
  void dispose() {
  }

  String _buildArgs(Map<String, dynamic> args) {
    final buf = StringBuffer();
    for( var arg in args.entries ) {
      buf.write('${arg.key}=${arg.value}');
    }
    return buf.toString();
  }
}
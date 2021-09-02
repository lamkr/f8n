abstract class ILogger
{
  void dispose();

  void info(String text, {Map<String,dynamic> args=const <String,dynamic>{}});

  void warn(String text, {Map<String,dynamic> args=const <String,dynamic>{},
    Object? error, StackTrace? stackTrace});

  void error(String text, {Map<String,dynamic> args=const <String,dynamic>{},
    Object? error, StackTrace? stackTrace});
}
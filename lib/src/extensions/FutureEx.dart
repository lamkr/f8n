import 'dart:async';

class FutureEx
{
  // Constant `true` function, used as callback by [forEach].
  static bool _kTrue(Object? _) => true;

  static Future doWhile<T>(Iterable<T> elements,
      FutureOr Function(T element) action)
  {
    var iterator = elements.iterator;
    return Future.doWhile(() {
      if (!iterator.moveNext()) return false;
      var result = action(iterator.current);
      if (result is Future) return result.then(_kTrue);
      return true;
    });
  }
}
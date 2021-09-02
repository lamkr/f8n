import 'Lifestyle.dart';
import 'types.dart';

abstract class IInjector
{
  void register<TService, TImplementation extends TService>(
    Constructor<TImplementation> constructor,
    Lifestyle lifestyle );

  T get<T>();

  void dispose();
}

import 'package:f8n/injection.dart';
import 'package:simply_injector/simply_injector.dart' as si;

class SimplyInjector
  implements IInjector
{
  final _injector = si.SimplyInjector.Container();

  @override
  T get<T>() => _injector.get<T>();

  @override
  void register<TService, TImplementation extends TService>(
    Constructor<TImplementation> constructor,
    [Lifestyle lifestyle=Lifestyle.transient])
  {
    var _lifestyle = lifestyle == Lifestyle.singleton
      ? si.Lifestyle.singleton : si.Lifestyle.transient;
    _injector.register<TService, TImplementation>(constructor, _lifestyle );
  }

  @override
  void dispose() {
    _injector.dispose();
  }
}
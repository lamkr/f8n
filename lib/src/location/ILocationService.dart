import 'Location.dart';

abstract class ILocationService {
  Future<bool> get isEnabled;

  Future<bool> get isDisabled;
  
  Future<Location> currentLocation(
      {Duration timeout = const Duration(seconds: 30)});
}

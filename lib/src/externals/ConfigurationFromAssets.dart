import 'package:cleanarch/assets.dart';
import 'package:cleanarch/src/configuration/IConfiguration.dart';

/// This class load a configuration from the asset file
/// `assets/appsettings.json`.
class ConfigurationFromAssets implements IConfiguration
{
  Map<String, dynamic> _values;

  static Future<IConfiguration> load(IAssets assets) async {
    final config = ConfigurationFromAssets._();
    config._values = await assets.loadJson('appsettings.json');
    return config;
  }

  ConfigurationFromAssets._()
    : _values = {};

  @override
  String operator [](String key) {
    return _values[key];
  }
}

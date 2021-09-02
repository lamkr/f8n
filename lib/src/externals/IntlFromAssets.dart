import 'package:f8n/locales.dart';
import 'package:f8n/assets.dart';

class IntlFromAssets implements IIntl
{
  final IAssets _assets;
  final Locale locale;

  Map<String, dynamic> _localizedValues = {};

  set localizedValues(Map<String, dynamic> values) => _localizedValues = values;

  IntlFromAssets(this._assets, this.locale);

  @override
  Future load() async {
    _localizedValues = await _assets
        .loadJson('locale/localization_${locale.toString()}.json');
  }

  @override
  String operator [](String key) => _localizedValues[key] ?? "'$key' not found";
}


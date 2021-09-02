class Locale {
  const Locale(
      this._languageCode, [
        this._countryCode,
      ]) : assert(_languageCode != null), // ignore: unnecessary_null_comparison
        assert(_languageCode != '');

  /// The primary language subtag for the locale.
  ///
  /// This must not be null. It may be 'und', representing 'undefined'.
  ///
  /// This is expected to be string registered in the [IANA Language Subtag
  /// Registry](https://www.iana.org/assignments/language-subtag-registry/language-subtag-registry)
  /// with the type "language". The string specified must match the case of the
  /// string in the registry.
  ///
  /// Language subtags that are deprecated in the registry and have a preferred
  /// code are changed to their preferred code. For example, `const
  /// Locale('he')` and `const Locale('iw')` are equal, and both have the
  /// [languageCode] `he`, because `iw` is a deprecated language subtag that was
  /// replaced by the subtag `he`.
  ///
  /// This must be a valid Unicode Language subtag as listed in [Unicode CLDR
  /// supplemental
  /// data](http://unicode.org/cldr/latest/common/validity/language.xml).
  ///
  /// See also:
  ///
  ///  * [Locale.fromSubtags], which describes the conventions for creating
  ///    [Locale] objects.
  String get languageCode => _languageCode;
  final String _languageCode;

  /// The region subtag for the locale.
  ///
  /// This may be null, indicating that there is no specified region subtag.
  ///
  /// This is expected to be string registered in the [IANA Language Subtag
  /// Registry](https://www.iana.org/assignments/language-subtag-registry/language-subtag-registry)
  /// with the type "region". The string specified must match the case of the
  /// string in the registry.
  ///
  /// Region subtags that are deprecated in the registry and have a preferred
  /// code are changed to their preferred code. For example, `const Locale('de',
  /// 'DE')` and `const Locale('de', 'DD')` are equal, and both have the
  /// [countryCode] `DE`, because `DD` is a deprecated language subtag that was
  /// replaced by the subtag `DE`.
  ///
  /// See also:
  ///
  ///  * [Locale.fromSubtags], which describes the conventions for creating
  ///    [Locale] objects.
  String? get countryCode => _countryCode;
  final String? _countryCode;

  @override
  bool operator ==(Object arg) {
    if (identical(this, arg)) {
      return true;
    }
    if (arg is! Locale) {
      return false;
    }
    var other = arg;
    final countryCode = _countryCode;
    final otherCountryCode = other.countryCode;
    return other.languageCode == languageCode
        && (other.countryCode == countryCode // Treat '' as equal to null.
            || otherCountryCode != null && otherCountryCode.isEmpty && countryCode == null
            || countryCode != null && countryCode.isEmpty && other.countryCode == null);
  }

  @override
  int get hashCode => _countryCode.hashCode;

  /// Returns a string representing the locale.
  ///
  /// This identifier happens to be a valid Unicode Locale Identifier using
  /// underscores as separator, however it is intended to be used for debugging
  /// purposes only. For parseable results, use [toLanguageTag] instead.
  @override
  String toString() {
    return _rawToString('_');
  }

  /// Returns a syntactically valid Unicode BCP47 Locale Identifier.
  ///
  /// Some examples of such identifiers: "en", "es-419", "hi-Deva-IN" and
  /// "zh-Hans-CN". See http://www.unicode.org/reports/tr35/ for technical
  /// details.
  String toLanguageTag() => _rawToString('-');

  String _rawToString(String separator) {
    final out = StringBuffer(languageCode);
    if (_countryCode != null && _countryCode!.isNotEmpty) {
      out.write('$separator$countryCode');
    }
    return out.toString();
  }
}

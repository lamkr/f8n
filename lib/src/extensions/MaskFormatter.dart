class MaskFormatter
{
  // Potential values in mask.
  static const _DIGIT_KEY = '#';
  /*static const _LITERAL_KEY = '\'';
  static const UPPERCASE_KEY = 'U';
  static const LOWERCASE_KEY = 'L';
  static const ALPHA_NUMERIC_KEY = 'A';
  static const CHARACTER_KEY = '?';
  static const ANYTHING_KEY = '*';
  static const HEX_KEY = 'H';*/

  final String _mask;

  String _text = '';

  /// Creates a [MaskFormatter] with the specified mask.
  MaskFormatter(this._mask);

  String format(String text) {
    if(text.isEmpty) {
      return '';
    }
    _text = text;
    final buf = StringBuffer();
    for( var index = 0; index < _mask.length && _text.isNotEmpty; index++ ) {
      final maskChar = _mask.substring(index, index+1);
      switch(maskChar) {
        case _DIGIT_KEY:
          final char = _nextChar();
          if(isDigit(char)) {
            buf.write(char);
          }
          break;
        default:
          buf.write(maskChar);
      }
    }
    return buf.toString();
  }

  String _nextChar() {
    var char = '';
    if( _text.isNotEmpty ) {
      char = _text.substring(0, 1);
      _text = _text.substring(1);
    }
    return char;
  }

  bool isDigit(String char) => int.tryParse(char) != null;
}

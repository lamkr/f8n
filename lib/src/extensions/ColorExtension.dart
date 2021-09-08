import 'dart:ui';

extension ColorExtension on Color
{
  String toFormattedString() =>
    '#${alpha.toRadixString(16).padLeft(2,'0')}'
    '${red.toRadixString(16).padLeft(2,'0')}'
    '${green.toRadixString(16).padLeft(2,'0')}'
    '${blue.toRadixString(16).padLeft(2,'0')}';
}

extension StringToColorExtension on String
{
  /// Construct a color from a hex code string, of the format #AARRGGBB
  /// or #RRGGBB. Or returns transparent if format is invalid.
  Color toColor() {
    if (length == 7) {
      return Color(0xFF000000 | int.parse(substring(1, 7), radix: 16));
    }
    else if (length == 9) {
      return Color(int.parse(substring(1, 9), radix: 16));
    }
    return Color(0x00000000); // transparent
  }
}
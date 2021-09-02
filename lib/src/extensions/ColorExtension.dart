import 'dart:ui';

extension ColorExtension on Color
{
  String toFormattedString() =>
    '#${alpha.toRadixString(16).padLeft(2,'0')}'
    '${red.toRadixString(16).padLeft(2,'0')}'
    '${green.toRadixString(16).padLeft(2,'0')}'
    '${blue.toRadixString(16).padLeft(2,'0')}';
}
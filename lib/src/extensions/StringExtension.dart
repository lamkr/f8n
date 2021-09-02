import 'dart:ui';

import 'package:intl/intl.dart';

extension StringExtension on String
{
  /// Construct a color from a hex code string, of the format #AARRGGBB
  /// or #RRGGBB. Or returns transparent if format is invalid.
  Color toColor() {
    if( length == 7 ) {
      return Color(0xFF000000 | int.parse(substring(1, 7), radix: 16));
    }
    else if( length == 9 ) {
      return Color(int.parse(substring(1, 9), radix: 16));
    }
    return Color(0x00000000); // transparent
  }

  double toDouble() => double.parse(this);

  /// Converte uma string para DateTime de acordo com o formato especificado.
  DateTime toDateTime({String format='yyyy-MM-dd HH:mm:ss'}) {
    return DateFormat(format).parse(this);
  }

  /// Remove o último caracter na útima posição da string
  /// caso ele exista.
  String removeCharAtLastPositionIfExists(String chr) {
    if( substring(length-1) == chr ) {
      return substring(0, length-1);
    }
    return this;
  }

  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String mid(int start, [int? size]) {
    if( size == null ) {
      return substring(start);
    }
    if( size > length ) {
      size = length;
    }
    return substring(start, start+size);
  }

  String right(int size) {
    if( size > length ) {
      size = length;
    }
    return substring( length-size );
  }

  String left(int size) {
    if( size > length ) {
      size = length;
    }
    return substring( 0, size );
  }
}
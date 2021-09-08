import 'package:intl/intl.dart';

extension StringExtension on String
{
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
import 'package:intl/intl.dart';

final invalidDateTime = DateTime(0,0,0,0,0,0,0,0);

extension DateTimeExtension on DateTime
{
  String toFormattedString([String format = 'yyyy-MM-dd HH:mm:ss']) {
    return DateFormat(format).format(this);
  }
}

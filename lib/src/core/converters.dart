import '../extensions/DateTimeExtension.dart';
import '../extensions/StringExtension.dart';

DateTime jsonToDateTime(json) {
  if( json == null ) {
    return invalidDateTime;
  }
  return json.toString().toDateTime();
}

double jsonToDouble(json) {
  if( json == null ) {
    return 0.0;
  }
  return json.toString().toDouble();
}

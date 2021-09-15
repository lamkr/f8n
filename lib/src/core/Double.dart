class Double
{
  static double tryParse(var value, double valueIfError) {
    if( value is int ) {
      return 0.0 + value;
    } else if( value is String ) {
      return double.parse(value);
    }
    return valueIfError;
  }
}
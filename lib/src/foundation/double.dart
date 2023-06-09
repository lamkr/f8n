class Double {
  static double tryParse(var value, double valueIfError) {
    if (value is int) {
      return 0.0 + value;
    }
    else if (value is String && value.isNotEmpty) {
      return double.parse(value);
    }
    else if (value is double) {
      return value;
    }
    return valueIfError;
  }

  static bool equals(double value1, double value2) =>
      (value1.isNaN && value2.isNaN) || value1 == value2;
}

extension DoubleExtension on double {
  bool greaterThan(double value) => compareTo(value) > 0;

  bool lessThan(double value) => compareTo(value) < 0;

  bool equals(double value) => compareTo(value) == 0;
}
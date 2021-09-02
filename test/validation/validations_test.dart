import 'package:cleanarch/src/validations/ValidationResult.dart';
import 'package:test/test.dart';

void main() {
  test('Given ValidationResult has empty attributes Then hasNotError returns true', () {
    final validation = ValidationResult('','');
    expect(validation.hasNotError, isTrue);
  });

  test('Given ValidationResult has memberName attribute filled Then hasNotError returns false', () {
    final validation = ValidationResult('memberName','');
    expect(validation.hasNotError, isFalse);
  });

  test('Given ValidationResult has errorMessage  attribute filled Then hasNotError returns false', () {
    final validation = ValidationResult('','errorMessage');
    expect(validation.hasNotError, isFalse);
  });

  test('Given ValidationResult.success Then hasNotError returns true', () {
    final validation = ValidationResult.success();
    expect(validation.hasNotError, isTrue);
  });
}

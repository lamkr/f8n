import 'package:cleanarch/validations.dart';

abstract class IValidatable
{
  bool get isValid;

  List<ValidationResult> validate();
}
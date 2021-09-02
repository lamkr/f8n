import 'package:f8n/validations.dart';

abstract class IValidatable
{
  bool get isValid;

  List<ValidationResult> validate();
}
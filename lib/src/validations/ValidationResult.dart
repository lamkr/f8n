/// Represents the validation result of an attribute in a class.
class ValidationResult {
  final String memberName;
  final String errorMessage;

  ValidationResult(this.memberName, this.errorMessage);

  ValidationResult.success() : this('','');

  /// Validation is well succeeded if [memberName] and [errorMessage] are empty.
  bool get hasNotError => memberName.isEmpty && errorMessage.isEmpty;

  /// Validation has error when [memberName] or [errorMessage] aren't empty.
  bool get hasError => !hasNotError;

  @override
  bool operator ==(Object other) {
    return (other is ValidationResult)
        && other.memberName == memberName
        && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => memberName.hashCode ^ errorMessage.hashCode;

  @override
  String toString() => '$memberName: $errorMessage';
}
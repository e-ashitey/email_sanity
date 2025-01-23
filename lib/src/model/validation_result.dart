class ValidationResult {
  final bool isValid;
  final String? errorCode;
  final String? errorMessage;

  ValidationResult({
    required this.isValid,
    this.errorCode,
    this.errorMessage,
  });
}

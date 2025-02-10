/// A class to represent the result of an email validation.
class ValidationResult {
  /// A boolean value indicating if the email is valid.
  final bool isValid;

  /// An optional error message if the email is invalid.
  final String? error;

  /// Constructor to create a ValidationResult instance.
  ValidationResult({required this.isValid, this.error});
}

/// An enum to represent the possible email validation errors.
enum EmailValidationError {
  /// The email is required.
  requireEmail,

  /// The email format is invalid.
  invalidFormat,

  /// The email is missing the '@' symbol.
  missingAtSymbol,

  /// The email is missing the local part before the '@' symbol.
  missingLocalPart,

  /// The email is missing the domain part after the '@' symbol.
  missingDomain,

  /// The email domain is invalid or does not include a '.' (e.g., gmail.com).
  invalidDomain,

  /// The email domain is not supported by this service.
  domainNotSupported,

  /// The email uses a top-level domain that is not allowed.
  topLevelDomainNotAllowed,

  /// The email provider is not recognized.
  unknownProvider,

  /// The email provider or alias is not recognized.
  invalidAlias,

  /// Internationalized email addresses are not supported.
  internationalEmailNotSupported,

  /// The email alias does not match any supported provider aliases.
  disallowedTopLevelDomain,
}

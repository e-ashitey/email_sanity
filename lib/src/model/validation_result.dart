/// A class to represent the result of an email validation.
class ValidationResult {
  /// A boolean value indicating if the email is valid.
  final bool isValid;

  /// An optional error message if the email is invalid.
  final EmailValidationError? error;

  /// Constructor to create a ValidationResult instance.
  ValidationResult({required this.isValid, this.error});

  /// Get the error message if the email is invalid.
  String? get errorMessage => error?.message;
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

/// Extension to add error messages
extension EmailValidationErrorMessage on EmailValidationError {
  /// Get the error message for the email validation error.
  String get message {
    switch (this) {
      case EmailValidationError.requireEmail:
        return "Email is required";
      case EmailValidationError.invalidFormat:
        return "The email format is invalid.";
      case EmailValidationError.missingAtSymbol:
        return "The email must contain the '@' symbol.";
      case EmailValidationError.invalidDomain:
        return "The email domain is invalid or does not include a '.' (e.g., gmail.com).";
      default:
        return "";
      // case EmailValidationError.missingLocalPart:
      //   return "The email is missing the local part before the '@' symbol.";
      // case EmailValidationError.missingDomain:
      //   return "The email is missing the domain part after the '@' symbol.";
      // case EmailValidationError.domainNotSupported:
      //   return "The email domain is not supported by this service.";
      // case EmailValidationError.topLevelDomainNotAllowed:
      //   return "The email uses a top-level domain that is not allowed.";
      // case EmailValidationError.unknownProvider:
      //   return "The email provider or alias is not recognized.";
      // case EmailValidationError.invalidAlias:
      //   return "The email alias does not match any supported provider aliases.";
      // case EmailValidationError.internationalEmailNotSupported:
      //   return "Internationalized email addresses are not supported.";
      // case EmailValidationError.disallowedTopLevelDomain:
      //   return "Emails with this top-level domain are not allowed.";
    }
  }
}

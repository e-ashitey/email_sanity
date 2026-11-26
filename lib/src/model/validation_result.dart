/// Result of an email validation attempt.
class ValidationResult {
  /// Whether the address passed validation.
  final bool isValid;

  /// Specific failure reason when [isValid] is false.
  final EmailValidationError? error;

  /// Creates a validation result.
  const ValidationResult({required this.isValid, this.error});

  /// Human-readable message for [error], or null when the address is valid.
  String? get errorMessage => error?.message;
}

/// Discrete email validation failure reasons.
enum EmailValidationError {
  /// The email value was empty or only whitespace.
  requireEmail,

  /// The address failed general format validation.
  invalidFormat,

  /// The address does not contain `@`.
  missingAtSymbol,

  /// The local part before `@` is missing.
  missingLocalPart,

  /// The domain part after `@` is missing.
  missingDomain,

  /// A known provider alias is paired with a domain that provider does not use.
  invalidDomain,

  /// The domain is not supported by this package's rules.
  domainNotSupported,

  /// A top-level domain was used when top-level domains are disallowed.
  topLevelDomainNotAllowed,

  /// The provider could not be recognized.
  unknownProvider,

  /// The provider alias is not recognized.
  invalidAlias,

  /// Internationalized addresses are not supported under the current options.
  internationalEmailNotSupported,

  /// The top-level domain is not allowed.
  disallowedTopLevelDomain,
}

/// Human-readable messages for [EmailValidationError].
extension EmailValidationErrorMessage on EmailValidationError {
  /// Message suitable for form feedback.
  String get message {
    switch (this) {
      case EmailValidationError.requireEmail:
        return 'Email is required.';
      case EmailValidationError.invalidFormat:
        return 'The email format is invalid.';
      case EmailValidationError.missingAtSymbol:
        return "The email must contain the '@' symbol.";
      case EmailValidationError.missingLocalPart:
        return 'The email is missing the local part before the @ symbol.';
      case EmailValidationError.missingDomain:
        return 'The email is missing the domain part after the @ symbol.';
      case EmailValidationError.invalidDomain:
        return 'The email domain does not match a known domain for this provider.';
      case EmailValidationError.domainNotSupported:
        return 'The email domain is not supported.';
      case EmailValidationError.topLevelDomainNotAllowed:
        return 'Emails that use only a top-level domain are not allowed.';
      case EmailValidationError.unknownProvider:
        return 'The email provider is not recognized.';
      case EmailValidationError.invalidAlias:
        return 'The email provider alias is not recognized.';
      case EmailValidationError.internationalEmailNotSupported:
        return 'Internationalized email addresses are not supported.';
      case EmailValidationError.disallowedTopLevelDomain:
        return 'Emails with this top-level domain are not allowed.';
    }
  }
}

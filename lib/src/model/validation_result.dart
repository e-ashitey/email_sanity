class ValidationResult {
  final bool isValid;
  final EmailValidationError? error;

  ValidationResult({required this.isValid, this.error});

  String? get errorMessage => error?.message;
}

enum EmailValidationError {
  requireEmail,
  invalidFormat,
  missingAtSymbol,
  missingLocalPart,
  missingDomain,
  invalidDomain,
  domainNotSupported,
  topLevelDomainNotAllowed,
  unknownProvider,
  invalidAlias,
  internationalEmailNotSupported,
  disallowedTopLevelDomain,
}

// Extension to add error messages
extension EmailValidationErrorMessage on EmailValidationError {
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

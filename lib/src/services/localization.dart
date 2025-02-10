import 'package:email_sanity/src/model/validation_result.dart';

/// Localizations for email sanity error messages.
class EmailSanityLocalizations {
  static final Map<String, Map<EmailValidationError, String>>
      _localizedMessages = {
    'en': {
      EmailValidationError.requireEmail: "Email is required",
      EmailValidationError.invalidFormat: "The email format is invalid",
      EmailValidationError.missingAtSymbol:
          "The email must contain the '@' symbol",
      EmailValidationError.invalidDomain:
          "The email domain is invalid or does not include a '.' (e.g., gmail.com)",
    },
    'fr': {
      EmailValidationError.requireEmail: "L'email est requis",
      EmailValidationError.invalidFormat: "Le format de l'email est invalide",
      EmailValidationError.missingAtSymbol:
          "L'email doit contenir le symbole '@'",
      EmailValidationError.invalidDomain:
          "Le domaine de l'email est invalide ou ne contient pas de '.' (par exemple, gmail.com)",
    },
    'es': {
      EmailValidationError.requireEmail: "Se requiere un correo electrónico",
      EmailValidationError.invalidFormat:
          "El formato del correo electrónico no es válido",
      EmailValidationError.missingAtSymbol:
          "El correo electrónico debe contener el símbolo '@'",
      EmailValidationError.invalidDomain:
          "El dominio del correo electrónico no es válido o no incluye un '.' (por ejemplo, gmail.com)",
    }
  };

  /// Get the localized error message for the email validation error.
  static String getMessage(EmailValidationError error, {String locale = 'en'}) {
    return _localizedMessages[locale]?[error] ??
        _localizedMessages['en']![error]!;
  }
}

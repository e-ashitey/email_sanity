/// The `EmailSanity` class provides methods to validate email addresses.
///
/// This class offers both general email validation and provider-specific
/// validation. It uses the `email_validator` package for general validation
/// and custom logic for provider-specific validation.
library email_sanity;

/// Validates an email address.
///
/// This method performs general email validation and provider-specific
/// validation. It returns `true` if the email is valid, otherwise `false`.
///
/// - Parameters:
///   - email: The email address to validate.
///   - allowTopLevelDomains: Whether to allow top-level domains (e.g., "example@com").
///   - allowInternational: Whether to allow international characters in the email address.
///
/// - Returns: `true` if the email is valid, otherwise `false`.
// static bool validate(String email,
//   [bool allowTopLevelDomains = false, bool allowInternational = true]);

/// Validates an email address and provides detailed validation results.
///
/// This method performs general email validation and provider-specific
/// validation. It returns a `ValidationResult` object containing the
/// validation status and any errors encountered.
///
/// - Parameters:
///   - email: The email address to validate.
///   - allowTopLevelDomains: Whether to allow top-level domains (e.g., "example@com").
///   - allowInternational: Whether to allow international characters in the email address.
///
/// - Returns: A `ValidationResult` object containing the validation status and any errors encountered.
// static ValidationResult validateWithDetails(
//   String email, [
//   bool allowTopLevelDomains = false,
//   bool allowInternational = true,
// ]);

import 'package:email_sanity/src/services/email_sanity_config.dart';
import 'package:email_sanity/src/model/validation_result.dart';
import 'package:email_sanity/src/services/localization.dart';
import 'package:email_validator/email_validator.dart';

/// Entry point for the email sanity package
class EmailSanity {
  /// Validates an email address.
  static bool validate(String email,
      [bool allowTopLevelDomains = false, bool allowInternational = true]) {
    // Check if the email is valid (general validation)
    final result = validateWithDetails(email,
        allowTopLevelDomains: allowTopLevelDomains,
        allowInternational: allowInternational);

    // Check if the email is valid based on the email provider (specific validation)
    return result.isValid;
  }

  /// Validates an email address and provides detailed validation results.
  static ValidationResult validateWithDetails(
    String email, {
    bool allowTopLevelDomains = false,
    bool allowInternational = true,
    String locale = 'en',
  }) {
    // Step 1: Check if email is empty
    if (email.isEmpty) {
      return ValidationResult(
        isValid: false,
        error: EmailSanityLocalizations.getMessage(
            EmailValidationError.requireEmail,
            locale: locale),
      );
    }

    // Step 2: Check if email contains "@"
    if (!email.contains('@')) {
      return ValidationResult(
        isValid: false,
        error: EmailSanityLocalizations.getMessage(
            EmailValidationError.missingAtSymbol,
            locale: locale),
      );
    }

    // Step 3: General email validation
    if (!EmailValidator.validate(
        email, allowTopLevelDomains, allowInternational)) {
      return ValidationResult(
        isValid: false,
        error: EmailSanityLocalizations.getMessage(
            EmailValidationError.invalidFormat,
            locale: locale),
      );
    }

    // Step 4: Provider-specific validation
    return EmailSanityConfig.sanitize(email);
  }
}

library email_sanity;

import 'package:email_sanity/src/services/email_sanity_config.dart';
import 'package:email_sanity/src/model/validation_result.dart';
import 'package:email_validator/email_validator.dart';

// Entry point for the email sanity package
class EmailSanity {
  static bool validate(String email,
      [bool allowTopLevelDomains = false, bool allowInternational = true]) {
    // Check if the email is valid (general validation)
    final result =
        validateWithDetails(email, allowTopLevelDomains, allowInternational);

    // Check if the email is valid based on the email provider (specific validation)
    return result.isValid;
  }

  static ValidationResult validateWithDetails(
    String email, [
    bool allowTopLevelDomains = false,
    bool allowInternational = true,
  ]) {
    // Step 1: Check if email contains "@"
    if (!email.contains('@')) {
      return ValidationResult(
        isValid: false,
        error: EmailValidationError.missingAtSymbol,
      );
    }

    // Step 2: General email validation
    if (!EmailValidator.validate(
        email, allowTopLevelDomains, allowInternational)) {
      return ValidationResult(
        isValid: false,
        error: EmailValidationError.invalidFormat,
      );
    }

    // Step 3: Provider-specific validation
    return EmailSanityConfig.sanitize(email);
  }
}

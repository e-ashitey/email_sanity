import 'package:email_sanity/src/model/validation_result.dart';
import 'package:email_sanity/src/services/email_sanity_config.dart';
import 'package:email_validator/email_validator.dart';

/// Validates email addresses with syntax checks and known-provider domain rules.
///
/// Syntax validation is delegated to `email_validator`. When the first label of
/// the host matches a known provider alias (for example `gmail`), the full host
/// must be one of that provider's allowed domains (for example `gmail.com`).
class EmailSanity {
  /// Returns whether [email] is syntactically valid and uses an allowed
  /// known-provider domain when applicable.
  ///
  /// Leading and trailing whitespace is ignored. Unknown hosts that pass
  /// syntax validation are accepted.
  static bool validate(
    String email, {
    bool allowTopLevelDomains = false,
    bool allowInternational = true,
  }) {
    return validateWithDetails(
      email,
      allowTopLevelDomains: allowTopLevelDomains,
      allowInternational: allowInternational,
    ).isValid;
  }

  /// Validates [email] and returns a [ValidationResult] with an error code
  /// when validation fails.
  static ValidationResult validateWithDetails(
    String email, {
    bool allowTopLevelDomains = false,
    bool allowInternational = true,
  }) {
    final normalized = email.trim();

    if (normalized.isEmpty) {
      return const ValidationResult(
        isValid: false,
        error: EmailValidationError.requireEmail,
      );
    }

    if (!normalized.contains('@')) {
      return const ValidationResult(
        isValid: false,
        error: EmailValidationError.missingAtSymbol,
      );
    }

    if (!EmailValidator.validate(
      normalized,
      allowTopLevelDomains,
      allowInternational,
    )) {
      return const ValidationResult(
        isValid: false,
        error: EmailValidationError.invalidFormat,
      );
    }

    return EmailSanityConfig.sanitize(normalized);
  }
}

import 'package:email_sanity/src/model/validation_result.dart';

import '../model/email_provider.dart';

class EmailSanityConfig {
  // // Get provider by name
  // static EmailProvider? getProvider(String name) =>
  //     EmailProvider.providers[name];

  // Method to check if the email is valid based on the email provider
  static ValidationResult sanitize(String email) {
    for (var provider in EmailProvider.providers.values) {
      var aliases = provider.aliases.toSet();
      var domains = provider.domains.toSet();

      for (var alias in aliases) {
        // Check if the email has the alias
        String afterAt = email.split('@').length > 1 ? email.split('@')[1] : '';
        // Get the word before the first dot (if any)
        String word = afterAt.contains('.') ? afterAt.split('.')[0] : '';

        // Check if the email has the alias
        bool hasAlias = word.toLowerCase() == alias;
        if (hasAlias) {
          bool isDomainValid = domains.any((domain) => email.endsWith(domain));
          if (!isDomainValid) {
            return ValidationResult(
              isValid: false,
              error: EmailValidationError.invalidDomain,
              // errorMessage:
              //     "Email domain '$afterAt' does not match any of the allowed domains for alias '$alias'.",
            );
          }
          return ValidationResult(isValid: true);
        }
      }
    }
    return ValidationResult(isValid: true);
  }
}

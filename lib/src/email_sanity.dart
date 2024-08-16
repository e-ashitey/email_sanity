library email_sanity;

import 'package:email_sanity/src/model/config_checkers.dart';
import 'package:email_validator/email_validator.dart';

// Entry point for the email sanity package
class EmailSanity {
  static bool validate(String email,
      [bool allowTopLevelDomains = false, bool allowInternational = true]) {
    // Check if the email is valid (general validation)
    if (!EmailValidator.validate(
        email, allowTopLevelDomains, allowInternational)) {
      return false; // Exit early if the email is not valid
    }

    // Check if the email is valid based on the email provider (specific validation)
    return _sanityCheck(email);
  }

  // Method to check if the email is valid based on the email provider
  static bool _sanityCheck(String email) {
    bool isSane = true;
    configCheckers.forEachProvider((_, provider) {
      var aliases = provider.aliases.toSet();
      var domains = provider.domains.toSet();

      for (var alias in aliases) {
        // Split the email address at the "@" symbol
        String afterAt = email.split('@')[1];

        // Extract the word before the first dot
        String word = afterAt.split('.')[0];

        // Check if the second part (after the "@") contains "ask"
        bool hasAlias = word.toLowerCase() == alias;
        if (hasAlias) {
          // Check if any domain matches
          isSane = domains.any((domain) => email.endsWith(domain));

          // Exit the loop early since the email has been validated
          break;
        }
      }
    });

    return isSane;
  }
}

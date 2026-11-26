import 'package:email_sanity/src/model/email_provider.dart';
import 'package:email_sanity/src/model/validation_result.dart';

/// Applies known-provider domain rules after syntax validation succeeds.
class EmailSanityConfig {
  /// Returns whether [email] uses a known provider alias with an allowed host.
  ///
  /// Unknown hosts are accepted. Hosts whose first label matches a known
  /// provider alias must equal one of that provider's full domains.
  static ValidationResult sanitize(String email) {
    final host = _hostOf(email);
    if (host == null || host.isEmpty) {
      return const ValidationResult(isValid: true);
    }

    for (final provider in EmailProvider.providers.values) {
      for (final alias in provider.aliases) {
        final firstLabel = host.split('.').first;
        if (firstLabel != alias) {
          continue;
        }

        final isAllowed = provider.domains.any(
          (suffix) => host == '$alias$suffix',
        );
        if (!isAllowed) {
          return const ValidationResult(
            isValid: false,
            error: EmailValidationError.invalidDomain,
          );
        }

        return const ValidationResult(isValid: true);
      }
    }

    return const ValidationResult(isValid: true);
  }

  /// Host part after the last `@`, lowercased. Returns null when `@` is absent.
  static String? _hostOf(String email) {
    final at = email.lastIndexOf('@');
    if (at < 0 || at == email.length - 1) {
      return null;
    }
    return email.substring(at + 1).toLowerCase();
  }
}

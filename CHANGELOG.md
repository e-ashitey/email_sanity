## 0.2.0

- Match known-provider hosts exactly against alias + domain (case-insensitive).
- Reject lookalike domains such as `gmail.com.attacker.com` and `me.company.com`.
- Fix Yahoo country domains (`co.jp`, `com.au`, `com.br`, `co.in`) and remove the invalid `.j` suffix.
- Remove Microsoft `.co` so typos like `hotmail.co` are rejected.
- Parse the host after the last `@` so quoted local parts cannot skip provider checks.
- Trim leading and trailing whitespace before validation.
- Export `ValidationResult` and `EmailValidationError` from the package barrel.
- Provide messages for every `EmailValidationError` value.
- Switch `validate` / `validateWithDetails` options to named parameters.
- Convert the package to pure Dart (no Flutter SDK dependency).
- Fix typo-test assertions so each address under test is validated.
- Add GitHub Actions CI, `.pubignore`, and align README / LICENSE with the release.

## 0.1.0

- Added support for validation error codes and messages.
- Refactored configuration into a consolidated class.

## 0.0.1

- Initial release.

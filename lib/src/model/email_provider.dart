/// Known consumer email providers and the domains they own.
///
/// Each provider lists mailbox labels ([aliases]) and the domain suffixes that
/// are valid when combined with those labels. A host is accepted only when it
/// exactly equals `alias + suffix` (for example `gmail` + `.com`).
class EmailProvider {
  /// First labels that identify this provider (for example `gmail`, `yahoo`).
  final List<String> aliases;

  /// Domain suffixes allowed for [aliases] (for example `.com`, `.co.uk`).
  final List<String> domains;

  /// Creates a provider definition.
  const EmailProvider({required this.aliases, required this.domains});

  /// Built-in provider table used by Email Sanity.
  static const Map<String, EmailProvider> providers = {
    'google': EmailProvider(
      aliases: ['gmail', 'googlemail'],
      domains: ['.com'],
    ),
    'yahoo': EmailProvider(
      aliases: ['yahoo', 'ymail', 'rocketmail'],
      domains: [
        '.com',
        '.co.uk',
        '.fr',
        '.de',
        '.ca',
        '.it',
        '.com.au',
        '.es',
        '.com.br',
        '.co.in',
        '.co.jp',
      ],
    ),
    'microsoft': EmailProvider(
      aliases: ['outlook', 'hotmail', 'live', 'msn'],
      domains: ['.com', '.de', '.co.uk', '.nl'],
    ),
    'apple': EmailProvider(
      aliases: ['icloud', 'me', 'mac'],
      domains: ['.com'],
    ),
    'yandex': EmailProvider(
      aliases: ['yandex'],
      domains: ['.com', '.ru', '.ua', '.kz', '.by'],
    ),
    'fastmail': EmailProvider(
      aliases: ['fastmail'],
      domains: ['.com', '.fm'],
    ),
  };
}

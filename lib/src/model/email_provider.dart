class EmailProvider {
  final List<String> aliases;
  final List<String> domains;

  EmailProvider({required this.aliases, required this.domains});

  // Define email providers and their aliases/domains
  static final Map<String, EmailProvider> providers = {
    "google": EmailProvider(
      aliases: ["gmail", "googlemail"],
      domains: [".com"],
    ),
    "yahoo": EmailProvider(
      aliases: ["yahoo", "ymail", "rocketmail"],
      domains: [
        ".com",
        ".co.uk",
        ".fr",
        ".de",
        ".ca",
        ".it",
        ".au",
        ".es",
        ".br",
        ".in",
        ".j"
      ],
    ),
    "microsoft": EmailProvider(
      aliases: ["outlook", "hotmail", "live", "msn"],
      domains: [".com", ".co", ".de", ".co.uk", ".nl"],
    ),
    "apple": EmailProvider(
      aliases: ["icloud", "me", "mac"],
      domains: [".com"],
    ),
    "yandex": EmailProvider(
      aliases: ["yandex"],
      domains: [".com", ".ru", ".ua", ".kz", ".by"],
    ),
    "fastmail": EmailProvider(
      aliases: ["fastmail"],
      domains: [".com", ".fm"],
    ),
  };
}

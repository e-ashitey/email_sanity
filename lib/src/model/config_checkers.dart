// Email config checkers
import 'package:email_sanity/src/model/email_config.dart';
import 'package:email_sanity/src/model/email_provider.dart';

EmailConfig get configCheckers => EmailConfig(
      google: EmailProvider(
        aliases: ["gmail", "googlemail"],
        domains: [".com"],
      ),
      yahoo: EmailProvider(
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
      microsoft: EmailProvider(
        aliases: ["outlook", "hotmail", "live", "msn"],
        domains: [".com", ".co", ".de"],
      ),
      apple: EmailProvider(
        aliases: ["icloud", "me", "mac"],
        domains: [".com"],
      ),
      yandex: EmailProvider(
        aliases: ["yandex"],
        domains: [".com", ".ru", ".ua", ".kz", ".by"],
      ),
      fastmail: EmailProvider(
        aliases: ["fastmail"],
        domains: [".com", ".fm"],
      ),
    );

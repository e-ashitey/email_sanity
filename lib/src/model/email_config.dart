import 'package:email_sanity/src/model/email_provider.dart';

class EmailConfig {
  final EmailProvider google;
  final EmailProvider yahoo;
  final EmailProvider microsoft;
  final EmailProvider apple;
  final EmailProvider yandex;
  final EmailProvider fastmail;

  EmailConfig(
      {required this.google,
      required this.yahoo,
      required this.microsoft,
      required this.apple,
      required this.yandex,
      required this.fastmail});

  // Method to get the map of providers and their associated Apple instances
  Map<String, EmailProvider> get emailProviders => {
        'google': google,
        'yahoo': yahoo,
        'microsoft': microsoft,
        'apple': apple,
        'yandex': yandex,
        'fastmail': fastmail,
      };

  // Method to loop through each provider/element
  void forEachProvider(void Function(String key, EmailProvider value) action) {
    emailProviders.forEach(action);
  }
}

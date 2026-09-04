class AppConfig {
  /// Número de WhatsApp para ventas de Premium
  static const String whatsappNumber = '51955285763';

  /// Clave de API de Groq para el tutor de IA.
  /// Puede ser configurada al compilar con: --dart-define=GROQ_API_KEY=tu_clave
  static const String groqApiKey = String.fromEnvironment(
    'GROQ_API_KEY',
    defaultValue: '',
  );

  /// Clave de API de DeepL para traducción de preguntas de cultura general.
  /// Puede ser configurada al compilar con: --dart-define=DEEPL_API_KEY=tu_clave
  static const String deeplApiKey = String.fromEnvironment(
    'DEEPL_API_KEY',
    defaultValue: '',
  );

  /// URL oficial de descarga directa para la última versión del APK de Android.
  static const String androidApkDownloadUrl =
      'https://download1475.mediafire.com/h4gzkl223wxgZPUmgBnHQAT7rn3o5T8nyjg_NILtOEWpl43suUPD8fKOxadNnW1_5j5Oa1QPnSiUlfbJHBmqoPyj0KIUz7HIEmgkr4Pqo3cf0k8pgiK3lN30UNzhFgdYsjfgAWmh5MjCJWGJ3ZO7EIqOVUNgtwQxPtDNU9aBgiEgiA/rpen8pn1vkkm0kh/edupol-release.apk';

  /// URL oficial de descarga directa para la versión de macOS (Apple Silicon & Intel).
  static const String macDownloadUrl =
      'https://download1655.mediafire.com/10kvb95b9v3gOoPNX7JrcGuUCYNVVEVwrPvAUqTdqNb6QkpKEHyTjcWR5Fa9MFa8C6UTtALf1j4rrKZqunaF6MZ1jtupJMy3FicfdKtErDgXlMbwWsly-gAUJP-qIMVfqvfQJJJQQ8l-nbsP3rVZHjAUAdHfF3lVLHMZmj01DNtKNQ/9qylzqiawc4bufz/Edupol_macOS.dmg';

  /// URL para Windows (desactivada, sólo se ofrece Android y Mac)
  static const String? windowsDownloadUrl = null;
}

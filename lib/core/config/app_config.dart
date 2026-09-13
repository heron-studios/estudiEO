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

  /// URL oficial de descarga e instalación desde Google Play Store.
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.edupol.radar';
}

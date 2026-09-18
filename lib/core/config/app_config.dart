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
      'https://www.mediafire.com/file/zvsyh4o6wl08yn8/edupol.apk/file';

  /// URL oficial de descarga e instalación desde Google Play Store.
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.edupol.radar';
}

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
      'https://download1475.mediafire.com/dbtnqhk1udogq88D7M-2jZ6XPWnMmLUPxlwMkRN6a0rcB6JYyMPW8NCrBpAD68FMUw15Eqoa0ZMgPITRqhfV5cruBK4CQrgAQ3zZ0q2lK-nF3bLNFhDHYfgIgmh-t8-CaO4tmt52qDd8HvNNtTJhNKHSPhoiSfllao4nuM02ADrfGg/rpen8pn1vkkm0kh/edupol-release.apk';

  /// URLs para instaladores de escritorio (Windows y macOS)
  static const String? windowsDownloadUrl = null;
  static const String? macDownloadUrl = null;
}

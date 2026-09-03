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
      'https://download1581.mediafire.com/n621rsaj0wngnPXE8w9yty-5tN5rCtp6Tkn1YpVP4VTh3OVKheSd1fICUxKeJgSgLzBP5MW_ukGDd4LYeyu8uQq31axzeGnJiQcrp6DlljpTEpMQOpnvehtRkVfKr4AfneBpss98Yn1wtOaLYMDY2G0OlwB2CJ7z4yxd0g6ZKxWjAw/rpen8pn1vkkm0kh/edupol-release.apk';

  /// URLs para instaladores de escritorio (Windows y macOS)
  static const String? windowsDownloadUrl = null;
  static const String? macDownloadUrl = null;
}

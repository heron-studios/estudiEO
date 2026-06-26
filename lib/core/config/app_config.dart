
class AppConfig {

  /// Número de WhatsApp para ventas de Premium
  static const String whatsappNumber = '51955285763';

  /// Clave de API de Gemini para el tutor nemotécnico de IA.
  /// Puede ser configurada al compilar con: --dart-define=GEMINI_API_KEY=tu_clave
  static const String geminiApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: '',
  );

  /// Clave de API de DeepL para traducción de preguntas de cultura general.
  /// Puede ser configurada al compilar con: --dart-define=DEEPL_API_KEY=tu_clave
  static const String deeplApiKey = String.fromEnvironment(
    'DEEPL_API_KEY',
    defaultValue: '',
  );
}

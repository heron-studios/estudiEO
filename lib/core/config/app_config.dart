
class AppConfig {
  /// Establece si la aplicación está en modo demostración.
  /// En modo demo, solo se permite acceso a 20 preguntas y el simulacro de examen es reducido.
  static bool get isDemoMode =>
      const bool.fromEnvironment('DEMO_MODE', defaultValue: false);

  /// Número de WhatsApp para ventas de Premium
  static const String whatsappNumber = '51955285763';

  /// Clave de API de Gemini para el tutor nemotécnico Alipio.
  /// Puede ser configurada al compilar con: --dart-define=GEMINI_API_KEY=tu_clave
  static const String geminiApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: '',
  );
}

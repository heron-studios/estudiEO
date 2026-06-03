import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn/core/config/app_config.dart';

class GeminiService {
  static const String _apiKey = AppConfig.geminiApiKey;
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  /// Genera un concepto nemotécnico/explicación corta para reforzar una tarjeta.
  /// Porta la lógica de GeminiGenerator.explainConcept() de Memoriza-PNP.
  static Future<String> explicarConcepto(String pregunta, String respuesta) async {
    const systemPrompt =
        'Eres Alipio, un tutor amigable experto para postulantes a la EO PNP. '
        'Dado un par pregunta-respuesta, genera UN concepto nemotécnico o truco de memoria '
        'en máximo 3 líneas cortas, usando analogías, acrónimos o imágenes mentales divertidas '
        'para que el estudiante recuerde la respuesta para siempre. '
        'Sé creativo, claro y directo. No repitas la pregunta ni la respuesta textual.';

    final userPrompt = 'Pregunta: $pregunta\nRespuesta: $respuesta';

    return _callGemini(systemPrompt, userPrompt);
  }

  /// Genera un consejo breve y motivador basado en el progreso actual del usuario.
  static Future<String> darConsejoPersonalizado(Map<String, dynamic> stats) async {
    const systemPrompt =
        'Eres Alipio, un tutor de Inteligencia Artificial para postulantes a la EO PNP. '
        'Recibirás estadísticas del estudiante (tarjetas nuevas, aprendiendo, dominadas, por revisar). '
        'Tu tarea es dar un consejo ultra-corto (máximo 2 líneas) y motivador. '
        'Si hay muchas tarjetas "por revisar", motívalo a repasarlas. Si hay muchas "dominadas", felicítalo. '
        'Usa un tono directo, militar, pero amigable.';

    final userPrompt = 
        'Nuevas: ${stats['new']}, Aprendiendo: ${stats['learning']}, '
        'Dominadas: ${stats['mastered']}, Por revisar: ${stats['overdue']}';

    return _callGemini(systemPrompt, userPrompt);
  }

  /// Explica por qué una respuesta es incorrecta y resalta la correcta.
  static Future<String> explicarError(String pregunta, String respElegida, String respCorrecta) async {
    const systemPrompt =
        'Eres Alipio, tutor experto para postulantes PNP. '
        'El estudiante falló una pregunta. Recibirás la pregunta, la respuesta que él eligió (incorrecta) y la respuesta correcta. '
        'Tu tarea es explicar, en máximo 3-4 líneas claras, por qué su opción es incorrecta y por qué la correcta es la verdadera. '
        'Sé empático, didáctico y fomenta el aprendizaje.';

    final userPrompt = 
        'Pregunta: $pregunta\n'
        'El estudiante respondió: $respElegida\n'
        'Respuesta correcta: $respCorrecta';

    return _callGemini(systemPrompt, userPrompt);
  }

  /// Llama a la API de Gemini con system + user prompt. Retorna el texto generado.
  static Future<String> _callGemini(String system, String user) async {
    final uri = Uri.parse('$_baseUrl?key=$_apiKey');

    final body = jsonEncode({
      'systemInstruction': {
        'parts': [
          {'text': system}
        ]
      },
      'contents': [
        {
          'parts': [
            {'text': user}
          ]
        }
      ],
      'generationConfig': {
        'temperature': 0.7,
        'maxOutputTokens': 200,
      }
    });

    try {
      final response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: body,
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final text = json['candidates']?[0]?['content']?['parts']?[0]?['text'];
        if (text != null && text.toString().trim().isNotEmpty) {
          return text.toString().trim();
        }
        return 'Alipio no pudo generar una explicación esta vez.';
      } else {
        return 'Error de conexión (${response.statusCode}). Verifica tu internet.';
      }
    } catch (e) {
      return 'No se pudo conectar con Alipio: ${e.toString().split(':').first}.';
    }
  }
}

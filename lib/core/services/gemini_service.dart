import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn/core/config/app_config.dart';

class GeminiService {
  static const String _apiKey = AppConfig.groqApiKey;
  static const String _baseUrl =
      'https://api.groq.com/openai/v1/chat/completions';

  /// Genera un concepto nemotécnico/explicación corta para reforzar una tarjeta.
  static Future<String> explicarConcepto(String pregunta, String respuesta) async {
    const systemPrompt =
        'Eres un tutor amigable experto en técnicas de estudio para la EO PNP. '
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
        'Eres un tutor de Inteligencia Artificial para postulantes a la EO PNP. '
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
        'Eres un tutor experto para postulantes PNP. '
        'El estudiante falló una pregunta. Recibirás la pregunta, la respuesta que él eligió (incorrecta) y la respuesta correcta. '
        'Tu tarea es explicar, en máximo 3-4 líneas claras, por qué su opción es incorrecta y por qué la correcta es la verdadera. '
        'Sé empático, didáctico y fomenta el aprendizaje.';

    final userPrompt = 
        'Pregunta: $pregunta\n'
        'El estudiante respondió: $respElegida\n'
        'Respuesta correcta: $respCorrecta';

    return _callGemini(systemPrompt, userPrompt);
  }

  /// Llama a la API de Groq con system + user prompt. Retorna el texto generado.
  static Future<String> _callGemini(String system, String user) async {
    final uri = Uri.parse(_baseUrl);

    final body = jsonEncode({
      'model': 'llama-3.3-70b-versatile',
      'messages': [
        {'role': 'system', 'content': system},
        {'role': 'user', 'content': user}
      ],
      'temperature': 0.7,
      'max_completion_tokens': 200,
    });

    try {
      final response = await http
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $_apiKey',
            },
            body: body,
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final text = json['choices']?[0]?['message']?['content'];
        if (text != null && text.toString().trim().isNotEmpty) {
          return text.toString().trim();
        }
        return 'El tutor no pudo generar una explicación esta vez.';
      } else {
        return 'Error de conexión (${response.statusCode}). Verifica tu internet.';
      }
    } catch (e) {
      return 'No se pudo conectar con el tutor: ${e.toString().split(':').first}.';
    }
  }

  /// Traduce preguntas de trivia del inglés al español usando Gemini 2.0 Flash.
  static Future<List<dynamic>> translateTriviaQuestions(List<dynamic> questions) async {
    const systemPrompt =
        'Eres un traductor experto de inglés a español neutro. '
        'Se te proporcionará una lista de preguntas de trivia en formato JSON. '
        'Tu tarea es traducir al español los campos de texto: "question" -> "text" (debe ser traducida la pregunta), "correctAnswer" e "incorrectAnswers". '
        'Conserva la estructura exacta del JSON (mismos IDs, categorías, etc.). '
        'Devuelve ÚNICAMENTE el código JSON traducido, sin bloques de código de markdown (no uses ```json ni ```), sin texto explicativo. '
        'El resultado debe ser un array JSON válido.';

    final userPrompt = jsonEncode(questions);

    try {
      final responseText = await _callGemini(systemPrompt, userPrompt);
      String cleanJson = responseText.trim();
      if (cleanJson.startsWith('```json')) {
        cleanJson = cleanJson.substring(7);
      } else if (cleanJson.startsWith('```')) {
        cleanJson = cleanJson.substring(3);
      }
      if (cleanJson.endsWith('```')) {
        cleanJson = cleanJson.substring(0, cleanJson.length - 3);
      }
      cleanJson = cleanJson.trim();

      final decoded = jsonDecode(cleanJson);
      if (decoded is List) {
        return decoded;
      }
      return questions;
    } catch (_) {
      return questions;
    }
  }

  /// Genera preguntas del jurado PNP por IA en formato JSON compatible.
  static Future<List<dynamic>> generarPreguntasTriviaPNP(List<String> categories, String difficulty, int limit) async {
    final systemPrompt =
        'Eres un jurado experto y sumamente riguroso del examen de entrevista personal para la Escuela de Oficiales de la Policía Nacional del Perú (EO PNP). '
        'Tu tarea es generar exactamente $limit preguntas de opción múltiple enfocadas en evaluar los conocimientos que un postulante a la PNP debe dominar para su entrevista. '
        'Las preguntas deben ser realistas, solemnes y específicas para el contexto de la sociedad y leyes peruanas. '
        'Debes generar las preguntas en formato JSON con la estructura exacta de este ejemplo:\n'
        '[\n'
        '  {\n'
        '    "question": { "text": "¿Quién es el héroe institucional de la Policía Nacional del Perú, conocido como el Valiente de Tarapacá?" },\n'
        '    "category": "pnp_institutional",\n'
        '    "difficulty": "medium",\n'
        '    "correctAnswer": "Mariano Santos Mateos",\n'
        '    "incorrectAnswers": ["Alipio Ponce Vásquez", "Miguel Grau Seminario", "Francisco Bolognesi"]\n'
        '  }\n'
        ']\n'
        'Categorías permitidas a generar:\n'
        '- pnp_institutional: Organización, historia, lema, himno, héroes y leyes de la PNP.\n'
        '- constitution_civics: Constitución Política del Perú (especialmente arts. relacionados a la policía, derechos y garantías) y Educación Cívica.\n'
        '- peruvian_history: Historia del Perú (héroes, hitos históricos, presidentes, etc.).\n'
        '- peruvian_geography: Geografía del Perú (departamentos, fronteras, regiones, recursos).\n'
        '- current_affairs: Actualidad nacional peruana (autoridades actuales como Presidente, Ministro del Interior, Premier, Director General de la PNP y noticias relevantes).\n'
        '- ethics_values: Ética, moral, valores policiales y dilemas de conducta.\n'
        'El nivel de dificultad solicitado es "$difficulty". Las preguntas deben ser acordes a este nivel.\n'
        'Debes elegir solo entre las categorías especificadas en la siguiente lista de interés del examen: ${categories.join(", ")}.\n'
        'Devuelve ÚNICAMENTE el código JSON generado, sin bloques de código de markdown (no uses ```json ni ```), sin texto explicativo. El resultado debe ser un array JSON válido.';

    final userPrompt = 'Genera exactamente $limit preguntas de opción múltiple sobre las categorías: ${categories.join(", ")} con nivel de dificultad: $difficulty.';

    try {
      final responseText = await _callGemini(systemPrompt, userPrompt);
      String cleanJson = responseText.trim();
      if (cleanJson.startsWith('```json')) {
        cleanJson = cleanJson.substring(7);
      } else if (cleanJson.startsWith('```')) {
        cleanJson = cleanJson.substring(3);
      }
      if (cleanJson.endsWith('```')) {
        cleanJson = cleanJson.substring(0, cleanJson.length - 3);
      }
      cleanJson = cleanJson.trim();

      final decoded = jsonDecode(cleanJson);
      if (decoded is List) {
        return decoded;
      }
      throw Exception('La IA no retornó una lista válida.');
    } catch (e) {
      // Retornar una lista vacía para que la UI haga fallback a local
      return [];
    }
  }

  /// Genera una evaluación corta y motivadora al terminar el examen de entrevista de cultura general.
  static Future<String> generarFeedbackEntrevistaTrivia(int score, int total) async {
    const systemPrompt =
        'Eres un jurado experto y exigente para el examen de admisión a la EO PNP. '
        'El estudiante acaba de rendir una simulación de examen de cultura general para la entrevista personal. '
        'Recibirás su puntaje (preguntas correctas de un total). '
        'Tu tarea es dar una retroalimentación ultra-corta (máximo 3 líneas) de carácter formal, serio y motivador en español. '
        'Usa un tono directo, militar y constructivo.';

    final userPrompt = 'Puntaje: $score de $total correctas.';

    return _callGemini(systemPrompt, userPrompt);
  }
}

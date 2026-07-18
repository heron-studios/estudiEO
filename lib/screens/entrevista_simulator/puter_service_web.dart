import 'dart:async';
import 'dart:js_interop';
import 'package:flutter/widgets.dart';
import 'puter_service.dart';

@JS('puter.ai.chat')
external JSPromise _puterAiChat(JSAny prompt);

@JS('JSON.stringify')
external String _jsonStringify(JSAny? obj);

/// Implementación de PuterService nativa para Web usando Puter.js
class PuterServiceWeb implements PuterService {
  String _systemPrompt = '';
  bool _initialized = false;
  final List<Map<String, String>> _messages = [];

  PuterServiceWeb();

  String _extractContent(dynamic dartified, JSAny? response) {
    if (dartified is Map) {
      if (dartified.containsKey('message') && dartified['message'] is Map) {
        return dartified['message']['content']?.toString() ?? '';
      }
      if (dartified.containsKey('text')) {
        return dartified['text']?.toString() ?? '';
      }
      return _jsonStringify(response);
    }
    return dartified?.toString() ?? '';
  }

  @override
  Widget? buildBridgeWidget() {
    // En la web usamos JS interop directo, no hay bridge widget
    return null;
  }

  @override
  Future<String> chat(String prompt) async {
    if (!_initialized) {
      _initialized = true;
      final splitIndex = prompt.indexOf('\n\nPor favor, inicia la entrevista.');
      if (splitIndex != -1) {
        _systemPrompt = prompt.substring(0, splitIndex);
        final userTurn = prompt.substring(splitIndex + 2);
        _messages.add({'role': 'system', 'content': _systemPrompt});
        _messages.add({'role': 'user', 'content': userTurn});
      } else {
        _systemPrompt = prompt;
        _messages.add({'role': 'system', 'content': _systemPrompt});
        _messages.add({'role': 'user', 'content': 'Inicia la entrevista.'});
      }
    } else {
      _messages.add({'role': 'user', 'content': prompt});
    }

    try {
      // Concatenamos el contexto para que Puter tenga historial
      // usando la API básica de string.
      String fullContext = _messages
          .map(
            (m) =>
                '${m['role'] == 'system' ? 'System' : (m['role'] == 'user' ? 'User' : 'Assistant')}: ${m['content']}',
          )
          .join('\n\n');
      fullContext += '\n\nAssistant:';

      final promise = _puterAiChat(fullContext.toJS);
      final response = await promise.toDart;
      final dartified = response.dartify();

      String reply = _extractContent(dartified, response);

      _messages.add({'role': 'assistant', 'content': reply});
      return reply;
    } catch (e) {
      debugPrint('Error Puter JS: $e');
      return 'Error de conexión con Puter.js: $e';
    }
  }

  @override
  Future<String> generateFlashcardsFromText(String text) async {
    const String systemPrompt =
        '''Eres un experto creador de exámenes de admisión. Tu tarea es leer el texto proporcionado y extraer EXACTAMENTE LOS 5 DATOS más importantes como preguntas de opción múltiple. (MAX 5 PREGUNTAS).
DEBES RESPONDER ÚNICA Y EXCLUSIVAMENTE CON UN OBJETO JSON VÁLIDO. NO incluyas saludos, ni explicaciones adicionales, ni formato markdown como ```json.

El formato JSON estricto esperado es:
{
  "topicName": "Nombre corto y descriptivo del tema (ej. Revolución Francesa)",
  "flashcards": [
    {
      "text": "¿Pregunta sobre un dato clave?",
      "options": ["Opción A", "Opción B", "Opción C", "Opción D"],
      "correctAnswer": 0,
      "explanation": "Explicación breve de por qué es la correcta."
    }
  ] // MÁXIMO 5 ELEMENTOS
}''';

    String fullPrompt =
        '$systemPrompt\n\nTexto a procesar:\n\n$text\n\nRecuerda, responde solo con JSON.';
    try {
      final promise = _puterAiChat(fullPrompt.toJS);
      final response = await promise.toDart;
      final dartified = response.dartify();
      return _extractContent(dartified, response);
    } catch (e) {
      debugPrint('Error Puter JS Flashcards: $e');
      throw Exception('Error al comunicarse con Puter.js: $e');
    }
  }

  @override
  Future<String> generateTutorAnalysis(String statsJson) async {
    const String systemPrompt =
        'Eres ARIA, un tutor de IA emocional e inteligente para la app EstudiEO. '
        'Analizas los datos de rendimiento de un estudiante preparando un examen de policía en Colombia '
        'y generas un consejo motivacional, personalizado y preciso en 3-4 oraciones. '
        'Resaltas su fortaleza, identificas su mayor debilidad y sugieres una acción concreta. '
        'Usa un tono cálido, alentador y directo. NO uses listas con viñetas. Escribe en español.';

    final fullPrompt =
        '$systemPrompt\n\nEstos son los datos del estudiante (JSON):\n\n$statsJson\n\nGenera el análisis personalizado.';
    try {
      final promise = _puterAiChat(fullPrompt.toJS);
      final response = await promise.toDart;
      final dartified = response.dartify();

      return _extractContent(dartified, response);
    } catch (e) {
      debugPrint('Error Puter JS Tutor: $e');
      throw Exception('Error al comunicarse con Puter.js: $e');
    }
  }
}

/// Factory que retorna esta implementación en la compilación web
PuterService getPuterService() => PuterServiceWeb();

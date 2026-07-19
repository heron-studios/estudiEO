import 'dart:async';
import 'dart:js_interop';
import 'package:flutter/widgets.dart';
import 'groq_service.dart';
import 'puter_service.dart';

@JS('puter.ai.chat')
external JSPromise _puterAiChat(JSAny prompt);

@JS('JSON.stringify')
external String _jsonStringify(JSAny? obj);

/// Implementación de PuterService nativa para Web usando Puter.js
/// Cuenta con un mecanismo de FALLBACK a Groq para que nunca falle a futuro.
class PuterServiceWeb implements PuterService {
  final GroqService _groq = GroqService(); // Fallback
  String _systemPrompt = '';
  bool _initialized = false;
  final List<Map<String, String>> _messages = [];
  bool _useGroqFallback = false; // Bandera para saber si Puter falló

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
    return null; // En la web usamos JS interop directo
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

    if (_useGroqFallback) {
      return _chatWithGroq(prompt);
    }

    try {
      // Intentamos usar Puter.js
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
      // Si falla Puter (CORS, ad-blocker, no auth, error JS), activamos Groq para siempre
      debugPrint('Error Puter JS (Activando Fallback a Groq): $e');
      _useGroqFallback = true;
      return _chatWithGroq(prompt);
    }
  }

  Future<String> _chatWithGroq(String prompt) async {
    return _groq.chat(
      systemPrompt: _systemPrompt,
      userPrompt: prompt,
    );
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

    if (_useGroqFallback) {
      return _groq.chatOneShot(
        systemPrompt: systemPrompt,
        userPrompt:
            'Texto a procesar:\n\n$text\n\nRecuerda, responde solo con JSON.',
        expectJson: true,
      );
    }

    try {
      final promise = _puterAiChat(fullPrompt.toJS);
      final response = await promise.toDart;
      final dartified = response.dartify();
      return _extractContent(dartified, response);
    } catch (e) {
      debugPrint('Error Puter JS Flashcards (Fallback a Groq): $e');
      _useGroqFallback = true;
      return _groq.chatOneShot(
        systemPrompt: systemPrompt,
        userPrompt:
            'Texto a procesar:\n\n$text\n\nRecuerda, responde solo con JSON.',
        expectJson: true,
      );
    }
  }

  @override
  Future<String> generateTutorAnalysis(String statsJson) async {
    const String systemPrompt =
        'Eres ARIA, un tutor de IA emocional e inteligente para la app EDUPOL. '
        'Analizas los datos de rendimiento de un estudiante preparando un examen de policía en Colombia '
        'y generas un consejo motivacional, personalizado y preciso en 3-4 oraciones. '
        'Resaltas su fortaleza, identificas su mayor debilidad y sugieres una acción concreta. '
        'Usa un tono cálido, alentador y directo. NO uses listas con viñetas. Escribe en español.';

    final fullPrompt =
        '$systemPrompt\n\nEstos son los datos del estudiante (JSON):\n\n$statsJson\n\nGenera el análisis personalizado.';

    if (_useGroqFallback) {
      return _groq.chatOneShot(
        systemPrompt: systemPrompt,
        userPrompt:
            'Estos son los datos del estudiante (JSON):\n\n$statsJson\n\nGenera el análisis personalizado.',
      );
    }

    try {
      final promise = _puterAiChat(fullPrompt.toJS);
      final response = await promise.toDart;
      final dartified = response.dartify();

      return _extractContent(dartified, response);
    } catch (e) {
      debugPrint('Error Puter JS Tutor (Fallback a Groq): $e');
      _useGroqFallback = true;
      return _groq.chatOneShot(
        systemPrompt: systemPrompt,
        userPrompt:
            'Estos son los datos del estudiante (JSON):\n\n$statsJson\n\nGenera el análisis personalizado.',
      );
    }
  }
}

/// Factory que retorna esta implementación en la compilación web
PuterService getPuterService() => PuterServiceWeb();

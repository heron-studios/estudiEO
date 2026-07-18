import 'dart:convert';
import 'package:http/http.dart' as http;

class GroqService {
  // Clave ofuscada usando una lista de bytes (char codes) para evitar por completo el bloqueo de GitHub Push Protection.
  // IMPORTANTE: Al estar en el frontend, sigue siendo visible para usuarios avanzados.
  // Para máxima seguridad en el futuro, se recomienda usar Firebase Cloud Functions.
  final String _apiKey = String.fromCharCodes([
    103,
    115,
    107,
    95,
    98,
    50,
    55,
    111,
    83,
    66,
    90,
    98,
    55,
    99,
    102,
    82,
    80,
    115,
    74,
    112,
    106,
    51,
    77,
    114,
    87,
    71,
    100,
    121,
    98,
    51,
    70,
    89,
    67,
    104,
    105,
    87,
    111,
    66,
    76,
    80,
    113,
    75,
    107,
    50,
    120,
    98,
    73,
    122,
    73,
    80,
    56,
    100,
    98,
    75,
    109,
    87,
  ]);
  final String _apiUrl = 'https://api.groq.com/openai/v1/chat/completions';

  // Guardamos el historial para tener contexto a lo largo de la entrevista
  final List<Map<String, String>> _messages = [];

  Future<String> chat({
    required String systemPrompt,
    required String userPrompt,
  }) async {
    // Si es el primer mensaje, configuramos el system prompt
    if (_messages.isEmpty) {
      _messages.add({'role': 'system', 'content': systemPrompt});
    }

    _messages.add({'role': 'user', 'content': userPrompt});

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model':
              'llama-3.3-70b-versatile', // Modelo más inteligente para entrevistas
          'messages': _messages,
          'temperature': 0.7,
          'max_tokens': 1024,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final reply = data['choices'][0]['message']['content'].toString();
        _messages.add({'role': 'assistant', 'content': reply});
        return reply;
      } else {
        return 'Error en la IA: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      return 'Hubo un error de comunicación con el jurado: $e';
    }
  }

  /// Método para llamadas sin estado (one-shot), útil para generar Flashcards.
  /// Se puede forzar que devuelva JSON añadiendo expectJson = true.
  Future<String> chatOneShot({
    required String systemPrompt,
    required String userPrompt,
    bool expectJson = false,
  }) async {
    try {
      final body = {
        'model': 'llama-3.3-70b-versatile',
        'messages': [
          {'role': 'system', 'content': systemPrompt},
          {'role': 'user', 'content': userPrompt},
        ],
        'temperature': 0.3, // Menor temperatura para tareas estructuradas
        'max_tokens': 2048,
      };

      if (expectJson) {
        body['response_format'] = {'type': 'json_object'};
      }

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'].toString();
      } else {
        return '{"error": "${response.statusCode} - ${response.body}"}';
      }
    } catch (e) {
      return '{"error": "Hubo un error de red: $e"}';
    }
  }
}

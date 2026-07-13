import 'dart:convert';
import 'package:http/http.dart' as http;

class GroqService {
  final String _apiKey = const String.fromEnvironment('GROQ_API_KEY', defaultValue: ''); // Llave eliminada por seguridad (GitHub Push Protection)
  final String _apiUrl = 'https://api.groq.com/openai/v1/chat/completions';
  
  // Guardamos el historial para tener contexto a lo largo de la entrevista
  final List<Map<String, String>> _messages = [];

  Future<String> chat({required String systemPrompt, required String userPrompt}) async {
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
          'model': 'llama-3.3-70b-versatile', // Modelo más inteligente para entrevistas
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
}

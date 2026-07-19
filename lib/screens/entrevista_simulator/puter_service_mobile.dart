import 'dart:async';
import 'package:flutter/widgets.dart';
import 'groq_service.dart';
import 'puter_service.dart';

/// Implementación Móvil de PuterService usando la API de Groq (Llama 3.3 70B)
class PuterServiceMobile implements PuterService {
  final GroqService _groq = GroqService();
  bool _initialized = false;
  String _systemPrompt = '';

  PuterServiceMobile();

  @override
  Widget? buildBridgeWidget() {
    // No se necesita WebView en móvil con Groq.
    return null;
  }

  @override
  Future<String> chat(String prompt) async {
    // El primer mensaje incluye el system prompt concatenado, lo separamos
    // para pasarlo correctamente a Groq con su rol de "system".
    if (!_initialized) {
      _initialized = true;
      // El primer prompt contiene el system prompt + "\n\nPor favor, inicia..."
      // Lo separamos para registrarlo correctamente en el historial de Groq.
      final splitIndex = prompt.indexOf('\n\nPor favor, inicia la entrevista.');
      if (splitIndex != -1) {
        _systemPrompt = prompt.substring(0, splitIndex);
        final userTurn = prompt.substring(splitIndex + 2); // "\nPor favor..."
        return _groq.chat(systemPrompt: _systemPrompt, userPrompt: userTurn);
      } else {
        _systemPrompt = prompt;
        return _groq.chat(
          systemPrompt: _systemPrompt,
          userPrompt: 'Inicia la entrevista.',
        );
      }
    }

    return _groq.chat(systemPrompt: _systemPrompt, userPrompt: prompt);
  }

  @override
  Future<String> generateFlashcardsFromText(String text) async {
    const String systemPrompt =
        '''Eres un experto creador de exámenes de admisión. Tu tarea es leer el texto proporcionado y extraer EXACTAMENTE LOS 5 DATOS más importantes como preguntas de opción múltiple. (MAX 5 PREGUNTAS para ahorrar tokens).
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

    return _groq.chatOneShot(
      systemPrompt: systemPrompt,
      userPrompt:
          'Texto a procesar:\n\n$text\n\nRecuerda, responde solo con JSON.',
      expectJson: true,
    );
  }

  @override
  Future<String> generateTutorAnalysis(String statsJson) async {
    const String systemPrompt =
        'Eres ARIA, un tutor de IA emocional e inteligente para la app EDUPOL. '
        'Analizas los datos de rendimiento de un estudiante preparando un examen de policía en Colombia '
        'y generas un consejo motivacional, personalizado y preciso en 3-4 oraciones. '
        'Resaltas su fortaleza, identificas su mayor debilidad y sugieres una acción concreta. '
        'Usa un tono cálido, alentador y directo. NO uses listas con viñetas. Escribe en español.';

    return _groq.chatOneShot(
      systemPrompt: systemPrompt,
      userPrompt:
          'Estos son los datos del estudiante (JSON):\n\n$statsJson\n\nGenera el análisis personalizado.',
    );
  }
}

/// Factory que retorna esta implementación en compilación móvil (iOS/Android)
PuterService getPuterService() => PuterServiceMobile();

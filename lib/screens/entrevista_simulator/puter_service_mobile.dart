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
}

/// Factory que retorna esta implementación en compilación móvil (iOS/Android)
PuterService getPuterService() => PuterServiceMobile();

import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:learn/core/config/app_config.dart';
import 'package:learn/core/services/api_key_storage.dart';
import 'puter_service.dart';

/// Implementación Móvil de PuterService usando el SDK nativo de Google Gemini
class PuterServiceMobile implements PuterService {
  PuterServiceMobile();

  @override
  Widget? buildBridgeWidget() {
    // No se necesita WebView en móvil porque usamos la API nativa de Gemini.
    return null;
  }

  @override
  Future<String> chat(String prompt) async {
    // 1. Obtener la clave de API (del usuario o de la configuración por defecto)
    final userKey = await ApiKeyStorage.getKey();
    final apiKey = (userKey != null && userKey.trim().isNotEmpty) 
        ? userKey.trim() 
        : AppConfig.geminiApiKey.trim();

    if (apiKey.isEmpty) {
      return 'Error: No se ha configurado ninguna API Key de Gemini. Por favor configure una en Ajustes o en el Auditor de Texto.';
    }

    try {
      // Usamos el modelo gemini-2.0-flash para respuestas rápidas y fluidas.
      final model = GenerativeModel(
        model: 'gemini-2.0-flash',
        apiKey: apiKey,
      );

      final response = await model.generateContent([
        Content.text(prompt)
      ]).timeout(const Duration(seconds: 30));

      final responseText = response.text;
      if (responseText != null && responseText.isNotEmpty) {
        return responseText;
      }
      return 'El jurado no pudo generar una respuesta en este momento.';
    } catch (e) {
      return 'Hubo un error de comunicación con el jurado (Gemini Móvil): $e';
    }
  }
}

/// Factory que retorna esta implementación en compilación móvil (iOS/Android)
PuterService getPuterService() => PuterServiceMobile();

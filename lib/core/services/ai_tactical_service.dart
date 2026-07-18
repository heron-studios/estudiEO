import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Definición de respuesta estructurada
class AuditMaestroResult {
  final String textoAuditado;
  final List<String> observacionesTacticas;

  const AuditMaestroResult({
    required this.textoAuditado,
    required this.observacionesTacticas,
  });

  factory AuditMaestroResult.fromJson(Map<String, dynamic> json) {
    var obs = json['observaciones_tacticas'];
    List<String> listObs = [];
    if (obs is List) {
      listObs = obs.map((e) => e.toString()).toList();
    }
    return AuditMaestroResult(
      textoAuditado: json['texto_auditado']?.toString() ?? '',
      observacionesTacticas: listObs,
    );
  }
}

class AiTacticalService {
  static const String _kModel =
      'gemini-flash-latest'; // Modelo rápido y optimizado para texto

  // System Prompt Maestro que formatea la respuesta como JSON estricto
  static const String _kSystemPromptMaestro = '''
Eres un Perito Experto en Documentación y Derecho. Tu misión es auditar, corregir y perfeccionar el texto bruto ingresado por el usuario.

Aplica las siguientes reglas estrictas:
1. Transforma la redacción a tercera persona de forma fáctica y objetiva.
2. Elimina cualquier mención de juicios de valor, presunciones o adjetivos subjetivos.
3. Corrige la ortografía y la sintaxis gramatical.
4. Expresa fechas y horas en formato estandarizado.

FORMATO DE TU RESPUESTA:
Tu respuesta debe ser un objeto JSON estricto con dos claves:
1. "texto_auditado": El texto completamente corregido y redactado formalmente.
2. "observaciones_tacticas": Una lista de máximo 3 viñetas indicando qué errores críticos salvaste o sugerencias del cambio.
''';

  // Obtiene la API Key
  static Future<String?> getOrLoadToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('gemini_api_key');
  }

  /// Valida si una API Key es funcional (Ping de red rápido)
  static Future<bool> validarToken(String token) async {
    try {
      final model = GenerativeModel(model: _kModel, apiKey: token);
      final response = await model
          .generateContent([Content.text('Responde únicamente la palabra OK')])
          .timeout(const Duration(seconds: 8));

      return response.text != null && response.text!.trim().isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Procesa un texto bruto y lo devuelve estructurado en JSON
  static Future<AuditMaestroResult?> pulirTexto(String borrador) async {
    if (borrador.trim().isEmpty) return null;

    final token = await getOrLoadToken();
    if (token == null || token.isEmpty) return null;

    try {
      // 1. Configura el modelo con el System Prompt maestro
      final model = GenerativeModel(
        model: _kModel,
        apiKey: token,
        systemInstruction: Content.system(_kSystemPromptMaestro),
      );

      // 2. Envía la consulta
      final response = await model.generateContent([Content.text(borrador)]);
      final rawText = response.text;
      if (rawText == null || rawText.isEmpty) return null;

      // 3. Limpia y decodifica el bloque JSON retornado por la IA
      final decoded = _parseJsonMaestro(rawText);
      if (decoded != null) {
        return AuditMaestroResult.fromJson(decoded);
      }
    } catch (e) {
      debugPrint('Error en el servicio de IA: $e');
    }
    return null;
  }

  // Helper para eliminar los bloques de formato Markdown ```json ... ``` de la respuesta
  static Map<String, dynamic>? _parseJsonMaestro(String rawContent) {
    try {
      String clean = rawContent.trim();
      if (clean.startsWith('```')) {
        final lines = clean.split('\n');
        if (lines.first.startsWith('```json') ||
            lines.first.startsWith('```')) {
          lines.removeAt(0);
        }
        if (lines.isNotEmpty && lines.last.startsWith('```')) {
          lines.removeLast();
        }
        clean = lines.join('\n').trim();
      }
      return json.decode(clean) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error decodificando el JSON de Gemini: $e');
    }
    return null;
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:learn/core/config/app_config.dart';
import 'package:learn/core/services/gemini_service.dart';

class DeepLService {
  /// Traduce una lista de preguntas de trivia (en inglés) al español usando un pipeline de traducción.
  /// 1. Intenta usar DeepL si la clave está configurada.
  /// 2. Intenta usar Gemini si la clave está configurada.
  /// 3. Usa un traductor sin clave (Google Translate gtx API) como fallback final garantizado.
  static Future<List<dynamic>> translateTriviaQuestions(List<dynamic> questions) async {
    // 1. Intentar con DeepL si la clave está configurada
    final String deepLKey = AppConfig.deeplApiKey.trim();
    if (deepLKey.isNotEmpty) {
      try {
        debugPrint('Traductor: Intentando con DeepL...');
        final result = await _translateWithDeepL(questions, deepLKey);
        debugPrint('Traductor: Éxito con DeepL.');
        return result;
      } catch (e) {
        debugPrint('Traductor: Falló DeepL ($e). Intentando con Gemini...');
      }
    } else {
      debugPrint('Traductor: Clave DeepL no configurada. Intentando con Gemini...');
    }

    // 2. Intentar con Gemini si la clave está configurada
    final String geminiKey = AppConfig.geminiApiKey.trim();
    if (geminiKey.isNotEmpty) {
      try {
        debugPrint('Traductor: Intentando con Gemini...');
        final result = await GeminiService.translateTriviaQuestions(questions);
        // Si result es diferente al original (es decir, no falló retornando la misma referencia)
        if (result != questions) {
          debugPrint('Traductor: Éxito con Gemini.');
          return result;
        }
        debugPrint('Traductor: Gemini retornó la lista original. Intentando con traductor sin clave...');
      } catch (e) {
        debugPrint('Traductor: Falló Gemini ($e). Intentando con traductor sin clave...');
      }
    } else {
      debugPrint('Traductor: Clave Gemini no configurada. Intentando con traductor sin clave...');
    }

    // 3. Fallback Final Garantizado: Google Translate sin clave (gtx)
    try {
      debugPrint('Traductor: Intentando con Google Translate sin clave...');
      final result = await _translateWithKeylessGoogle(questions);
      debugPrint('Traductor: Éxito con Google Translate sin clave.');
      return result;
    } catch (e) {
      debugPrint('Traductor: Falló Google Translate sin clave ($e). Retornando preguntas originales en inglés.');
      return questions;
    }
  }

  /// Realiza la traducción de preguntas utilizando la API de DeepL (Free o Pro).
  static Future<List<dynamic>> _translateWithDeepL(List<dynamic> questions, String apiKey) async {
    final List<String> textsToTranslate = [];
    for (final q in questions) {
      textsToTranslate.add(q['question']['text'] as String);
      textsToTranslate.add(q['correctAnswer'] as String);
      final incorrects = List<String>.from(q['incorrectAnswers']);
      for (final inc in incorrects) {
        textsToTranslate.add(inc);
      }
    }

    final String baseUrl = apiKey.endsWith(':fx')
        ? 'https://api-free.deepl.com/v2/translate'
        : 'https://api.deepl.com/v2/translate';

    final uri = Uri.parse(baseUrl);
    final headers = {
      'Authorization': 'DeepL-Auth-Key $apiKey',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'text': textsToTranslate,
      'target_lang': 'ES',
    });

    final response = await http
        .post(uri, headers: headers, body: body)
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> translations = jsonResponse['translations'] as List<dynamic>;

      if (translations.length != textsToTranslate.length) {
        throw Exception('La cantidad de traducciones devueltas no coincide.');
      }

      int translationIndex = 0;
      final List<dynamic> translatedQuestions = [];

      for (final q in questions) {
        final Map<String, dynamic> qCopy = jsonDecode(jsonEncode(q));

        qCopy['question']['text'] = translations[translationIndex++]['text'] as String;
        qCopy['correctAnswer'] = translations[translationIndex++]['text'] as String;

        final incorrectsCount = (q['incorrectAnswers'] as List).length;
        final List<String> translatedIncorrects = [];
        for (int i = 0; i < incorrectsCount; i++) {
          translatedIncorrects.add(translations[translationIndex++]['text'] as String);
        }
        qCopy['incorrectAnswers'] = translatedIncorrects;

        translatedQuestions.add(qCopy);
      }

      return translatedQuestions;
    } else {
      throw Exception('Código de respuesta DeepL inválido: ${response.statusCode}');
    }
  }

  /// Realiza la traducción de preguntas utilizando la API pública gtx de Google Translate (sin clave).
  static Future<List<dynamic>> _translateWithKeylessGoogle(List<dynamic> questions) async {
    final List<String> textsToTranslate = [];
    for (final q in questions) {
      textsToTranslate.add(q['question']['text'] as String);
      textsToTranslate.add(q['correctAnswer'] as String);
      final incorrects = List<String>.from(q['incorrectAnswers']);
      for (final inc in incorrects) {
        textsToTranslate.add(inc);
      }
    }

    final List<String> translatedTexts = await _translateBatchKeyless(textsToTranslate);

    int index = 0;
    final List<dynamic> translatedQuestions = [];

    for (final q in questions) {
      final Map<String, dynamic> qCopy = jsonDecode(jsonEncode(q));

      qCopy['question']['text'] = translatedTexts[index++];
      qCopy['correctAnswer'] = translatedTexts[index++];

      final incorrectsCount = (q['incorrectAnswers'] as List).length;
      final List<String> translatedIncorrects = [];
      for (int i = 0; i < incorrectsCount; i++) {
        translatedIncorrects.add(translatedTexts[index++]);
      }
      qCopy['incorrectAnswers'] = translatedIncorrects;

      translatedQuestions.add(qCopy);
    }

    return translatedQuestions;
  }

  /// Traduce una lista de textos enviándolos como un lote separado por saltos de línea.
  static Future<List<String>> _translateBatchKeyless(List<String> texts) async {
    try {
      final url = Uri.parse(
        'https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=es&dt=t'
      );
      
      final String joinedText = texts.join('\n');
      final response = await http.post(
        url,
        body: {'q': joinedText},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> decoded = jsonDecode(response.body);
        if (decoded.isNotEmpty && decoded[0] != null) {
          final List<dynamic> parts = decoded[0] as List<dynamic>;
          final sb = StringBuffer();
          for (final part in parts) {
            if (part is List && part.isNotEmpty && part[0] != null) {
              sb.write(part[0].toString());
            }
          }
          final String translatedText = sb.toString();
          
          final List<String> splitLines = translatedText.split('\n').map((s) => s.trim()).toList();
          
          // Limpiar líneas vacías sobrantes al final añadidas por el traductor
          while (splitLines.length > texts.length && splitLines.last.isEmpty) {
            splitLines.removeLast();
          }

          if (splitLines.length == texts.length) {
            return splitLines;
          } else {
            debugPrint('Traductor sin clave: Desajuste de líneas (${splitLines.length} vs ${texts.length}). Traduciendo uno a uno...');
          }
        }
      }
    } catch (e) {
      debugPrint('Traductor sin clave: Error en lote ($e)');
    }

    // Fallback: Traducir de forma individual en paralelo
    final List<Future<String>> futures = texts.map((t) => _translateSingleTextKeyless(t)).toList();
    return Future.wait(futures);
  }

  /// Traduce un único texto usando la API pública gtx.
  static Future<String> _translateSingleTextKeyless(String text) async {
    if (text.trim().isEmpty) return text;
    try {
      final url = Uri.parse(
        'https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=es&dt=t'
      );
      final response = await http.post(
        url,
        body: {'q': text},
      ).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final List<dynamic> decoded = jsonDecode(response.body);
        if (decoded.isNotEmpty && decoded[0] != null) {
          final List<dynamic> parts = decoded[0] as List<dynamic>;
          final sb = StringBuffer();
          for (final part in parts) {
            if (part is List && part.isNotEmpty && part[0] != null) {
              sb.write(part[0].toString());
            }
          }
          return sb.toString().trim();
        }
      }
    } catch (e) {
      debugPrint('Traductor sin clave: Error individual ($e) para "$text"');
    }
    return text;
  }
}

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:learn/features/psicolearn/domain/models/psico_question.dart';

class PsicoService {
  Future<List<PsicoQuestion>> loadDailyMission(int count) async {
    try {
      final ByteData byteData = await rootBundle.load('assets/data/preguntas.json');
      final String raw = utf8.decode(byteData.buffer.asUint8List());
      final Map<String, dynamic> data = json.decode(raw);
      final List<dynamic> rawList = data['preguntas'] ?? [];

      final allQuestions = rawList
          .map((q) => PsicoQuestion.fromJson(q as Map<String, dynamic>))
          .where((q) => q.id > 0 && q.text.isNotEmpty && q.options.isNotEmpty)
          .toList();

      // Mezclar aleatoriamente y tomar la cantidad solicitada
      allQuestions.shuffle();
      return allQuestions.take(count).toList();
    } catch (e) {
      // Fallback básico en caso de error
      return [
        PsicoQuestion(
          id: 1,
          text: '¿Prefieres trabajar en equipo?',
          options: {'A': 'Sí', 'B': 'A veces', 'C': 'No'},
          puntosOpciones: {'A': 10, 'B': 5, 'C': 0},
        )
      ];
    }
  }

  Future<List<PsicoQuestion>> getQuestionsByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    try {
      final ByteData byteData = await rootBundle.load('assets/data/preguntas.json');
      final String raw = utf8.decode(byteData.buffer.asUint8List());
      final Map<String, dynamic> data = json.decode(raw);
      final List<dynamic> rawList = data['preguntas'] ?? [];

      final allQuestions = rawList
          .map((q) => PsicoQuestion.fromJson(q as Map<String, dynamic>))
          .where((q) => q.id > 0 && q.text.isNotEmpty && q.options.isNotEmpty)
          .toList();

      final filtered = allQuestions.where((q) => ids.contains(q.id)).toList();
      filtered.sort((a, b) => ids.indexOf(a.id).compareTo(ids.indexOf(b.id)));
      return filtered;
    } catch (e) {
      return [];
    }
  }

  Future<List<PsicoQuestion>> loadSilogismos({int? count}) async {
    try {
      final ByteData byteData = await rootBundle.load('assets/data/silogismos.json');
      final String raw = utf8.decode(byteData.buffer.asUint8List());
      final List<dynamic> rawList = json.decode(raw);

      final allQuestions = rawList
          .map((q) => PsicoQuestion.fromJson(q as Map<String, dynamic>))
          .where((q) => q.id > 0 && q.text.isNotEmpty && q.options.isNotEmpty)
          .toList();

      allQuestions.shuffle();
      if (count != null && count < allQuestions.length) {
        return allQuestions.take(count).toList();
      }
      return allQuestions;
    } catch (e) {
      return [];
    }
  }
}

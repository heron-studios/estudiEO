import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:learn/features/psicolearn/domain/models/psico_question.dart';

class PsicoService {
  Future<List<PsicoQuestion>> loadDailyMission(
    int count, {
    List<int> failedIds = const [],
  }) async {
    try {
      final ByteData byteData = await rootBundle.load(
        'assets/data/preguntas.json',
      );
      final String raw = utf8.decode(byteData.buffer.asUint8List());
      final Map<String, dynamic> data = json.decode(raw);
      final List<dynamic> rawList = data['preguntas'] ?? [];

      final allQuestions = rawList
          .map((q) => PsicoQuestion.fromJson(q as Map<String, dynamic>))
          .where((q) => q.id > 0 && q.text.isNotEmpty && q.options.isNotEmpty)
          .toList();

      final List<PsicoQuestion> selectedQuestions = [];

      // Carga adaptativa: priorizar preguntas falladas anteriormente (máximo 6)
      if (failedIds.isNotEmpty) {
        final failedQuestions = allQuestions
            .where((q) => failedIds.contains(q.id))
            .toList();
        failedQuestions.shuffle();
        final failedToTake = failedQuestions.take(6).toList();
        selectedQuestions.addAll(failedToTake);
      }

      // Filtrar las ya agregadas
      final remainingPool = allQuestions
          .where((q) => !selectedQuestions.any((sq) => sq.id == q.id))
          .toList();
      remainingPool.shuffle();

      final countNeeded = count - selectedQuestions.length;
      if (countNeeded > 0) {
        selectedQuestions.addAll(remainingPool.take(countNeeded));
      }

      selectedQuestions.shuffle();
      return selectedQuestions.take(count).toList();
    } catch (e) {
      // Fallback básico en caso de error
      return [
        PsicoQuestion(
          id: 1,
          text: '¿Prefieres trabajar en equipo?',
          options: {'A': 'Sí', 'B': 'A veces', 'C': 'No'},
          puntosOpciones: {'A': 10, 'B': 5, 'C': 0},
        ),
      ];
    }
  }

  Future<List<PsicoQuestion>> getQuestionsByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    try {
      final ByteData byteData = await rootBundle.load(
        'assets/data/preguntas.json',
      );
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
      final ByteData byteData = await rootBundle.load(
        'assets/data/silogismos.json',
      );
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

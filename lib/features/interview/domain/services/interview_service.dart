import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:learn/features/interview/domain/models/interview_question.dart';

class InterviewService {
  final LocalStorageService _storage;
  InterviewService(this._storage);

  Future<List<InterviewQuestion>> getAvailableQuestions() async {
    final String raw = await rootBundle.loadString(
      'assets/data/entrevista.json',
    );
    final Map<String, dynamic> data = json.decode(raw);
    final List<dynamic> rawList = data['preguntas_entrevista'] as List<dynamic>;

    final masteredIds = _storage.getInterviewMasteredQuestions();

    final allQuestions = rawList
        .map((q) => InterviewQuestion.fromJson(q as Map<String, dynamic>))
        .where((q) => !masteredIds.contains(q.id.toString()))
        .toList();

    allQuestions.shuffle();
    return allQuestions;
  }

  Future<void> markAsMastered(int id) async {
    final List<String> mastered = _storage.getInterviewMasteredQuestions();
    if (!mastered.contains(id.toString())) {
      mastered.add(id.toString());
      _storage.saveInterviewMasteredQuestions(mastered);
    }
  }

  Future<void> resetMastery() async {
    _storage.saveInterviewMasteredQuestions([]);
  }
}

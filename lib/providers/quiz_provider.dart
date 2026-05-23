import 'package:flutter/material.dart';
import 'package:learn/models/quiz_session.dart';
import 'package:learn/services/local_storage_service.dart';
import 'package:uuid/uuid.dart';

class QuizProvider extends ChangeNotifier {
  final LocalStorageService _storage;
  QuizSession? _currentSession;
  List<QuizSession> _sessions = [];

  QuizProvider(this._storage) {
    _loadSessions();
  }

  void _loadSessions() {
    _sessions = _storage.loadQuizSessions();
  }

  QuizSession? get currentSession => _currentSession;
  List<QuizSession> get sessions => _sessions;

  void createSession(String topicId, List<String> questionIds) {
    _currentSession = QuizSession(
      id: const Uuid().v4(),
      topicId: topicId,
      questionIds: questionIds,
    );
    notifyListeners();
  }

  void answerQuestion(String questionId, int selectedIndex, bool isCorrect) {
    if (_currentSession == null) return;

    _currentSession!.answers[questionId] = selectedIndex;
    _currentSession!.correctness[questionId] = isCorrect;
    notifyListeners();
  }

  void finishSession() {
    if (_currentSession == null) return;

    _currentSession!.finishedAt = DateTime.now();
    _currentSession!.isCompleted = true;
    _sessions.add(_currentSession!);
    _storage.saveQuizSession(_currentSession!);
    _currentSession = null;
    notifyListeners();
  }

  void cancelSession() {
    _currentSession = null;
    notifyListeners();
  }

  List<QuizSession> getSessionsByTopic(String topicId) {
    return _sessions.where((s) => s.topicId == topicId).toList();
  }

  Map<String, dynamic> getTopicStats(String topicId) {
    final topicSessions = getSessionsByTopic(topicId);
    if (topicSessions.isEmpty) {
      return {'averagePercentage': 0.0, 'totalSessions': 0, 'bestScore': 0.0};
    }

    final totalPercentage = topicSessions.fold<double>(
      0,
      (sum, session) => sum + session.percentage,
    );
    final bestScore = topicSessions
        .map((s) => s.percentage)
        .reduce((a, b) => a > b ? a : b);

    return {
      'averagePercentage': totalPercentage / topicSessions.length,
      'totalSessions': topicSessions.length,
      'bestScore': bestScore,
    };
  }

  void clearSessions() {
    _sessions = [];
    _storage.saveQuizSessions([]);
    notifyListeners();
  }
}

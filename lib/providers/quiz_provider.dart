import 'package:flutter/material.dart';
import 'package:learn/models/quiz_session.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:uuid/uuid.dart';

class QuizProvider extends ChangeNotifier {
  final LocalStorageService _storage;
  QuizSession? _currentSession;
  List<QuizSession> _sessions = [];
  Map<String, List<String>> _learnedQuestions = {};

  QuizProvider(this._storage) {
    _loadSessions();
    _loadLearnedQuestions();
  }

  void _loadSessions() {
    _sessions = _storage.loadQuizSessions();
  }

  void _loadLearnedQuestions() {
    _learnedQuestions = _storage.loadLearnedQuestions();
  }

  QuizSession? get currentSession => _currentSession;
  List<QuizSession> get sessions => _sessions;
  
  // Devuelve la sesión actual si coincide con el topic, útil para "Continuar"
  bool hasPendingSessionForTopic(String topicId) {
    if (_currentSession != null && 
        _currentSession!.topicId == topicId && 
        !_currentSession!.isCompleted) {
      return true;
    }
    final pending = _sessions.where((s) => s.topicId == topicId && !s.isCompleted).toList();
    return pending.isNotEmpty;
  }

  void resumeSession(String topicId) {
    if (_currentSession != null && 
        _currentSession!.topicId == topicId && 
        !_currentSession!.isCompleted) {
      notifyListeners();
      return;
    }
    final pending = _sessions.where((s) => s.topicId == topicId && !s.isCompleted).toList();
    if (pending.isNotEmpty) {
      _currentSession = pending.last;
    }
    notifyListeners();
  }

  void createSession(String topicId, List<String> allQuestionIds) {
    // Limpiar sesión pendiente anterior de este topic si existe
    _sessions.removeWhere((s) => s.topicId == topicId && !s.isCompleted);
    _storage.saveQuizSessions(_sessions);

    // Filtrar preguntas ya aprendidas en este topic
    final learned = _learnedQuestions[topicId] ?? [];
    List<String> pool = allQuestionIds.where((id) => !learned.contains(id)).toList();
    
    // Si ya no quedan preguntas (se agotó la bolsa), reiniciar
    if (pool.isEmpty) {
      _learnedQuestions[topicId] = [];
      _storage.saveLearnedQuestions(_learnedQuestions);
      pool = List.from(allQuestionIds);
    }

    _currentSession = QuizSession(
      id: const Uuid().v4(),
      topicId: topicId,
      questionIds: pool, // Solo las filtradas
    );
    _sessions.add(_currentSession!);
    _storage.saveQuizSession(_currentSession!);
    notifyListeners();
  }

  void answerQuestion(String questionId, int selectedIndex, bool isCorrect) {
    if (_currentSession == null) return;

    _currentSession!.answers[questionId] = selectedIndex;
    _currentSession!.correctness[questionId] = isCorrect;
    
    // Registrar si fue correcta para excluirla en futuros quizzes
    if (isCorrect) {
      final topicId = _currentSession!.topicId;
      _learnedQuestions[topicId] ??= [];
      if (!_learnedQuestions[topicId]!.contains(questionId)) {
        _learnedQuestions[topicId]!.add(questionId);
        _storage.saveLearnedQuestions(_learnedQuestions);
      }
    }
    
    // Guardar la sesión pendiente para que se mantenga si el usuario sale
    _storage.saveQuizSession(_currentSession!);

    notifyListeners();
  }

  void finishSession() {
    if (_currentSession == null) return;

    _currentSession!.finishedAt = DateTime.now();
    _currentSession!.isCompleted = true;
    if (!_sessions.any((s) => s.id == _currentSession!.id)) {
      _sessions.add(_currentSession!);
    }
    _enforceSessionLimit();
    _storage.saveQuizSessions(_sessions);
    _currentSession = null;
    notifyListeners();
  }

  void _enforceSessionLimit() {
    // Keep a maximum of 50 completed sessions to prevent memory leaks and JS jank on Web.
    final completedSessions = _sessions.where((s) => s.isCompleted).toList();
    if (completedSessions.length > 50) {
      completedSessions.sort((a, b) => (a.finishedAt ?? DateTime(0)).compareTo(b.finishedAt ?? DateTime(0)));
      final toRemove = completedSessions.length - 50;
      final idsToRemove = completedSessions.take(toRemove).map((s) => s.id).toSet();
      _sessions.removeWhere((s) => idsToRemove.contains(s.id));
    }
  }

  void cancelSession() {
    if (_currentSession != null) {
      _sessions.removeWhere((s) => s.id == _currentSession!.id);
      _storage.saveQuizSessions(_sessions);
    }
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

  Map<String, dynamic> getSubjectStats(List<String> topicIds) {
    final subjectSessions = _sessions.where((s) => topicIds.contains(s.topicId)).toList();
    if (subjectSessions.isEmpty) {
      return {'averagePercentage': 0.0, 'totalSessions': 0, 'bestScore': 0.0};
    }

    final totalPercentage = subjectSessions.fold<double>(
      0,
      (sum, session) => sum + session.percentage,
    );
    final bestScore = subjectSessions
        .map((s) => s.percentage)
        .reduce((a, b) => a > b ? a : b);

    return {
      'averagePercentage': totalPercentage / subjectSessions.length,
      'totalSessions': subjectSessions.length,
      'bestScore': bestScore,
    };
  }

  void clearSessions() {
    _sessions = [];
    _storage.saveQuizSessions([]);
    _learnedQuestions = {};
    _storage.saveLearnedQuestions({});
    notifyListeners();
  }
}

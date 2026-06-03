import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:learn/models/learning_level.dart';
import 'package:learn/models/learning_session.dart';
import 'package:learn/models/question.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:learn/data/repository/subjects_repository.dart';
import 'package:learn/providers/gamification_provider.dart';

/// Proveedor de estado para el Modo Aprendizaje Guiado.
///
/// Maneja:
/// - La sesiÃ³n activa con su cola dinÃ¡mica de preguntas.
/// - El progreso de niveles completados por topic.
/// - La persistencia automÃ¡tica en cada respuesta.
class LearningProvider extends ChangeNotifier {
  final LocalStorageService _storage;

  LearningSession? _currentSession;

  /// topicId â†’ lista de claves de niveles completados (ej. ['facil', 'medio'])
  Map<String, List<String>> _completedLevels = {};

  GamificationProvider? _gamification;

  LearningProvider(this._storage) {
    _completedLevels = _storage.loadLearningProgress();
  }

  void updateGamification(GamificationProvider gamification) {
    _gamification = gamification;
  }

  // â”€â”€â”€ Getters â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  LearningSession? get currentSession => _currentSession;

  Question? get currentQuestion {
    if (_currentSession == null) return null;
    final id = _currentSession!.currentQuestionId;
    if (id == null) return null;
    return SubjectsRepository.getQuestion(id);
  }

  bool get isFinished => _currentSession?.isFinished ?? false;

  /// Verifica si un nivel estÃ¡ desbloqueado para el topic dado.
  bool isLevelUnlocked(String topicId, Dificultad nivel) {
    if (nivel == Dificultad.facil) return true;
    final prev = _previousLevel(nivel);
    if (prev == null) return true;
    return isLevelCompleted(topicId, prev);
  }

  /// Verifica si un nivel ya fue completado (10/10 aciertos).
  bool isLevelCompleted(String topicId, Dificultad nivel) {
    return _completedLevels[topicId]?.contains(nivel.key) ?? false;
  }

  /// Retorna el nivel mÃ¡s alto desbloqueado (pero no necesariamente completado).
  Dificultad getCurrentLevel(String topicId) {
    for (final nivel in Dificultad.values.reversed) {
      if (isLevelUnlocked(topicId, nivel)) return nivel;
    }
    return Dificultad.facil;
  }

  /// Indica si el topic tiene una sesiÃ³n guardada sin completar para ese nivel.
  bool hasPendingSession(String topicId, Dificultad nivel) {
    final saved = _storage.loadLearningSession(topicId, nivel);
    return saved != null && !saved.isLevelCompleted;
  }

  // â”€â”€â”€ Acciones â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// Inicia una nueva sesiÃ³n guiada. Reemplaza cualquier sesiÃ³n pendiente del mismo nivel.
  void startSession(String topicId, Dificultad nivel) {
    final questions = SubjectsRepository.getQuestionsByTopicAndLevel(
      topicId,
      nivel,
      count: LearningSession.targetCorrect,
    );

    if (questions.isEmpty) return;

    final session = LearningSession(
      id: const Uuid().v4(),
      topicId: topicId,
      nivel: nivel,
      questionQueue: questions.map((q) => q.id).toList(),
    );

    _currentSession = session;
    _storage.saveLearningSession(session);
    _storage.saveLastActiveLearningSession(topicId, nivel.key);
    notifyListeners();
  }

  /// Reanuda una sesiÃ³n previamente guardada, si existe.
  /// Retorna true si se reanudÃ³, false si no habÃ­a sesiÃ³n guardada.
  bool resumeSession(String topicId, Dificultad nivel) {
    final saved = _storage.loadLearningSession(topicId, nivel);
    if (saved == null || saved.isLevelCompleted) return false;
    _currentSession = saved;
    _storage.saveLastActiveLearningSession(topicId, nivel.key);
    notifyListeners();
    return true;
  }

  /// Carga la sesiÃ³n actual desde storage (Ãºtil al volver de background).
  void loadSession(String topicId, Dificultad nivel) {
    final saved = _storage.loadLearningSession(topicId, nivel);
    if (saved != null && !saved.isLevelCompleted) {
      _currentSession = saved;
      notifyListeners();
    }
  }

  /// Procesa la respuesta del usuario.
  ///
  /// - **Correcto**: elimina la pregunta de la cola, incrementa [correctCount].
  ///   Si llega a 10, marca el nivel como completado.
  /// - **Incorrecto**: reencola la pregunta al final, no suma puntos.
  ///
  /// Guarda el estado automÃ¡ticamente tras cada respuesta.
  void responder(String questionId, int selectedIndex, int correctAnswer) {
    if (_currentSession == null) return;
    if (_currentSession!.questionQueue.isEmpty) return;

    final isCorrect = selectedIndex == correctAnswer;

    if (isCorrect) {
      // Sacar del frente
      _currentSession!.questionQueue.remove(questionId);
      if (!_currentSession!.completedIds.contains(questionId)) {
        _currentSession!.completedIds.add(questionId);
      }
      _currentSession!.correctCount++;

      if (_currentSession!.isFinished) {
        _markLevelCompleted();
      }
    } else {
      // Remover del frente y reencolar al final
      _currentSession!.questionQueue.remove(questionId);
      _currentSession!.questionQueue.add(questionId);
    }

    // Persistir tras cada respuesta
    _storage.saveLearningSession(_currentSession!);
    if (!_currentSession!.isLevelCompleted) {
      _storage.saveLastActiveLearningSession(
        _currentSession!.topicId,
        _currentSession!.nivel.key,
      );
    }
    notifyListeners();
  }

  /// Marca el nivel actual como completado en el progreso del usuario.
  void _markLevelCompleted() {
    if (_currentSession == null) return;
    final topicId = _currentSession!.topicId;
    final nivelKey = _currentSession!.nivel.key;

    _completedLevels[topicId] ??= [];
    if (!_completedLevels[topicId]!.contains(nivelKey)) {
      _completedLevels[topicId]!.add(nivelKey);
    }

    _currentSession!.isLevelCompleted = true;
    _currentSession!.finishedAt = DateTime.now();
    
    _gamification?.addXp(50);

    _storage.saveLearningProgress(_completedLevels);
    _storage.saveLearningSession(_currentSession!);
    _storage.deleteLastActiveLearningSession();
  }

  /// Limpia la sesiÃ³n activa de memoria (no borra del storage).
  void clearCurrentSession() {
    _currentSession = null;
    notifyListeners();
  }

  double getScrollPosition(String topicId, Dificultad nivel) {
    return _storage.getScrollPosition(topicId, nivel.key);
  }

  void saveScrollPosition(String topicId, Dificultad nivel, double position) {
    _storage.saveScrollPosition(topicId, nivel.key, position);
  }

  // Reinicia el progreso de un topic (para pruebas o reset del usuario)
  void resetTopicProgress(String topicId) {
    _completedLevels.remove(topicId);
    _storage.saveLearningProgress(_completedLevels);
    for (final nivel in Dificultad.values) {
      _storage.deleteLearningSession(topicId, nivel);
    }
    final lastActive = _storage.loadLastActiveLearningSession();
    if (lastActive != null && lastActive['topicId'] == topicId) {
      _storage.deleteLastActiveLearningSession();
    }
    _currentSession = null;
    notifyListeners();
  }

  /// Retorna el nivel de la sesiÃ³n pendiente para un tema dado, si existe.
  Dificultad? getPendingSessionLevel(String topicId) {
    for (final nivel in Dificultad.values) {
      if (hasPendingSession(topicId, nivel)) {
        return nivel;
      }
    }
    return null;
  }

  /// Retorna una sesiÃ³n de aprendizaje guardada.
  LearningSession? getPendingSession(String topicId, Dificultad nivel) {
    return _storage.loadLearningSession(topicId, nivel);
  }

  /// Retorna los detalles de la Ãºltima sesiÃ³n activa pendiente de aprendizaje guiado.
  Map<String, dynamic>? getLastActiveSessionInfo() {
    final info = _storage.loadLastActiveLearningSession();
    if (info == null) return null;

    final topicId = info['topicId']!;
    final nivelKey = info['nivel']!;
    final nivel = Dificultad.fromString(nivelKey);

    final session = _storage.loadLearningSession(topicId, nivel);
    if (session == null || session.isLevelCompleted) {
      _storage.deleteLastActiveLearningSession();
      return null;
    }

    return {
      'topicId': topicId,
      'nivel': nivel,
      'session': session,
    };
  }

  // â”€â”€â”€ Helpers â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Dificultad? _previousLevel(Dificultad nivel) {
    switch (nivel) {
      case Dificultad.medio:
        return Dificultad.facil;
      case Dificultad.dificil:
        return Dificultad.medio;
      case Dificultad.extremo:
        return Dificultad.dificil;
      default:
        return null;
    }
  }
}

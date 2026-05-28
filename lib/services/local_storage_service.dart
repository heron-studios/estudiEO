import 'package:get_storage/get_storage.dart';
import 'package:learn/models/srs_card.dart';
import 'package:learn/models/gamification.dart';
import 'package:learn/models/quiz_session.dart';
import 'package:learn/models/learning_session.dart';
import 'package:learn/models/learning_level.dart';
import 'package:flutter/foundation.dart';

class LocalStorageService {
  static const String srsKey = 'srs_data';
  static const String gamificationKey = 'gamification_data';
  static const String quizSessionsKey = 'quiz_sessions';
  static const String syncMetaKey = 'sync_meta';
  static const String alipioEnabledKey = 'alipio_enabled';
  static const String hiddenSubjectsKey = 'hidden_subjects';
  static const String learnedQuestionsKey = 'learned_questions';
  static const String strictModeKey = 'srs_strict_mode';
  static const String learningSessionsKey = 'learning_sessions';
  static const String learningProgressKey = 'learning_progress';
  static const String lastActiveLearningSessionKey = 'last_active_learning_session';

  final GetStorage _storage = GetStorage();
  Map<String, SrsCard>? _srsCache;
  Map<String, dynamic>? _srsJsonCache;

  Future<void> init() async {
    // GetStorage already initialized in main.dart
    // This is now a no-op but kept for backward compatibility
    try {
      _srsCache = null; // Clear cache on init
      _srsJsonCache = null;
    } catch (e) {
      debugPrint('LocalStorageService init: $e');
    }
  }

  // ─── SRS Data ───────────────────────────────────────

  Map<String, SrsCard> loadSrsCards() {
    if (_srsCache != null) return _srsCache!;
    try {
      final rawData = _storage.read(srsKey) as Map? ?? {};
      _srsJsonCache = Map<String, dynamic>.from(rawData);

      _srsCache = _srsJsonCache!.map(
        (key, value) => MapEntry(
          key.toString(),
          SrsCard.fromJson(Map<String, dynamic>.from(value as Map)),
        ),
      );
      return _srsCache!;
    } catch (e) {
      debugPrint('Error loading SRS cards: $e');
      _srsJsonCache = {};
      _srsCache = {};
      return {};
    }
  }

  void saveSrsCards(Map<String, SrsCard> cards) {
    try {
      _srsCache = cards;
      _srsJsonCache = cards.map((key, card) => MapEntry(key, card.toJson()));
      _storage.write(srsKey, _srsJsonCache);
      _touchSyncMeta();
    } catch (e) {
      debugPrint('Error saving SRS cards: $e');
    }
  }

  SrsCard? getSrsCard(String questionId) {
    final cards = loadSrsCards();
    return cards[questionId];
  }

  void saveSrsCard(SrsCard card) {
    final cards = loadSrsCards();
    cards[card.questionId] = card;

    _srsJsonCache ??= {};
    _srsJsonCache![card.questionId] = card.toJson();

    _storage.write(srsKey, _srsJsonCache);
    _touchSyncMeta();
  }

  // â”€â”€â”€ Gamification Data â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Gamification loadGamification() {
    try {
      final data = _storage.read(gamificationKey);
      if (data == null) {
        return Gamification();
      }
      return Gamification.fromJson(Map<String, dynamic>.from(data as Map));
    } catch (e) {
      debugPrint('Error loading gamification: $e');
      return Gamification();
    }
  }

  void saveGamification(Gamification gamification) {
    try {
      _storage.write(gamificationKey, gamification.toJson());
      _touchSyncMeta();
    } catch (e) {
      debugPrint('Error saving gamification: $e');
    }
  }

  // â”€â”€â”€ Quiz Sessions â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  List<QuizSession> loadQuizSessions() {
    try {
      final data = _storage.read(quizSessionsKey) as List? ?? [];
      return data
          .map(
            (item) =>
                QuizSession.fromJson(Map<String, dynamic>.from(item as Map)),
          )
          .toList();
    } catch (e) {
      debugPrint('Error loading quiz sessions: $e');
      return [];
    }
  }

  void saveQuizSessions(List<QuizSession> sessions) {
    try {
      _storage.write(quizSessionsKey, sessions.map((s) => s.toJson()).toList());
      _touchSyncMeta();
    } catch (e) {
      debugPrint('Error saving quiz sessions: $e');
    }
  }

  void saveQuizSession(QuizSession session) {
    final sessions = loadQuizSessions();
    final index = sessions.indexWhere((s) => s.id == session.id);
    if (index >= 0) {
      sessions[index] = session;
    } else {
      sessions.add(session);
    }
    saveQuizSessions(sessions);
  }

  // â”€â”€â”€ Sync Meta â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  void _touchSyncMeta() {
    _storage.write(syncMetaKey, {
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  DateTime getLastSyncTime() {
    try {
      final meta = _storage.read(syncMetaKey) as Map? ?? {};
      final updatedAt = meta['updatedAt'];
      if (updatedAt != null) {
        return DateTime.parse(updatedAt);
      }
    } catch (e) {
      debugPrint('Error getting last sync time: $e');
    }
    return DateTime.now();
  }

  // â”€â”€â”€ Alipio (Gemini AI) setting â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  bool loadAlipioEnabled() {
    return _storage.read(alipioEnabledKey) as bool? ?? false;
  }

  void saveAlipioEnabled(bool value) {
    _storage.write(alipioEnabledKey, value);
  }

  // ─── Strict Mode setting ───────────────────────────
  bool loadStrictMode() {
    return _storage.read(strictModeKey) as bool? ?? true;
  }

  void saveStrictMode(bool value) {
    _storage.write(strictModeKey, value);
  }

  // â”€â”€â”€ Hidden Subjects â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  List<String> loadHiddenSubjects() {
    final data = _storage.read(hiddenSubjectsKey) as List?;
    return data?.map((e) => e.toString()).toList() ?? [];
  }

  void saveHiddenSubjects(List<String> hidden) {
    _storage.write(hiddenSubjectsKey, hidden);
  }

  // ─── Learned Questions ─────────────────────────────
  Map<String, List<String>> loadLearnedQuestions() {
    try {
      final data = _storage.read(learnedQuestionsKey) as Map?;
      if (data == null) return {};

      return data.map(
        (key, value) => MapEntry(
          key.toString(),
          (value as List).map((e) => e.toString()).toList(),
        ),
      );
    } catch (e) {
      debugPrint('Error loading learned questions: $e');
      return {};
    }
  }

  void saveLearnedQuestions(Map<String, List<String>> learned) {
    _storage.write(learnedQuestionsKey, learned);
  }

  // ─── Scroll Position Persist ─────────────────────────
  double getScrollPosition(String topicId, String levelKey) {
    try {
      final key = 'scroll_${topicId}_$levelKey';
      return _storage.read(key) as double? ?? 0.0;
    } catch (_) {
      return 0.0;
    }
  }

  void saveScrollPosition(String topicId, String levelKey, double position) {
    try {
      final key = 'scroll_${topicId}_$levelKey';
      _storage.write(key, position);
    } catch (_) {}
  }

  // ─── Learning Sessions ────────────────────────────────────────────────────

  LearningSession? loadLearningSession(String topicId, Dificultad nivel) {
    try {
      final data = _storage.read(learningSessionsKey) as Map? ?? {};
      final key = '${topicId}_${nivel.key}';
      final raw = data[key];
      if (raw == null) return null;
      return LearningSession.fromJson(Map<String, dynamic>.from(raw as Map));
    } catch (e) {
      debugPrint('Error loading learning session: $e');
      return null;
    }
  }

  void saveLearningSession(LearningSession session) {
    try {
      final data = Map<String, dynamic>.from(
        (_storage.read(learningSessionsKey) as Map? ?? {}),
      );
      final key = '${session.topicId}_${session.nivel.key}';
      data[key] = session.toJson();
      _storage.write(learningSessionsKey, data);
      _touchSyncMeta();
    } catch (e) {
      debugPrint('Error saving learning session: $e');
    }
  }

  void deleteLearningSession(String topicId, Dificultad nivel) {
    try {
      final data = Map<String, dynamic>.from(
        (_storage.read(learningSessionsKey) as Map? ?? {}),
      );
      final key = '${topicId}_${nivel.key}';
      data.remove(key);
      _storage.write(learningSessionsKey, data);
    } catch (e) {
      debugPrint('Error deleting learning session: $e');
    }
  }

  // ─── Last Active Learning Session ──────────────────────────────────────────

  void saveLastActiveLearningSession(String topicId, String levelKey) {
    try {
      _storage.write(lastActiveLearningSessionKey, {
        'topicId': topicId,
        'nivel': levelKey,
      });
    } catch (e) {
      debugPrint('Error saving last active learning session: $e');
    }
  }

  Map<String, String>? loadLastActiveLearningSession() {
    try {
      final data = _storage.read(lastActiveLearningSessionKey);
      if (data == null) return null;
      final map = Map<String, dynamic>.from(data as Map);
      return {
        'topicId': map['topicId'] as String,
        'nivel': map['nivel'] as String,
      };
    } catch (e) {
      debugPrint('Error loading last active learning session: $e');
      return null;
    }
  }

  void deleteLastActiveLearningSession() {
    try {
      _storage.remove(lastActiveLearningSessionKey);
    } catch (e) {
      debugPrint('Error deleting last active learning session: $e');
    }
  }

  // ─── Learning Progress (niveles completados por topic) ────────────────────

  /// Retorna un mapa topicId → lista de niveles completados.
  Map<String, List<String>> loadLearningProgress() {
    try {
      final data = _storage.read(learningProgressKey) as Map? ?? {};
      return data.map(
        (k, v) => MapEntry(
          k.toString(),
          (v as List).map((e) => e.toString()).toList(),
        ),
      );
    } catch (e) {
      debugPrint('Error loading learning progress: $e');
      return {};
    }
  }

  void saveLearningProgress(Map<String, List<String>> progress) {
    try {
      _storage.write(learningProgressKey, progress);
      _touchSyncMeta();
    } catch (e) {
      debugPrint('Error saving learning progress: $e');
    }
  }

  // ─── Utility ───────────────────────────────────────————————————————————————————————————

  void clearAll() {
    _storage.erase();
    _srsCache = null;
    _srsJsonCache = null;
  }

  Map<String, dynamic> getDataBundle() {
    return {
      'srs': loadSrsCards().map((k, v) => MapEntry(k, v.toJson())),
      'gamification': loadGamification().toJson(),
      'quizSessions': loadQuizSessions().map((s) => s.toJson()).toList(),
      'learningSessions': _storage.read(learningSessionsKey) ?? {},
      'learningProgress': _storage.read(learningProgressKey) ?? {},
      'updatedAt': getLastSyncTime().toIso8601String(),
    };
  }

  void applyDataBundle(Map<String, dynamic> bundle) {
    try {
      if (bundle['srs'] != null) {
        final srsData = Map<String, SrsCard>.from(
          (bundle['srs'] as Map).map(
            (k, v) => MapEntry(
              k.toString(),
              SrsCard.fromJson(Map<String, dynamic>.from(v as Map)),
            ),
          ),
        );
        saveSrsCards(srsData);
      }

      if (bundle['gamification'] != null) {
        final gami = Gamification.fromJson(
          Map<String, dynamic>.from(bundle['gamification'] as Map),
        );
        saveGamification(gami);
      }

      if (bundle['quizSessions'] != null) {
        final sessions = (bundle['quizSessions'] as List)
            .map(
              (s) => QuizSession.fromJson(Map<String, dynamic>.from(s as Map)),
            )
            .toList();
        saveQuizSessions(sessions);
      }

      if (bundle['learningSessions'] != null) {
        _storage.write(learningSessionsKey, bundle['learningSessions']);
      }

      if (bundle['learningProgress'] != null) {
        _storage.write(learningProgressKey, bundle['learningProgress']);
      }

      _touchSyncMeta();
    } catch (e) {
      debugPrint('Error applying data bundle: $e');
    }
  }
}

import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn/models/srs_card.dart';
import 'package:learn/models/gamification.dart';
import 'package:learn/models/quiz_session.dart';
import 'package:learn/models/learning_session.dart';
import 'package:learn/models/learning_level.dart';
import 'package:learn/models/interview_result.dart';
import 'package:learn/models/question.dart';
import 'package:learn/models/topic.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class LocalStorageService {
  static const String srsKey = 'srs_data';
  static const String gamificationKey = 'gamification_data';
  static const String quizSessionsKey = 'quiz_sessions';
  static const String syncMetaKey = 'sync_meta';
  static const String tutorAiEnabledKey = 'tutor_ai_enabled';
  static const String hiddenSubjectsKey = 'hidden_subjects';
  static const String learnedQuestionsKey = 'learned_questions';
  static const String hasSeenOnboardingKey = 'has_seen_onboarding';
  static const String strictModeKey = 'srs_strict_mode';
  static const String sfxMutedKey = 'sfx_muted';
  static const String learningSessionsKey = 'learning_sessions';
  static const String learningProgressKey = 'learning_progress';
  static const String lastActiveLearningSessionKey =
      'last_active_learning_session';
  static const String activeExamStateKey = 'active_exam_state';
  static const String examHistoryKey = 'exam_history';
  static const String flashcardGenDateKey = 'flashcard_gen_date';
  static const String customTopicsKey = 'custom_topics';
  static const String tutorAiCacheTextKey = 'tutor_ai_cache_text';
  static const String tutorAiCacheTimeKey = 'tutor_ai_cache_time';
  static const String targetSchoolKey = 'target_school';
  static const String userNameKey = 'user_name';

  final Box _storage = Hive.box('EDUPOL_data');
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

  // ─── Profile Data ───────────────────────────────────────

  Future<void> saveTargetSchool(String school) async {
    await _storage.put(targetSchoolKey, school);
  }

  String loadTargetSchool() {
    return _storage.get(targetSchoolKey) as String? ?? 'EO PNP';
  }

  Future<void> saveUserName(String name) async {
    await _storage.put(userNameKey, name);
  }

  String loadUserName() {
    return _storage.get(userNameKey) as String? ?? 'Aspirante';
  }

  // ─── SRS Data ───────────────────────────────────────

  Map<String, SrsCard> loadSrsCards() {
    if (_srsCache != null) return _srsCache!;
    try {
      final rawData = _storage.get(srsKey) as Map? ?? {};
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
      _storage.put(srsKey, _srsJsonCache);
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

    _storage.put(srsKey, _srsJsonCache);
    _touchSyncMeta();
  }

  // â”€â”€â”€ Gamification Data â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Gamification loadGamification() {
    try {
      final data = _storage.get(gamificationKey);
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
      _storage.put(gamificationKey, gamification.toJson());
      _touchSyncMeta();
    } catch (e) {
      debugPrint('Error saving gamification: $e');
    }
  }

  // â”€â”€â”€ Quiz Sessions â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  List<QuizSession> loadQuizSessions() {
    try {
      final data = _storage.get(quizSessionsKey) as List? ?? [];
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
      _storage.put(quizSessionsKey, sessions.map((s) => s.toJson()).toList());
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
    _storage.put(syncMetaKey, {'updatedAt': DateTime.now().toIso8601String()});
  }

  DateTime getLastSyncTime() {
    try {
      final meta = _storage.get(syncMetaKey) as Map? ?? {};
      final updatedAt = meta['updatedAt'];
      if (updatedAt != null) {
        return DateTime.parse(updatedAt);
      }
    } catch (e) {
      debugPrint('Error getting last sync time: $e');
    }
    return DateTime.now();
  }

  // ─── Tutor IA setting ──────────────────────────────
  bool loadTutorEnabled() {
    return _storage.get(tutorAiEnabledKey) as bool? ?? false;
  }

  void saveTutorEnabled(bool value) {
    _storage.put(tutorAiEnabledKey, value);
  }

  // ─── Onboarding setting ──────────────────────────────
  bool loadHasSeenOnboarding() {
    return _storage.get(hasSeenOnboardingKey) as bool? ?? false;
  }

  void saveHasSeenOnboarding(bool value) {
    _storage.put(hasSeenOnboardingKey, value);
  }

  // ─── Strict Mode setting ───────────────────────────
  bool loadStrictMode() {
    return _storage.get(strictModeKey) as bool? ?? true;
  }

  void saveStrictMode(bool value) {
    _storage.put(strictModeKey, value);
  }

  // ─── SFX Muted setting ─────────────────────────────
  bool loadMuted() {
    return _storage.get(sfxMutedKey) as bool? ?? false;
  }

  void saveMuted(bool value) {
    _storage.put(sfxMutedKey, value);
  }

  // â”€â”€â”€ Hidden Subjects â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  List<String> loadHiddenSubjects() {
    final data = _storage.get(hiddenSubjectsKey) as List?;
    return data?.map((e) => e.toString()).toList() ?? [];
  }

  void saveHiddenSubjects(List<String> hidden) {
    _storage.put(hiddenSubjectsKey, hidden);
  }

  // ─── Learned Questions ─────────────────────────────
  Map<String, List<String>> loadLearnedQuestions() {
    try {
      final data = _storage.get(learnedQuestionsKey) as Map?;
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
    _storage.put(learnedQuestionsKey, learned);
  }

  // ─── Scroll Position Persist ─────────────────────────
  double getScrollPosition(String topicId, String levelKey) {
    try {
      final key = 'scroll_${topicId}_$levelKey';
      return _storage.get(key) as double? ?? 0.0;
    } catch (_) {
      return 0.0;
    }
  }

  void saveScrollPosition(String topicId, String levelKey, double position) {
    try {
      final key = 'scroll_${topicId}_$levelKey';
      _storage.put(key, position);
    } catch (_) {}
  }

  // ─── Learning Sessions ────────────────────────────────────────────────────

  LearningSession? loadLearningSession(String topicId, Dificultad nivel) {
    try {
      final data = _storage.get(learningSessionsKey) as Map? ?? {};
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
        (_storage.get(learningSessionsKey) as Map? ?? {}),
      );
      final key = '${session.topicId}_${session.nivel.key}';
      data[key] = session.toJson();
      _storage.put(learningSessionsKey, data);
      _touchSyncMeta();
    } catch (e) {
      debugPrint('Error saving learning session: $e');
    }
  }

  void deleteLearningSession(String topicId, Dificultad nivel) {
    try {
      final data = Map<String, dynamic>.from(
        (_storage.get(learningSessionsKey) as Map? ?? {}),
      );
      final key = '${topicId}_${nivel.key}';
      data.remove(key);
      _storage.put(learningSessionsKey, data);
    } catch (e) {
      debugPrint('Error deleting learning session: $e');
    }
  }

  // ─── Last Active Learning Session ──────────────────────────────────────────

  void saveLastActiveLearningSession(String topicId, String levelKey) {
    try {
      _storage.put(lastActiveLearningSessionKey, {
        'topicId': topicId,
        'nivel': levelKey,
      });
    } catch (e) {
      debugPrint('Error saving last active learning session: $e');
    }
  }

  Map<String, String>? loadLastActiveLearningSession() {
    try {
      final data = _storage.get(lastActiveLearningSessionKey);
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
      _storage.delete(lastActiveLearningSessionKey);
    } catch (e) {
      debugPrint('Error deleting last active learning session: $e');
    }
  }

  // ─── Learning Progress (niveles completados por topic) ────────────────────

  /// Retorna un mapa topicId → lista de niveles completados.
  Map<String, List<String>> loadLearningProgress() {
    try {
      final data = _storage.get(learningProgressKey) as Map? ?? {};
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
      _storage.put(learningProgressKey, progress);
      _touchSyncMeta();
    } catch (e) {
      debugPrint('Error saving learning progress: $e');
    }
  }

  static const String psicolearnLastCompletedDateKey =
      'psicolearn_last_completed_date';
  static const String psicolearnStreakKey = 'psicolearn_streak';
  static const String psicolearnCurrentIndexKey = 'psicolearn_current_index';
  static const String psicolearnCurrentIndexDateKey =
      'psicolearn_current_index_date';
  static const String psicolearnDailyMissionIdsKey =
      'psicolearn_daily_mission_ids';
  static const String psicolearnDailyMissionDateKey =
      'psicolearn_daily_mission_date';
  static const String psicolearnLastScoresKey = 'psicolearn_last_scores';
  static const String psicolearnLastOverallScoreKey =
      'psicolearn_last_overall_score';
  static const String psicolearnTotalMissionsKey = 'psicolearn_total_missions';

  // ─── PsicoLearn Progress ─────────────────────────────────────────────

  List<int>? getPsicoDailyMissionIds() {
    try {
      final dateRaw = _storage.get(psicolearnDailyMissionDateKey);
      if (dateRaw != null) {
        final date = DateTime.parse(dateRaw.toString());
        final now = DateTime.now();
        if (now.year == date.year &&
            now.month == date.month &&
            now.day == date.day) {
          final data = _storage.get(psicolearnDailyMissionIdsKey) as List?;
          if (data != null) {
            return data
                .map((e) => int.tryParse(e.toString()) ?? -1)
                .where((id) => id != -1)
                .toList();
          }
        }
      }
    } catch (_) {}
    return null;
  }

  void savePsicoDailyMissionIds(List<int> ids) {
    try {
      _storage.put(psicolearnDailyMissionIdsKey, ids);
      _storage.put(
        psicolearnDailyMissionDateKey,
        DateTime.now().toIso8601String(),
      );
    } catch (_) {}
  }

  void clearPsicoDailyMissionIds() {
    try {
      _storage.delete(psicolearnDailyMissionIdsKey);
      _storage.delete(psicolearnDailyMissionDateKey);
    } catch (_) {}
  }

  int getPsicoMissionCurrentIndex() {
    try {
      final dateRaw = _storage.get(psicolearnCurrentIndexDateKey);
      if (dateRaw != null) {
        final date = DateTime.parse(dateRaw.toString());
        final now = DateTime.now();
        if (now.year == date.year &&
            now.month == date.month &&
            now.day == date.day) {
          return _storage.get(psicolearnCurrentIndexKey) as int? ?? 0;
        }
      }
      return 0;
    } catch (_) {
      return 0;
    }
  }

  void savePsicoMissionCurrentIndex(int index) {
    try {
      _storage.put(psicolearnCurrentIndexKey, index);
      _storage.put(
        psicolearnCurrentIndexDateKey,
        DateTime.now().toIso8601String(),
      );
    } catch (_) {}
  }

  double getPsicoLastOverallScore() {
    try {
      return _storage.get(psicolearnLastOverallScoreKey) as double? ?? 0.0;
    } catch (_) {
      return 0.0;
    }
  }

  void savePsicoLastOverallScore(double score) {
    try {
      _storage.put(psicolearnLastOverallScoreKey, score);
    } catch (_) {}
  }

  int getPsicoTotalMissions() {
    try {
      return _storage.get(psicolearnTotalMissionsKey) as int? ?? 0;
    } catch (_) {
      return 0;
    }
  }

  void incrementPsicoTotalMissions() {
    try {
      final current = getPsicoTotalMissions();
      _storage.put(psicolearnTotalMissionsKey, current + 1);
    } catch (_) {}
  }

  Map<String, double> getPsicoLastScores() {
    try {
      final raw = _storage.get(psicolearnLastScoresKey) as Map?;
      if (raw != null) {
        return raw.map((k, v) => MapEntry(k.toString(), (v as num).toDouble()));
      }
    } catch (_) {}
    return {};
  }

  void savePsicoLastScores(Map<String, double> scores) {
    try {
      _storage.put(psicolearnLastScoresKey, scores);
    } catch (_) {}
  }

  void savePsicoMissionResult({
    required double overallScore,
    required Map<String, double> dimensionScores,
  }) {
    try {
      savePsicoLastOverallScore(overallScore);
      savePsicoLastScores(dimensionScores);
      incrementPsicoTotalMissions();
    } catch (_) {}
  }

  void markPsicoMissionCompleted() {
    try {
      final now = DateTime.now();
      final lastCompletedRaw = _storage.get(psicolearnLastCompletedDateKey);
      int streak = _storage.get(psicolearnStreakKey) as int? ?? 0;

      if (lastCompletedRaw != null) {
        final lastCompleted = DateTime.parse(lastCompletedRaw.toString());

        // Use year/month/day to check if it was yesterday
        final yesterday = DateTime(
          now.year,
          now.month,
          now.day,
        ).subtract(const Duration(days: 1));
        final lastCompletedDate = DateTime(
          lastCompleted.year,
          lastCompleted.month,
          lastCompleted.day,
        );

        if (lastCompletedDate == yesterday) {
          // Increment streak
          streak++;
        } else if (lastCompletedDate.isBefore(yesterday)) {
          // Reset streak
          streak = 1;
        }
        // if today, do nothing to streak
      } else {
        streak = 1;
      }

      _storage.put(psicolearnStreakKey, streak);
      _storage.put(psicolearnLastCompletedDateKey, now.toIso8601String());
      clearPsicoDailyMissionIds();
    } catch (e) {
      debugPrint('Error marking psico mission completed: $e');
    }
  }

  Map<String, dynamic> getPsicoProgress() {
    try {
      final streak = _storage.get(psicolearnStreakKey) as int? ?? 0;
      final lastCompletedRaw = _storage.get(psicolearnLastCompletedDateKey);
      bool todayCompleted = false;

      if (lastCompletedRaw != null) {
        final lastCompleted = DateTime.parse(lastCompletedRaw.toString());
        final now = DateTime.now();
        if (now.year == lastCompleted.year &&
            now.month == lastCompleted.month &&
            now.day == lastCompleted.day) {
          todayCompleted = true;
        }
      }

      final totalMissions = getPsicoTotalMissions();
      // Si completó hoy pero totalMissions es 0, significa que completó la versión antigua.
      // Permitimos hacerla de nuevo hoy para registrar la puntuación en el nuevo sistema.
      final bool actualTodayCompleted = todayCompleted && totalMissions > 0;

      return {
        'streak': streak,
        'todayCompleted': actualTodayCompleted,
        'lastOverallScore': getPsicoLastOverallScore(),
        'totalMissions': totalMissions,
        'lastScores': getPsicoLastScores(),
      };
    } catch (e) {
      debugPrint('Error getting psico progress: $e');
      return {
        'streak': 0,
        'todayCompleted': false,
        'lastOverallScore': 0.0,
        'totalMissions': 0,
        'lastScores': <String, double>{},
      };
    }
  }

  // ─── PsicoLearn Re Entrenamiento ──────────────────────────────────────────

  static const String psicolearnFailedQuestionsKey =
      'psicolearn_failed_questions';

  List<int> getFailedPsicoQuestionIds() {
    try {
      final data = _storage.get(psicolearnFailedQuestionsKey) as List?;
      if (data == null) return [];
      return data
          .map((e) => int.tryParse(e.toString()) ?? -1)
          .where((id) => id != -1)
          .toList();
    } catch (_) {
      return [];
    }
  }

  void addFailedPsicoQuestion(int id) {
    try {
      final ids = getFailedPsicoQuestionIds();
      if (!ids.contains(id)) {
        ids.add(id);
        _storage.put(psicolearnFailedQuestionsKey, ids);
      }
    } catch (_) {}
  }

  void removeFailedPsicoQuestion(int id) {
    try {
      final ids = getFailedPsicoQuestionIds();
      if (ids.contains(id)) {
        ids.remove(id);
        _storage.put(psicolearnFailedQuestionsKey, ids);
      }
    } catch (_) {}
  }

  // ─── Simulacro Examen (Exam Simulation) ───────────────────────────────────

  void saveActiveExamState(Map<String, dynamic> state) {
    try {
      _storage.put(activeExamStateKey, state);
    } catch (e) {
      debugPrint('Error saving active exam state: $e');
    }
  }

  Map<String, dynamic>? getActiveExamState() {
    try {
      final data = _storage.get(activeExamStateKey);
      if (data == null) return null;
      return Map<String, dynamic>.from(data as Map);
    } catch (e) {
      debugPrint('Error getting active exam state: $e');
      return null;
    }
  }

  void clearActiveExamState() {
    try {
      _storage.delete(activeExamStateKey);
    } catch (e) {
      debugPrint('Error clearing active exam state: $e');
    }
  }

  void saveExamHistory(Map<String, dynamic> examRecord) {
    try {
      final history = getExamHistory();
      history.insert(0, examRecord); // Insert at the beginning (newest first)
      if (history.length > 5) {
        history.removeLast(); // Keep only last 5 exams
      }
      _storage.put(examHistoryKey, history);
    } catch (e) {
      debugPrint('Error saving exam history: $e');
    }
  }

  List<Map<String, dynamic>> getExamHistory() {
    try {
      final data = _storage.get(examHistoryKey) as List?;
      if (data == null) return [];
      return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (e) {
      debugPrint('Error getting exam history: $e');
      return [];
    }
  }

  // ─── Utility ───────────────────────────────────────————————————————————————————————————

  void clearAll() {
    _storage.clear();
    _srsCache = null;
    _srsJsonCache = null;
  }

  Map<String, dynamic> getDataBundle() {
    return {
      'srs': loadSrsCards().map((k, v) => MapEntry(k, v.toJson())),
      'gamification': loadGamification().toJson(),
      'quizSessions': loadQuizSessions().map((s) => s.toJson()).toList(),
      'learningSessions': _storage.get(learningSessionsKey) ?? {},
      'learningProgress': _storage.get(learningProgressKey) ?? {},
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
        _storage.put(learningSessionsKey, bundle['learningSessions']);
      }

      if (bundle['learningProgress'] != null) {
        _storage.put(learningProgressKey, bundle['learningProgress']);
      }

      _touchSyncMeta();
    } catch (e) {
      debugPrint('Error applying data bundle: $e');
    }
  }

  List<String> getInterviewMasteredQuestions() {
    final data = _storage.get('interview_mastered') as List?;
    return data?.map((e) => e.toString()).toList() ?? [];
  }

  void saveInterviewMasteredQuestions(List<String> mastered) {
    _storage.put('interview_mastered', mastered);
  }

  bool getInterviewRealismMode() {
    return _storage.get('interview_realism_mode', defaultValue: false) as bool;
  }

  // --- Interview Date ---
  String getLastInterviewDate() {
    try {
      return _storage.get('last_interview_date', defaultValue: '') as String;
    } catch (_) {
      return '';
    }
  }

  void saveLastInterviewDate(DateTime date) {
    try {
      _storage.put(
        'last_interview_date',
        DateFormat('yyyy-MM-dd').format(date),
      );
    } catch (_) {}
  }

  // --- Interview History ---
  static const String _kInterviewHistory = 'interview_history_v1';

  /// Retorna el historial de entrevistas ordenado del más reciente al más antiguo.
  List<InterviewResult> getInterviewHistory() {
    try {
      final raw = _storage.get(_kInterviewHistory) as List? ?? [];
      return raw
          .map(
            (e) =>
                InterviewResult.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      debugPrint('Error loading interview history: $e');
      return [];
    }
  }

  /// Guarda un nuevo resultado de entrevista en el historial (máx 30 registros).
  void saveInterviewResult(InterviewResult result) {
    try {
      final history = getInterviewHistory();
      history.insert(0, result);
      // Limitar a los últimos 30 registros
      final trimmed = history.take(30).toList();
      _storage.put(_kInterviewHistory, trimmed.map((r) => r.toJson()).toList());
    } catch (e) {
      debugPrint('Error saving interview result: $e');
    }
  }

  // --- Custom AI Questions ---
  static const String customQuestionsKey = 'custom_questions';

  List<Question> loadCustomQuestions() {
    try {
      final data = _storage.get(customQuestionsKey) as List?;
      if (data == null) return [];
      return data
          .map((e) => Question.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (e) {
      debugPrint('Error loading custom questions: $e');
      return [];
    }
  }

  Question? getCustomQuestion(String id) {
    return loadCustomQuestions().where((q) => q.id == id).firstOrNull;
  }

  void saveCustomQuestion(Question question) {
    try {
      final questions = loadCustomQuestions();
      final index = questions.indexWhere((q) => q.id == question.id);
      if (index >= 0) {
        questions[index] = question;
      } else {
        questions.add(question);
      }
      _storage.put(
        customQuestionsKey,
        questions.map((q) => q.toJson()).toList(),
      );
    } catch (e) {
      debugPrint('Error saving custom question: $e');
    }
  }

  // --- Custom Topics ---
  List<Topic> loadCustomTopics() {
    try {
      final data = _storage.get(customTopicsKey) as List?;
      if (data == null) return [];
      return data
          .map((e) => Topic.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (e) {
      debugPrint('Error loading custom topics: $e');
      return [];
    }
  }

  void saveCustomTopic(Topic topic) {
    try {
      final topics = loadCustomTopics();
      final index = topics.indexWhere((t) => t.id == topic.id);
      if (index >= 0) {
        topics[index] = topic;
      } else {
        topics.add(topic);
      }
      _storage.put(customTopicsKey, topics.map((t) => t.toJson()).toList());
    } catch (e) {
      debugPrint('Error saving custom topic: $e');
    }
  }

  // --- Flashcard Generator Limit ---
  DateTime? loadLastFlashcardGenDate() {
    try {
      final dateStr = _storage.get(flashcardGenDateKey) as String?;
      if (dateStr == null || dateStr.isEmpty) return null;
      return DateTime.parse(dateStr);
    } catch (_) {
      return null;
    }
  }

  void saveLastFlashcardGenDate(DateTime date) {
    _storage.put(flashcardGenDateKey, date.toIso8601String());
  }

  // ─── Tutor IA Cache ─────────────────────────────────────────
  void saveTutorAnalysis(String text) {
    _storage.put(tutorAiCacheTextKey, text);
    _storage.put(tutorAiCacheTimeKey, DateTime.now().toIso8601String());
  }

  String? loadTutorAnalysis() {
    return _storage.get(tutorAiCacheTextKey) as String?;
  }

  DateTime? loadTutorAnalysisTime() {
    final timeStr = _storage.get(tutorAiCacheTimeKey) as String?;
    if (timeStr != null) {
      return DateTime.tryParse(timeStr);
    }
    return null;
  }
}

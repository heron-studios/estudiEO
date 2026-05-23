import 'package:get_storage/get_storage.dart';
import 'package:learn/models/srs_card.dart';
import 'package:learn/models/gamification.dart';
import 'package:learn/models/quiz_session.dart';

class LocalStorageService {
  static const String srsKey = 'srs_data';
  static const String gamificationKey = 'gamification_data';
  static const String quizSessionsKey = 'quiz_sessions';
  static const String syncMetaKey = 'sync_meta';
  static const String alipioEnabledKey = 'alipio_enabled';
  static const String hiddenSubjectsKey = 'hidden_subjects';

  final GetStorage _storage = GetStorage();

  Future<void> init() async {
    await GetStorage.init();
  }

  // ─── SRS Data ─────────────────────────────────────

  Map<String, SrsCard> loadSrsCards() {
    try {
      final data = _storage.read(srsKey) as Map? ?? {};
      return data.map(
        (key, value) => MapEntry(
          key.toString(),
          SrsCard.fromJson(Map<String, dynamic>.from(value as Map)),
        ),
      );
    } catch (e) {
      print('Error loading SRS cards: $e');
      return {};
    }
  }

  void saveSrsCards(Map<String, SrsCard> cards) {
    try {
      final data = cards.map((key, card) => MapEntry(key, card.toJson()));
      _storage.write(srsKey, data);
      _touchSyncMeta();
    } catch (e) {
      print('Error saving SRS cards: $e');
    }
  }

  SrsCard? getSrsCard(String questionId) {
    final cards = loadSrsCards();
    return cards[questionId];
  }

  void saveSrsCard(SrsCard card) {
    final cards = loadSrsCards();
    cards[card.questionId] = card;
    saveSrsCards(cards);
  }

  // ─── Gamification Data ────────────────────────────

  Gamification loadGamification() {
    try {
      final data = _storage.read(gamificationKey);
      if (data == null) {
        return Gamification();
      }
      return Gamification.fromJson(Map<String, dynamic>.from(data as Map));
    } catch (e) {
      print('Error loading gamification: $e');
      return Gamification();
    }
  }

  void saveGamification(Gamification gamification) {
    try {
      _storage.write(gamificationKey, gamification.toJson());
      _touchSyncMeta();
    } catch (e) {
      print('Error saving gamification: $e');
    }
  }

  // ─── Quiz Sessions ────────────────────────────────

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
      print('Error loading quiz sessions: $e');
      return [];
    }
  }

  void saveQuizSessions(List<QuizSession> sessions) {
    try {
      _storage.write(quizSessionsKey, sessions.map((s) => s.toJson()).toList());
      _touchSyncMeta();
    } catch (e) {
      print('Error saving quiz sessions: $e');
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

  // ─── Sync Meta ────────────────────────────────────

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
      print('Error getting last sync time: $e');
    }
    return DateTime.now();
  }

  // ─── Alipio (Gemini AI) setting ───────────────────
  bool loadAlipioEnabled() {
    return _storage.read(alipioEnabledKey) as bool? ?? false;
  }

  void saveAlipioEnabled(bool value) {
    _storage.write(alipioEnabledKey, value);
  }

  // ─── Hidden Subjects ─────────────────────────────
  List<String> loadHiddenSubjects() {
    final data = _storage.read(hiddenSubjectsKey) as List?;
    return data?.map((e) => e.toString()).toList() ?? [];
  }

  void saveHiddenSubjects(List<String> hidden) {
    _storage.write(hiddenSubjectsKey, hidden);
  }

  // ─── Utility ───────────────────────────────────────

  void clearAll() {
    _storage.erase();
  }

  Map<String, dynamic> getDataBundle() {
    return {
      'srs': loadSrsCards().map((k, v) => MapEntry(k, v.toJson())),
      'gamification': loadGamification().toJson(),
      'quizSessions': loadQuizSessions().map((s) => s.toJson()).toList(),
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

      _touchSyncMeta();
    } catch (e) {
      print('Error applying data bundle: $e');
    }
  }
}

import 'dart:convert';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/providers/gamification_provider.dart';
import 'package:learn/providers/subject_provider.dart';

/// Recopila y normaliza las métricas de estudio de todos los providers
/// para construir el JSON que se envía a la IA del Tutor Analítico.
class StudyStatsCollector {
  final SrsProvider srs;
  final QuizProvider quiz;
  final GamificationProvider gamification;
  final SubjectProvider subjects;

  StudyStatsCollector({
    required this.srs,
    required this.quiz,
    required this.gamification,
    required this.subjects,
  });

  /// Genera un String JSON con todas las estadísticas relevantes del estudiante
  String buildStatsJson() {
    final gami = gamification.gamification;

    // --- SRS Stats ---
    final srsCards = srs.cards;
    final srsGlobal = srs.globalStats;
    final totalCards = srsCards.length;
    final pendingReviews = srs.getReviewQueue().length;
    final masteredCards = srsCards.values
        .where((c) => c.repetitions >= 5 && c.easeFactor > 2.0)
        .length;

    // --- Quiz Stats ---
    final completedSessions = quiz.sessions
        .where((s) => s.isCompleted)
        .toList();
    final totalSessions = completedSessions.length;

    // Calcular promedio global
    final globalAvg = totalSessions > 0
        ? completedSessions.map((s) => s.percentage).reduce((a, b) => a + b) /
              totalSessions
        : 0.0;

    // Calcular rendimiento por materia
    final subjectList = subjects.subjects;
    final subjectPerformance = <Map<String, dynamic>>[];

    String? bestSubjectId;
    String? worstSubjectId;
    double bestAvg = 0.0;
    double worstAvg = 101.0;

    for (final subject in subjectList) {
      final topicIds = subject.topicIds;
      final subjectSessions = completedSessions
          .where((s) => topicIds.contains(s.topicId))
          .toList();

      if (subjectSessions.isEmpty) continue;

      final avg =
          subjectSessions.map((s) => s.percentage).reduce((a, b) => a + b) /
          subjectSessions.length;
      final best = subjectSessions
          .map((s) => s.percentage)
          .reduce((a, b) => a > b ? a : b);

      subjectPerformance.add({
        'subject': subject.name,
        'sessions': subjectSessions.length,
        'averageScore': (avg * 10).round() / 10,
        'bestScore': (best * 10).round() / 10,
      });

      if (avg > bestAvg) {
        bestAvg = avg;
        bestSubjectId = subject.name;
      }
      if (avg < worstAvg && subjectSessions.isNotEmpty) {
        worstAvg = avg;
        worstSubjectId = subject.name;
      }
    }

    // Recencia: sesiones de los últimos 7 días
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final recentSessions = completedSessions
        .where((s) => s.finishedAt != null && s.finishedAt!.isAfter(weekAgo))
        .length;

    final stats = {
      'gamification': {
        'level': gami.level,
        'xp': gami.xp,
        'streak_days': gami.streak,
        'achievements_unlocked': gami.achievements.length,
      },
      'srs_flashcards': {
        'total_cards': totalCards,
        'pending_reviews': pendingReviews,
        'mastered_cards': masteredCards,
        'srs_accuracy': srsGlobal['accuracy'] ?? 0,
      },
      'quiz': {
        'total_sessions': totalSessions,
        'sessions_last_7_days': recentSessions,
        'global_average_score_pct': (globalAvg * 10).round() / 10,
        'best_subject': bestSubjectId ?? 'Ninguna aún',
        'weakest_subject': worstSubjectId ?? 'Ninguna aún',
        'performance_by_subject': subjectPerformance,
      },
      'context': {
        'app': 'EstudiEO',
        'goal': 'Examen de admisión a la Policía Nacional de Colombia',
        'note':
            'El estudiante está preparando el examen de admisión. Dame un análisis breve y motivador.',
      },
    };

    return jsonEncode(stats);
  }

  /// Devuelve las stats ya parseadas para el dashboard visual (no para la IA)
  Map<String, dynamic> buildVisualStats() {
    final gami = gamification.gamification;
    final completedSessions = quiz.sessions
        .where((s) => s.isCompleted)
        .toList();
    final totalSessions = completedSessions.length;
    final globalAvg = totalSessions > 0
        ? completedSessions.map((s) => s.percentage).reduce((a, b) => a + b) /
              totalSessions
        : 0.0;

    final subjectList = subjects.subjects;
    final subjectPerformance = <Map<String, dynamic>>[];

    String? worstSubjectId;
    double worstAvg = 101.0;

    for (final subject in subjectList) {
      final topicIds = subject.topicIds;
      final subjectSessions = completedSessions
          .where((s) => topicIds.contains(s.topicId))
          .toList();
      if (subjectSessions.isEmpty) continue;
      final avg =
          subjectSessions.map((s) => s.percentage).reduce((a, b) => a + b) /
          subjectSessions.length;

      subjectPerformance.add({
        'subject': subject.name,
        'avg': avg,
        'color': subject.color,
      });

      if (avg < worstAvg && subjectSessions.isNotEmpty) {
        worstAvg = avg;
        worstSubjectId = subject.id;
      }
    }

    return {
      'level': gami.level,
      'xp': gami.xp,
      'streak': gami.streak,
      'totalSessions': totalSessions,
      'globalAvg': globalAvg,
      'pendingReviews': srs.getReviewQueue().length,
      'masteredCards': srs.cards.values
          .where((c) => c.repetitions >= 5 && c.easeFactor > 2.0)
          .length,
      'subjectPerformance': subjectPerformance,
      'worstSubjectId': worstSubjectId,
    };
  }
}

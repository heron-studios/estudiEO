import 'package:learn/models/learning_level.dart';

/// Sesión del Modo Aprendizaje Guiado.
///
/// Representa el estado completo de una sesión de aprendizaje para
/// un topic en un nivel de dificultad. La cola [questionQueue] se
/// recicla: preguntas falladas se reencolan al final.
class LearningSession {
  final String id;
  final String topicId;
  final Dificultad nivel;

  /// Cola dinámica de IDs de preguntas. El frente es la pregunta actual.
  /// Las preguntas falladas se agregan al final.
  final List<String> questionQueue;

  /// IDs de preguntas acertadas correctamente (el objetivo es llegar a 10).
  final List<String> completedIds;

  /// Número de aciertos netos (0–10). Meta = 10.
  int correctCount;

  final DateTime startedAt;
  DateTime? finishedAt;
  bool isLevelCompleted;

  static const int targetCorrect = 10;

  LearningSession({
    required this.id,
    required this.topicId,
    required this.nivel,
    required this.questionQueue,
    List<String>? completedIds,
    this.correctCount = 0,
    DateTime? startedAt,
    this.finishedAt,
    this.isLevelCompleted = false,
  })  : completedIds = completedIds ?? [],
        startedAt = startedAt ?? DateTime.now();

  /// ID de la pregunta actualmente en el frente de la cola.
  String? get currentQuestionId =>
      questionQueue.isNotEmpty ? questionQueue.first : null;

  /// Progreso visual para la barra (0.0 – 1.0).
  double get progress => correctCount / targetCorrect;

  bool get isFinished => correctCount >= targetCorrect;

  Duration get elapsed =>
      (finishedAt ?? DateTime.now()).difference(startedAt);

  Map<String, dynamic> toJson() => {
        'id': id,
        'topicId': topicId,
        'nivel': nivel.key,
        'questionQueue': questionQueue,
        'completedIds': completedIds,
        'correctCount': correctCount,
        'startedAt': startedAt.toIso8601String(),
        'finishedAt': finishedAt?.toIso8601String(),
        'isLevelCompleted': isLevelCompleted,
      };

  factory LearningSession.fromJson(Map<String, dynamic> json) =>
      LearningSession(
        id: json['id'] as String,
        topicId: json['topicId'] as String,
        nivel: Dificultad.fromString(json['nivel'] as String? ?? 'facil'),
        questionQueue: List<String>.from(json['questionQueue'] as List? ?? []),
        completedIds: List<String>.from(json['completedIds'] as List? ?? []),
        correctCount: json['correctCount'] as int? ?? 0,
        startedAt: DateTime.parse(json['startedAt'] as String),
        finishedAt: json['finishedAt'] != null
            ? DateTime.parse(json['finishedAt'] as String)
            : null,
        isLevelCompleted: json['isLevelCompleted'] as bool? ?? false,
      );
}

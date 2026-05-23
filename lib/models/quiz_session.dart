class QuizSession {
  final String id;
  final String topicId;
  final List<String> questionIds;
  final Map<String, int> answers; // questionId -> selectedAnswerIndex
  final Map<String, bool> correctness; // questionId -> isCorrect
  final DateTime startedAt;
  DateTime? finishedAt;
  bool isCompleted;

  QuizSession({
    required this.id,
    required this.topicId,
    required this.questionIds,
    Map<String, int>? answers,
    Map<String, bool>? correctness,
    DateTime? startedAt,
    this.finishedAt,
    this.isCompleted = false,
  })  : answers = answers ?? {},
        correctness = correctness ?? {},
        startedAt = startedAt ?? DateTime.now();

  int get correctCount => correctness.values.where((v) => v).length;
  int get answeredCount => answers.length;
  int get totalQuestions => questionIds.length;
  double get percentage =>
      answeredCount > 0 ? (correctCount / answeredCount) * 100 : 0;
  Duration get duration => (finishedAt ?? DateTime.now()).difference(startedAt);

  Map<String, dynamic> toJson() => {
    'id': id,
    'topicId': topicId,
    'questionIds': questionIds,
    'answers': answers,
    'correctness': correctness,
    'startedAt': startedAt.toIso8601String(),
    'finishedAt': finishedAt?.toIso8601String(),
    'isCompleted': isCompleted,
  };

  factory QuizSession.fromJson(Map<String, dynamic> json) => QuizSession(
    id: json['id'] as String,
    topicId: json['topicId'] as String,
    questionIds: List<String>.from(json['questionIds'] as List),
    answers: Map<String, int>.from(json['answers'] as Map? ?? {}),
    correctness: Map<String, bool>.from(json['correctness'] as Map? ?? {}),
    startedAt: DateTime.parse(json['startedAt'] as String),
    finishedAt: json['finishedAt'] != null
        ? DateTime.parse(json['finishedAt'] as String)
        : null,
    isCompleted: json['isCompleted'] as bool? ?? false,
  );
}

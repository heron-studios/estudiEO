class Question {
  final String id;
  final String topicId;
  final String text;
  final List<String> options;
  final int correctAnswer;
  final String explanation;

  Question({
    required this.id,
    required this.topicId,
    required this.text,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'topicId': topicId,
    'text': text,
    'options': options,
    'correctAnswer': correctAnswer,
    'explanation': explanation,
  };

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json['id'] as String,
    topicId: json['topicId'] as String,
    text: json['text'] as String,
    options: List<String>.from(json['options'] as List),
    correctAnswer: json['correctAnswer'] as int,
    explanation: json['explanation'] as String? ?? '',
  );
}

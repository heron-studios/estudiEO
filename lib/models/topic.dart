class Topic {
  final String id;
  final String subjectId;
  final String name;
  final String description;
  final int questionCount;

  Topic({
    required this.id,
    required this.subjectId,
    required this.name,
    required this.description,
    required this.questionCount,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'subjectId': subjectId,
    'name': name,
    'description': description,
    'questionCount': questionCount,
  };

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    id: json['id'] as String,
    subjectId: json['subjectId'] as String,
    name: json['name'] as String,
    description: json['description'] as String? ?? '',
    questionCount: json['questionCount'] as int? ?? 0,
  );
}

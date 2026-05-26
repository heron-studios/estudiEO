class Subject {
  final String id;
  final String name;
  final String color;
  final String icon;
  final List<String> topicIds;

  Subject({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.topicIds,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'color': color,
    'icon': icon,
    'topicIds': topicIds,
  };

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json['id'] as String,
    name: json['name'] as String,
    color: json['color'] as String? ?? '#FF6B6B',
    icon: json['icon'] as String? ?? 'ðŸ“š',
    topicIds: List<String>.from(json['topicIds'] as List? ?? []),
  );
}

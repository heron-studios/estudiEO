class TrailNode {
  final String label;
  final int sequenceIndex;
  final double xOffset;
  final double yOffset;

  TrailNode({
    required this.label,
    required this.sequenceIndex,
    required this.xOffset,
    required this.yOffset,
  });
}

class TrailLevel {
  final String id;
  final String title;
  final String description;
  final List<TrailNode> nodes;
  final int timeLimitSeconds;

  TrailLevel({
    required this.id,
    required this.title,
    required this.description,
    required this.nodes,
    required this.timeLimitSeconds,
  });
}

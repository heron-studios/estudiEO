enum SrsStatus { newCard, learning, mature, mastered }

class SrsCard {
  final String questionId;
  final String topicId;
  double easeFactor;
  int interval;
  int repetitions;
  DateTime? lastReviewed;
  DateTime? nextReviewDate;
  SrsStatus status;

  SrsCard({
    required this.questionId,
    required this.topicId,
    this.easeFactor = 2.5,
    this.interval = 0,
    this.repetitions = 0,
    this.lastReviewed,
    this.nextReviewDate,
    this.status = SrsStatus.newCard,
  });

  bool get isOverdue {
    if (nextReviewDate == null) return true;
    return nextReviewDate!.isBefore(DateTime.now());
  }

  Map<String, dynamic> toJson() => {
    'questionId': questionId,
    'topicId': topicId,
    'easeFactor': easeFactor,
    'interval': interval,
    'repetitions': repetitions,
    'lastReviewed': lastReviewed?.toIso8601String(),
    'nextReviewDate': nextReviewDate?.toIso8601String(),
    'status': status.toString(),
  };

  factory SrsCard.fromJson(Map<String, dynamic> json) => SrsCard(
    questionId: json['questionId'] as String,
    topicId: json['topicId'] as String,
    easeFactor: (json['easeFactor'] as num?)?.toDouble() ?? 2.5,
    interval: json['interval'] as int? ?? 0,
    repetitions: json['repetitions'] as int? ?? 0,
    lastReviewed: json['lastReviewed'] != null
        ? DateTime.parse(json['lastReviewed'] as String)
        : null,
    nextReviewDate: json['nextReviewDate'] != null
        ? DateTime.parse(json['nextReviewDate'] as String)
        : null,
    status: _parseStatus(json['status']),
  );

  static SrsStatus _parseStatus(dynamic status) {
    if (status is String) {
      if (status.contains('learning')) return SrsStatus.learning;
      if (status.contains('mature')) return SrsStatus.mature;
      if (status.contains('mastered')) return SrsStatus.mastered;
    }
    return SrsStatus.newCard;
  }
}

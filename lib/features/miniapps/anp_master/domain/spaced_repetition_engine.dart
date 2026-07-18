class SRSItem {
  final String id;
  int repetitions;
  double easinessFactor;
  int intervalDays;
  DateTime nextReviewDate;

  SRSItem({
    required this.id,
    this.repetitions = 0,
    this.easinessFactor = 2.5,
    this.intervalDays = 0,
    DateTime? nextReviewDate,
  }) : nextReviewDate = nextReviewDate ?? DateTime.now();

  /// Quality of response:
  /// 5: Perfect response
  /// 4: Correct response after a hesitation
  /// 3: Correct response recalled with serious difficulty
  /// 2: Incorrect response; where the correct one seemed easy to recall
  /// 1: Incorrect response; the correct one remembered
  /// 0: Complete blackout
  void recordReview(int quality) {
    if (quality >= 3) {
      if (repetitions == 0) {
        intervalDays = 1;
      } else if (repetitions == 1) {
        intervalDays = 6;
      } else {
        intervalDays = (intervalDays * easinessFactor).round();
      }
      repetitions++;
    } else {
      repetitions = 0;
      intervalDays = 1;
    }

    easinessFactor =
        easinessFactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    if (easinessFactor < 1.3) easinessFactor = 1.3;

    nextReviewDate = DateTime.now().add(Duration(days: intervalDays));
  }

  bool get isDue =>
      DateTime.now().isAfter(nextReviewDate) ||
      DateTime.now().isAtSameMomentAs(nextReviewDate);
}

class SpacedRepetitionEngine {
  final Map<String, SRSItem> _items = {};

  void initItems(List<String> ids) {
    for (var id in ids) {
      if (!_items.containsKey(id)) {
        _items[id] = SRSItem(id: id);
      }
    }
  }

  List<String> getDueItems(int limit) {
    final due = _items.values.where((item) => item.isDue).toList();
    // Sort by most overdue
    due.sort((a, b) => a.nextReviewDate.compareTo(b.nextReviewDate));
    return due.take(limit).map((e) => e.id).toList();
  }

  void processAnswer(String id, int quality) {
    if (_items.containsKey(id)) {
      _items[id]!.recordReview(quality);
    }
  }

  SRSItem? getItem(String id) {
    return _items[id];
  }
}

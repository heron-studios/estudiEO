class Gamification {
  int xp;
  int level;
  List<String> achievements;
  int streak;
  DateTime? lastActivityDate;

  Gamification({
    this.xp = 0,
    this.level = 1,
    this.achievements = const [],
    this.streak = 0,
    this.lastActivityDate,
  });

  Map<String, dynamic> toJson() => {
    'xp': xp,
    'level': level,
    'achievements': achievements,
    'streak': streak,
    'lastActivityDate': lastActivityDate?.toIso8601String(),
  };

  factory Gamification.fromJson(Map<String, dynamic> json) => Gamification(
    xp: json['xp'] as int? ?? 0,
    level: json['level'] as int? ?? 1,
    achievements: List<String>.from(json['achievements'] as List? ?? []),
    streak: json['streak'] as int? ?? 0,
    lastActivityDate: json['lastActivityDate'] != null
        ? DateTime.parse(json['lastActivityDate'] as String)
        : null,
  );

  int getXpForLevel(int targetLevel) {
    return targetLevel * 100;
  }

  bool canLevelUp() {
    final xpNeeded = getXpForLevel(level + 1);
    return xp >= xpNeeded;
  }

  void addXp(int amount) {
    xp += amount;
    while (canLevelUp()) {
      xp -= getXpForLevel(level + 1);
      level++;
    }
  }

  void updateStreak() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (lastActivityDate != null) {
      final lastDate = DateTime(
          lastActivityDate!.year, lastActivityDate!.month, lastActivityDate!.day);
      final daysDiff = today.difference(lastDate).inDays;
      if (daysDiff == 0) {
        return;
      } else if (daysDiff == 1) {
        streak++;
      } else {
        streak = 1;
      }
    } else {
      streak = 1;
    }
    lastActivityDate = now;
  }

  void addAchievement(String achievement) {
    if (!achievements.contains(achievement)) {
      achievements.add(achievement);
    }
  }
}

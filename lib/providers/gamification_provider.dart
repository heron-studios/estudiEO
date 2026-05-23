import 'package:flutter/material.dart';
import 'package:learn/models/gamification.dart';
import 'package:learn/services/local_storage_service.dart';

class GamificationProvider extends ChangeNotifier {
  final LocalStorageService _storage;
  late Gamification _gamification;

  GamificationProvider(this._storage) {
    _gamification = _storage.loadGamification();
  }

  Gamification get gamification => _gamification;
  int get xp => _gamification.xp;
  int get level => _gamification.level;
  int get streak => _gamification.streak;
  List<String> get achievements => _gamification.achievements;

  void addXp(int amount) {
    _gamification.addXp(amount);
    _gamification.updateStreak();
    _storage.saveGamification(_gamification);
    notifyListeners();
  }

  void addAchievement(String achievement) {
    _gamification.addAchievement(achievement);
    _storage.saveGamification(_gamification);
    notifyListeners();
  }

  void updateStreak() {
    _gamification.updateStreak();
    _storage.saveGamification(_gamification);
    notifyListeners();
  }

  int getXpForNextLevel() {
    return _gamification.getXpForLevel(level + 1) - xp;
  }

  int getTotalXpForLevel(int level) {
    return _gamification.getXpForLevel(level);
  }

  void reset() {
    _gamification = Gamification();
    _storage.saveGamification(_gamification);
    notifyListeners();
  }

  void reload() {
    _gamification = _storage.loadGamification();
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:learn/models/srs_card.dart';
import 'package:learn/services/local_storage_service.dart';
import 'package:learn/services/srs_engine.dart';

class SrsProvider extends ChangeNotifier {
  final LocalStorageService _storage;
  late SrsEngine _engine;
  Map<String, SrsCard> _cards = {};
  Map<String, dynamic> _globalStats = {};

  SrsProvider(this._storage) {
    _engine = SrsEngine(_storage);
    _loadData();
  }

  void _loadData() {
    _cards = _storage.loadSrsCards();
    _globalStats = _engine.getGlobalStats();
  }

  Map<String, SrsCard> get cards => _cards;
  Map<String, dynamic> get globalStats => _globalStats;
  SrsEngine get engine => _engine;

  SrsCard processAnswer(String questionId, String topicId, bool isCorrect) {
    final card = _engine.processAnswer(questionId, topicId, isCorrect);
    _cards[questionId] = card;
    _globalStats = _engine.getGlobalStats();
    notifyListeners();
    return card;
  }

  List<SrsCard> getReviewQueue() => _engine.getReviewQueue();

  List<SrsCard> getCardsByTopic(String topicId) =>
      _engine.getCardsByTopic(topicId);

  Map<String, dynamic> getTopicStats(String topicId) =>
      _engine.getTopicStats(topicId);

  void resetTopic(String topicId) {
    _engine.resetTopic(topicId);
    _cards = _storage.loadSrsCards();
    _globalStats = _engine.getGlobalStats();
    notifyListeners();
  }

  void resetAll() {
    _engine.resetAll();
    _cards = {};
    _globalStats = {};
    notifyListeners();
  }
}

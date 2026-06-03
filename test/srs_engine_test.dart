import 'package:flutter_test/flutter_test.dart';
import 'package:learn/features/srs/domain/srs_engine.dart';
import 'package:learn/models/srs_card.dart';
import 'package:learn/core/services/local_storage_service.dart';

class FakeLocalStorageService implements LocalStorageService {
  Map<String, SrsCard> cards = {};
  
  @override
  SrsCard? getSrsCard(String questionId) => cards[questionId];

  @override
  void saveSrsCard(SrsCard card) {
    cards[card.questionId] = card;
  }

  @override
  Map<String, SrsCard> loadSrsCards() => cards;

  @override
  void saveSrsCards(Map<String, SrsCard> c) {
    cards = c;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late SrsEngine engine;
  late FakeLocalStorageService fakeStorage;

  setUp(() {
    fakeStorage = FakeLocalStorageService();
    engine = SrsEngine(fakeStorage);
  });

  group('SrsEngine', () {
    test('processAnswer for new card (Correct)', () {
      final card = engine.processAnswer('q1', 't1', true);
      
      expect(card.questionId, 'q1');
      expect(card.repetitions, 1);
      expect(card.interval, 1);
      expect(card.status, SrsStatus.learning);
    });

    test('processAnswer for new card (Incorrect)', () {
      final card = engine.processAnswer('q2', 't1', false);
      
      expect(card.questionId, 'q2');
      expect(card.repetitions, 0);
      expect(card.interval, 0);
      expect(card.easeFactor, 2.5);
      expect(card.status, SrsStatus.newCard);
    });

    test('processAnswer sequence (Correct, Correct, Incorrect)', () {
      // First review (Correct)
      var card = engine.processAnswer('q3', 't1', true);
      expect(card.interval, 1);

      // Second review (Correct)
      card = engine.processAnswer('q3', 't1', true);
      expect(card.interval, 3);
      expect(card.repetitions, 2);

      // Third review (Incorrect)
      card = engine.processAnswer('q3', 't1', false);
      expect(card.interval, 0);
      expect(card.repetitions, 0);
      expect(card.easeFactor, 2.5);
      expect(card.status, SrsStatus.newCard);
    });

    test('getReviewQueue should order correctly and filter ignored topics', () {
      // Setup some cards
      final now = DateTime.now();

      final overdueCard = SrsCard(questionId: 'c1', topicId: 't1')
        ..lastReviewed = now.subtract(const Duration(days: 5))
        ..interval = 1
        ..nextReviewDate = now.subtract(const Duration(days: 4)); // Overdue by 4 days
      
      final futureCard = SrsCard(questionId: 'c2', topicId: 't1')
        ..lastReviewed = now
        ..interval = 5
        ..nextReviewDate = now.add(const Duration(days: 5)); // Not overdue
      
      final excludedCard = SrsCard(questionId: 'c3', topicId: 'mat_1')
        ..lastReviewed = now.subtract(const Duration(days: 5))
        ..interval = 1
        ..nextReviewDate = now.subtract(const Duration(days: 4)); // Overdue but excluded topic
      
      fakeStorage.cards = {
        'c1': overdueCard,
        'c2': futureCard,
        'c3': excludedCard,
      };

      final queue = engine.getReviewQueue();
      
      expect(queue.length, 1);
      expect(queue.first.questionId, 'c1'); // only c1 is overdue and not excluded
    });
  });
}

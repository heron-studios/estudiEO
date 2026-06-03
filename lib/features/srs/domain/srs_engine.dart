import 'package:learn/models/srs_card.dart';
import 'package:learn/core/services/local_storage_service.dart';

/// Motor de Repetición Espaciada Adaptativo basado en SM-2
/// Algoritmo optimizado para EstudiEO
class SrsEngine {
  final LocalStorageService _storage;

  SrsEngine(this._storage);

  /// Procesa una respuesta y actualiza la tarjeta SRS
  /// Retorna la tarjeta actualizada
  SrsCard processAnswer(String questionId, String topicId, bool isCorrect) {
    SrsCard card =
        _storage.getSrsCard(questionId) ??
        SrsCard(questionId: questionId, topicId: topicId);

    card.lastReviewed = DateTime.now();

    if (isCorrect) {
      card.repetitions += 1;

      // Calcular nuevo intervalo
      if (card.repetitions == 1) {
        card.interval = 1; // 1 día
      } else if (card.repetitions == 2) {
        card.interval = 3; // 3 días
      } else {
        card.interval = (card.interval * card.easeFactor).round();
      }

      // Actualizar ease factor (nunca bajar de 1.3)
      card.easeFactor =
          card.easeFactor + (0.1 - (5 - 5) * (0.08 + (5 - 5) * 0.02));
      card.easeFactor = card.easeFactor.clamp(1.3, double.infinity);
    } else {
      // Respuesta incorrecta: resetear
      card.repetitions = 0;
      card.interval = 0;
      card.easeFactor = 2.5;
    }

    // Calcular próxima fecha de revisión
    card.nextReviewDate = DateTime.now().add(Duration(days: card.interval));

    // Actualizar estado
    card.status = _computeStatus(card.repetitions, card.interval);

    // Guardar
    _storage.saveSrsCard(card);

    return card;
  }

  /// Calcula el estado de la tarjeta basado en repeticiones e intervalo
  SrsStatus _computeStatus(int repetitions, int interval) {
    if (repetitions == 0 && interval == 0) return SrsStatus.newCard;
    if (interval < 3 || repetitions < 3) return SrsStatus.learning;
    if (interval >= 21 && repetitions >= 5) return SrsStatus.mastered;
    return SrsStatus.mature;
  }

  /// Obtiene todas las tarjetas que necesitan revisión
  List<SrsCard> getReviewQueue() {
    final cards = _storage.loadSrsCards();
    final queue = cards.values.where((card) {
      if (!card.isOverdue) return false;
      
      // Excluir materias/temas específicos de las tarjetas de memoria
      final isMatematicas = card.topicId.startsWith('mat_'); 
      final isRM = card.topicId.startsWith('rm_');
      final isExcludedRV = card.topicId == 'rv_plan'; // Solo excluir Plan de Redacción
      final isReglasOrtograficas = card.topicId == 'com_t1'; // Excluir Reglas Ortográficas
      
      if (isMatematicas || isRM || isExcludedRV || isReglasOrtograficas) {
        return false;
      }
      
      return true;
    }).toList();

    // Ordenar por urgencia: primero las vencidas, luego por fecha
    queue.sort((a, b) {
      final aDays = _daysSinceReview(a);
      final bDays = _daysSinceReview(b);
      return bDays.compareTo(aDays);
    });

    return queue;
  }

  /// Obtiene tarjetas de un tópico específico
  List<SrsCard> getCardsByTopic(String topicId) {
    final cards = _storage.loadSrsCards();
    return cards.values.where((card) => card.topicId == topicId).toList();
  }

  /// Obtiene estadísticas de un tópico
  Map<String, dynamic> getTopicStats(String topicId) {
    final cards = getCardsByTopic(topicId);

    return {
      'total': cards.length,
      'new': cards.where((c) => c.status == SrsStatus.newCard).length,
      'learning': cards.where((c) => c.status == SrsStatus.learning).length,
      'mature': cards.where((c) => c.status == SrsStatus.mature).length,
      'mastered': cards.where((c) => c.status == SrsStatus.mastered).length,
      'overdue': cards.where((c) => c.isOverdue).length,
    };
  }

  /// Obtiene estadísticas globales
  Map<String, dynamic> getGlobalStats() {
    final cards = _storage.loadSrsCards();

    return {
      'total': cards.length,
      'new': cards.values.where((c) => c.status == SrsStatus.newCard).length,
      'learning': cards.values
          .where((c) => c.status == SrsStatus.learning)
          .length,
      'mature': cards.values.where((c) => c.status == SrsStatus.mature).length,
      'mastered': cards.values
          .where((c) => c.status == SrsStatus.mastered)
          .length,
      'overdue': cards.values.where((c) => c.isOverdue).length,
    };
  }

  /// Calcula días desde la última revisión
  int _daysSinceReview(SrsCard card) {
    if (card.lastReviewed == null) return 999;
    return DateTime.now().difference(card.lastReviewed!).inDays;
  }

  /// Resetea todas las tarjetas de un tópico
  void resetTopic(String topicId) {
    final cards = _storage.loadSrsCards();
    cards.removeWhere((_, card) => card.topicId == topicId);
    _storage.saveSrsCards(cards);
  }

  /// Resetea todas las tarjetas
  void resetAll() {
    _storage.saveSrsCards({});
  }
}

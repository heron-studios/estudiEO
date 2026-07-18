import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  static const String _collection = 'app_stats';
  static const String _document = 'leaderboard';

  /// Incrementa el contador global de postulantes para la escuela dada.
  Future<void> registerApplicant(String school) async {
    try {
      final docRef = _firestore.collection(_collection).doc(_document);
      
      final schoolKey = school == 'EO PNP' ? 'eo_pnp' : 'eetspn';

      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);

        if (!snapshot.exists) {
          transaction.set(docRef, {
            'eo_pnp': schoolKey == 'eo_pnp' ? 1 : 0,
            'eetspn': schoolKey == 'eetspn' ? 1 : 0,
          });
        } else {
          final currentCount = (snapshot.data()?[schoolKey] as int?) ?? 0;
          transaction.update(docRef, {
            schoolKey: currentCount + 1,
          });
        }
      });
    } catch (e) {
      debugPrint('Error registering applicant in leaderboard: $e');
    }
  }

  /// Escucha en tiempo real la cantidad de postulantes de cada escuela.
  Stream<Map<String, int>> getLeaderboardStream() {
    return _firestore.collection(_collection).doc(_document).snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        return {'eo_pnp': 0, 'eetspn': 0};
      }
      final data = snapshot.data()!;
      return {
        'eo_pnp': (data['eo_pnp'] as int?) ?? 0,
        'eetspn': (data['eetspn'] as int?) ?? 0,
      };
    });
  }
}

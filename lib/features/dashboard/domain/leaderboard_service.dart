import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // No longer using app_stats/leaderboard global document

  /// Sincroniza el puntaje (XP) de un usuario en la colección de su escuela.
  Future<void> syncUserScore({
    required String uid,
    required String name,
    required String school,
    required int xp,
  }) async {
    try {
      if (uid.isEmpty || name.isEmpty || school.isEmpty) return;

      final collectionName = school == 'EO PNP' ? 'leaderboard_eo_pnp' : 'leaderboard_eetspn';
      
      await _firestore.collection(collectionName).doc(uid).set({
        'name': name,
        'xp': xp,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Error syncing user score: $e');
    }
  }

  /// Obtiene los mejores estudiantes de una escuela ordenados por XP.
  Stream<List<Map<String, dynamic>>> getTopRankings(String school, {int limit = 20}) {
    final collectionName = school == 'EO PNP' ? 'leaderboard_eo_pnp' : 'leaderboard_eetspn';
    
    return _firestore
        .collection(collectionName)
        .orderBy('xp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'uid': doc.id,
          'name': data['name'] ?? 'Aspirante',
          'xp': (data['xp'] as num?)?.toInt() ?? 0,
        };
      }).toList();
    });
  }
}

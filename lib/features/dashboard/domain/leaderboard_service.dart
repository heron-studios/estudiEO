import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:math' as dart_math;

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

      final collectionName = school == 'EO PNP'
          ? 'leaderboard_eo_pnp'
          : 'leaderboard_eetspn';

      await _firestore.collection(collectionName).doc(uid).set({
        'name': name,
        'xp': xp,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Error syncing user score: $e');
    }
  }

  List<Map<String, dynamic>> _getFictitiousUsers(String school) {
    // Usar la hora actual como semilla para que los bots no cambien caóticamente en cada parpadeo, pero roten durante el día.
    final now = DateTime.now();
    final hourSeed = now.year * 10000 + now.month * 100 + now.day * 24 + now.hour;
    final r = dart_math.Random(hourSeed + school.hashCode);
    
    final names = [
      'Luis Silva', 'Carlos Mendoza', 'Jorge Torres', 
      'Ana Rojas', 'Diego Quispe', 'Pedro Vargas', 
      'Juan Castillo', 'Miguel Morales', 'Maria Flores',
      'José Gutierrez', 'Roberto Rios', 'Luis Vega'
    ];
    
    final bots = <Map<String, dynamic>>[];
    for (int i = 0; i < 12; i++) {
      bots.add({
        'uid': 'bot_${school}_$i',
        'name': names[i % names.length],
        'xp': r.nextInt(4500) + 200, // XP aleatorio pero estable por hora
      });
    }
    return bots;
  }

  /// Obtiene los mejores estudiantes de una escuela ordenados por XP.
  Stream<List<Map<String, dynamic>>> getTopRankings(
    String school, {
    int limit = 20,
  }) {
    final collectionName = school == 'EO PNP'
        ? 'leaderboard_eo_pnp'
        : 'leaderboard_eetspn';

    return _firestore
        .collection(collectionName)
        .orderBy('xp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
          final realUsers = snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              'uid': doc.id,
              'name': data['name'] ?? 'Aspirante',
              'xp': (data['xp'] as num?)?.toInt() ?? 0,
            };
          }).toList();

          final allUsers = [...realUsers, ..._getFictitiousUsers(school)];
          allUsers.sort((a, b) => (b['xp'] as int).compareTo(a['xp'] as int));

          return allUsers.take(limit).toList();
        });
  }
}

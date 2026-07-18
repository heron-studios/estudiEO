import 'package:cloud_firestore/cloud_firestore.dart';

class ArenaMatch {
  final String id;
  final String player1Id;
  final String? player2Id;
  final String player1Name;
  final String? player2Name;
  final int player1Score;
  final int player2Score;
  final String status; // 'waiting', 'playing', 'finished'
  final DateTime createdAt;
  final List<dynamic>
  questions; // Lista de mapas: { text, options, correctAnswer }

  ArenaMatch({
    required this.id,
    required this.player1Id,
    this.player2Id,
    required this.player1Name,
    this.player2Name,
    this.player1Score = 0,
    this.player2Score = 0,
    required this.status,
    required this.createdAt,
    required this.questions,
  });

  factory ArenaMatch.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null)
      return ArenaMatch(
        id: doc.id,
        player1Id: '',
        player1Name: '',
        status: 'waiting',
        createdAt: DateTime.now(),
        questions: [],
      );

    return ArenaMatch(
      id: doc.id,
      player1Id: data['player1Id'] ?? '',
      player2Id: data['player2Id'],
      player1Name: data['player1Name'] ?? 'Aspirante 1',
      player2Name: data['player2Name'],
      player1Score: data['player1Score'] ?? 0,
      player2Score: data['player2Score'] ?? 0,
      status: data['status'] ?? 'waiting',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      questions: data['questions'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'player1Id': player1Id,
      'player2Id': player2Id,
      'player1Name': player1Name,
      'player2Name': player2Name,
      'player1Score': player1Score,
      'player2Score': player2Score,
      'status': status,
      'createdAt': FieldValue.serverTimestamp(),
      'questions': questions,
    };
  }
}

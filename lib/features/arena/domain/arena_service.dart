import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn/models/arena_match.dart';
import 'package:learn/data/repository/subjects_repository.dart';
import 'package:learn/models/question.dart';

class ArenaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Busca una sala en espera o crea una nueva
  Future<ArenaMatch> findOrJoinMatch(String playerId, String playerName) async {
    final QuerySnapshot waitingMatches = await _firestore
        .collection('arena_matches')
        .where('status', isEqualTo: 'waiting')
        .limit(1)
        .get();

    if (waitingMatches.docs.isNotEmpty) {
      // Unirse a una sala existente
      final doc = waitingMatches.docs.first;
      final match = ArenaMatch.fromFirestore(doc);

      // Evitar jugar contra uno mismo (por si el usuario presionó dos veces o testea en dos pestañas)
      if (match.player1Id != playerId) {
        await doc.reference.update({
          'player2Id': playerId,
          'player2Name': playerName,
          'status': 'playing',
        });
        return ArenaMatch.fromFirestore(await doc.reference.get());
      }
    }

    // Crear una nueva sala en espera
    final questions = _generateRandomQuestions(5);
    final docRef = _firestore.collection('arena_matches').doc();
    
    final newMatch = ArenaMatch(
      id: docRef.id,
      player1Id: playerId,
      player1Name: playerName,
      status: 'waiting', 
      createdAt: DateTime.now(),
      questions: questions,
    );
    await docRef.set(newMatch.toMap());
    return newMatch;
  }

  Future<void> assignBot(String matchId) async {
    final botNames = [
      'Luis Silva', 'Carlos Mendoza', 'Jorge Torres', 
      'Ana Rojas', 'Diego Quispe', 'Pedro Vargas', 
      'Juan Castillo', 'Miguel Morales', 'Maria Flores',
      'José Gutierrez', 'Roberto Rios', 'Luis Vega'
    ];
    botNames.shuffle();
    final botName = botNames.first;
    
    await _firestore.collection('arena_matches').doc(matchId).update({
      'player2Id': 'BOT_${DateTime.now().millisecondsSinceEpoch}',
      'player2Name': botName,
      'status': 'playing',
    });
  }

  List<Map<String, dynamic>> _generateRandomQuestions(int count) {
    final allSubjects = SubjectsRepository.getAllSubjects();
    final allQuestions = <Question>[];
    for (final s in allSubjects) {
      allQuestions.addAll(SubjectsRepository.getQuestionsBySubject(s.id));
    }
    allQuestions.shuffle();
    return allQuestions
        .take(count)
        .map(
          (q) => {
            'id': q.id,
            'text': q.text,
            'options': q.options,
            'correctAnswer': q.correctAnswer,
          },
        )
        .toList();
  }

  // Stream para escuchar cambios en la partida
  Stream<ArenaMatch> watchMatch(String matchId) {
    return _firestore
        .collection('arena_matches')
        .doc(matchId)
        .snapshots()
        .map((doc) => ArenaMatch.fromFirestore(doc));
  }

  // Actualizar puntaje
  Future<void> updateScore(
    String matchId,
    String playerKey,
    int newScore,
  ) async {
    await _firestore.collection('arena_matches').doc(matchId).update({
      playerKey: newScore,
    });
  }

  // Finalizar partida
  Future<void> finishMatch(String matchId) async {
    await _firestore.collection('arena_matches').doc(matchId).update({
      'status': 'finished',
    });
  }
}

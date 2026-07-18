import 'package:flutter/material.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/models/arena_match.dart';
import 'package:learn/features/arena/domain/arena_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/providers/gamification_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class ArenaScreen extends StatefulWidget {
  const ArenaScreen({super.key});

  @override
  State<ArenaScreen> createState() => _ArenaScreenState();
}

class _ArenaScreenState extends State<ArenaScreen> {
  final ArenaService _arenaService = ArenaService();
  final String _playerId =
      FirebaseAuth.instance.currentUser?.uid ??
      DateTime.now().millisecondsSinceEpoch.toString();
  final String _playerName =
      FirebaseAuth.instance.currentUser?.displayName ?? 'Aspirante';

  ArenaMatch? _match;
  StreamSubscription? _matchSub;
  bool _isSearching = false;
  int _currentQuestionIndex = 0;
  bool _answeredCurrent = false;

  @override
  void dispose() {
    _matchSub?.cancel();
    super.dispose();
  }

  Future<void> _startMatchmaking() async {
    setState(() {
      _isSearching = true;
    });
    try {
      final match = await _arenaService.findOrJoinMatch(_playerId, _playerName);
      _matchSub = _arenaService.watchMatch(match.id).listen((updatedMatch) {
        if (!mounted) return;
        setState(() {
          _match = updatedMatch;
        });

        if (updatedMatch.status == 'finished') {
          _handleMatchFinished();
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
        setState(() {
          _isSearching = false;
        });
      }
    }
  }

  void _handleMatchFinished() {
    final isPlayer1 = _match?.player1Id == _playerId;
    final myScore = isPlayer1
        ? (_match?.player1Score ?? 0)
        : (_match?.player2Score ?? 0);
    final oppScore = isPlayer1
        ? (_match?.player2Score ?? 0)
        : (_match?.player1Score ?? 0);

    if (myScore > oppScore) {
      context.read<GamificationProvider>().addXp(50);
    }
  }

  void _answer(int selectedIndex) {
    if (_answeredCurrent || _match == null) return;
    setState(() {
      _answeredCurrent = true;
    });

    final q = _match!.questions[_currentQuestionIndex];
    if (selectedIndex == q['correctAnswer']) {
      final isPlayer1 = _match!.player1Id == _playerId;
      final currentScore = isPlayer1
          ? _match!.player1Score
          : _match!.player2Score;
      _arenaService.updateScore(
        _match!.id,
        isPlayer1 ? 'player1Score' : 'player2Score',
        currentScore + 10,
      );
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      if (_currentQuestionIndex < _match!.questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _answeredCurrent = false;
        });
      } else {
        _arenaService.finishMatch(_match!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final nt = Theme.of(context).extension<NeuralThemeData>()!;

    return Scaffold(
      backgroundColor: nt.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Arena Policial',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(child: _match == null ? _buildLobby() : _buildGameArea()),
    );
  }

  Widget _buildLobby() {
    final nt = Theme.of(context).extension<NeuralThemeData>()!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sports_esports_rounded, size: 80, color: nt.purple),
          const SizedBox(height: 20),
          const Text(
            'Combate 1v1',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Demuestra tus conocimientos contra otro aspirante.',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 40),
          if (_isSearching)
            Column(
              children: [
                CircularProgressIndicator(color: nt.cyan),
                const SizedBox(height: 16),
                const Text(
                  'Buscando oponente...',
                  style: TextStyle(color: Colors.white54),
                ),
              ],
            )
          else
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: nt.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _startMatchmaking,
              child: const Text(
                'BUSCAR OPONENTE',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGameArea() {
    final nt = Theme.of(context).extension<NeuralThemeData>()!;
    if (_match!.status == 'waiting') {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: nt.cyan),
            const SizedBox(height: 20),
            Text(
              'Esperando que alguien se una a ${_match!.player1Name}...',
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      );
    }

    final isPlayer1 = _match!.player1Id == _playerId;
    final myName = isPlayer1
        ? _match!.player1Name
        : (_match!.player2Name ?? 'Rival');
    final oppName = isPlayer1
        ? (_match!.player2Name ?? 'Rival')
        : _match!.player1Name;
    final myScore = isPlayer1 ? _match!.player1Score : _match!.player2Score;
    final oppScore = isPlayer1 ? _match!.player2Score : _match!.player1Score;

    if (_match!.status == 'finished') {
      return _buildResults(myName, myScore, oppName, oppScore);
    }

    final q = _match!.questions[_currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Marcador
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPlayerScore(myName, myScore, nt.cyan),
              const Text(
                'VS',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              _buildPlayerScore(oppName, oppScore, Colors.pinkAccent),
            ],
          ),
          const SizedBox(height: 40),
          // Pregunta
          Text(
            'Pregunta ${_currentQuestionIndex + 1} de ${_match!.questions.length}',
            style: const TextStyle(color: Colors.white54, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Text(
            q['text'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          // Opciones
          ...List.generate((q['options'] as List).length, (index) {
            final option = q['options'][index];
            Color btnColor = nt.surfaceCard;
            if (_answeredCurrent) {
              if (index == q['correctAnswer']) {
                btnColor = Colors.green.withValues(alpha: 0.3);
              } else {
                btnColor = Colors.red.withValues(alpha: 0.3);
              }
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => _answer(index),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: btnColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Text(
                    option,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPlayerScore(String name, int score, Color color) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$score',
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildResults(
    String myName,
    int myScore,
    String oppName,
    int oppScore,
  ) {
    final nt = Theme.of(context).extension<NeuralThemeData>()!;
    final won = myScore > oppScore;
    final tie = myScore == oppScore;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            won
                ? Icons.emoji_events
                : (tie ? Icons.handshake : Icons.sentiment_dissatisfied),
            size: 80,
            color: won ? Colors.amber : Colors.white54,
          ),
          const SizedBox(height: 20),
          Text(
            won ? '¡VICTORIA!' : (tie ? 'EMPATE' : 'DERROTA'),
            style: TextStyle(
              color: won ? Colors.amber : Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            '$myName: $myScore',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            '$oppName: $oppScore',
            style: const TextStyle(color: Colors.white54, fontSize: 18),
          ),
          const SizedBox(height: 40),
          if (won)
            const Text(
              '+50 XP',
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: nt.purple,
              foregroundColor: Colors.white,
            ),
            onPressed: () => context.pop(),
            child: const Text('VOLVER AL MENÚ'),
          ),
        ],
      ),
    );
  }
}

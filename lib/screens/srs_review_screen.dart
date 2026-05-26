import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/subject_provider.dart';

class SrsReviewScreen extends StatefulWidget {
  const SrsReviewScreen({super.key});

  @override
  State<SrsReviewScreen> createState() => _SrsReviewScreenState();
}

class _SrsReviewScreenState extends State<SrsReviewScreen> {
  late List<String> _reviewQueue = [];
  int _currentIndex = 0;

  static const _bg = Color(0xFF0F172A);
  static const _cardBg = Color(0xFF1E293B);
  static const _border = Color(0xFF334155);
  static const _text = Color(0xFFF1F5F9);
  static const _muted = Color(0xFF94A3B8);
  static const _green = Color(0xFF4ADE80);
  static const _blue = Color(0xFF3B82F6);

  bool _showAnswer = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_reviewQueue.isEmpty) {
      _initializeQueue();
    }
  }

  void _initializeQueue() {
    final srs = context.read<SrsProvider>();
    final queue = srs.getReviewQueue();
    // Copy the queue so it doesn't shift under us while answering
    setState(() {
      _reviewQueue = queue.map((card) => card.questionId).toList();
    });
  }

  // Mini-Quiz tracking
  int _cardsReviewedInBatch = 0;
  final List<String> _batchQuestionIds = [];

  void _nextCard() async {
    if (!mounted) return;

    final questionId = _reviewQueue[_currentIndex];
    _batchQuestionIds.add(questionId);
    _cardsReviewedInBatch++;

    if (_cardsReviewedInBatch >= 20) {
      _showMiniQuizPrompt();
    } else if (_currentIndex < _reviewQueue.length - 1) {
      setState(() {
        _currentIndex++;
        _showAnswer = false;
      });
    } else {
      // If we finished the queue but haven't reached 20
      if (_cardsReviewedInBatch > 0) {
        _showMiniQuizPrompt();
      } else {
        _showCompletion();
      }
    }
  }

  void _showMiniQuizPrompt() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: _cardBg,
          title: const Text('¡Has revisado 20 tarjetas!', style: TextStyle(color: _text)),
          content: const Text('Probemos si te las aprendiste. ¿Listo para un quiz rápido?', style: TextStyle(color: _muted)),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                final batch = List<String>.from(_batchQuestionIds);
                _cardsReviewedInBatch = 0;
                _batchQuestionIds.clear();
                
                Navigator.pushNamed(
                  context, 
                  '/srs-mini-quiz',
                  arguments: batch,
                ).then((didPass) {
                  if (!mounted) return;
                  // After returning from mini quiz, didPass indicates if they passed
                  final passed = (didPass == true);
                  if (passed) {
                    if (_currentIndex < _reviewQueue.length - 1) {
                      setState(() {
                        _currentIndex++;
                        _showAnswer = false;
                      });
                    } else {
                      _showCompletion();
                    }
                  } else {
                    final batchSize = batch.length;
                    setState(() {
                      _currentIndex = _currentIndex - batchSize + 1;
                      _showAnswer = false;
                    });
                    
                    // Show explanation dialog
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          backgroundColor: _cardBg,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title: const Row(
                            children: [
                              Icon(Icons.warning_amber_rounded, color: Colors.amber),
                              SizedBox(width: 8),
                              Text('Repetir Repaso', style: TextStyle(color: _text)),
                            ],
                          ),
                          content: Text(
                            'Debido a que el Modo Estricto está activo y no obtuviste una nota mayor a 11, debes repasar nuevamente este grupo de $batchSize tarjetas.',
                            style: const TextStyle(color: _muted),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Entendido', style: TextStyle(color: _blue)),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: _green, foregroundColor: _bg),
              child: const Text('Realizar quiz rápido', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      }
    );
  }

  void _showCompletion() {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context); // Go back to Home
    messenger.showSnackBar(
      SnackBar(
        content: const Text('¡Revisión completada! Has repasado tus tarjetas.',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: _green.withValues(alpha: 0.9),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_reviewQueue.isEmpty) {
      return Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🎉', style: TextStyle(fontSize: 60)),
              SizedBox(height: 16),
              Text(
                '¡Al día!',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: _text),
              ),
              SizedBox(height: 8),
              Text('No tienes tarjetas pendientes de repaso.',
                  style: TextStyle(color: _muted)),
            ],
          ),
        ),
      );
    }

    final questionId = _reviewQueue[_currentIndex];
    final question = context.read<SubjectProvider>().getQuestion(questionId);

    if (question == null) {
      return Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const Center(
          child: Text('Error cargando la pregunta.',
              style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          children: [
            const Text(
              'REPASO ESPACIADO',
              style: TextStyle(
                  color: _green, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.5),
            ),
            Text(
              '${_currentIndex + 1} de ${_reviewQueue.length}',
              style: const TextStyle(
                  color: _text, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (_currentIndex + 1) / _reviewQueue.length,
                  backgroundColor: _cardBg,
                  valueColor: const AlwaysStoppedAnimation<Color>(_green),
                  minHeight: 4,
                ),
              ),
              const SizedBox(height: 24),

              // Question Text
              Expanded(
                flex: 4,
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      question.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: _text,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Answer Area
              Expanded(
                flex: 5,
                child: _showAnswer
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: _green.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: _green, width: 2),
                              ),
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Text(
                                    question.options[question.correctAnswer],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: _green,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _nextCard,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _blue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            child: const Text('Siguiente', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          )
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            _showAnswer = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _cardBg,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: _border, width: 1.5),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.touch_app, color: _muted, size: 48),
                                SizedBox(height: 16),
                                Text('Toca para ver la respuesta', style: TextStyle(color: _muted, fontSize: 18)),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    ),
    ),
  );
}
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:learn/models/question.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:confetti/confetti.dart';

class SrsMiniQuizScreen extends StatefulWidget {
  final List<String> questionIds;

  const SrsMiniQuizScreen({super.key, required this.questionIds});

  @override
  State<SrsMiniQuizScreen> createState() => _SrsMiniQuizScreenState();
}

class _SrsMiniQuizScreenState extends State<SrsMiniQuizScreen> {
  int _currentQuestionIndex = 0;
  List<Question> _questions = [];
  final Map<String, bool> _answers = {};
  int _selectedAnswer = -1;
  bool _isFinished = false;

  // By default, do NOT repeat the correctly answered ones in future iterations
  bool _repeatCorrect = false;
  bool _isStrictMode = true;

  late ConfettiController _confettiController;
  bool _confettiPlayed = false;

  static const _bg = Color(0xFF0F172A);
  static const _cardBg = Color(0xFF1E293B);
  static const _border = Color(0xFF334155);
  static const _text = Color(0xFFF1F5F9);
  static const _green = Color(0xFF4ADE80);
  static const _red = Color(0xFFF87171);
  static const _blue = Color(0xFF3B82F6);
  static const _muted = Color(0xFF94A3B8);

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _isStrictMode = context.read<LocalStorageService>().loadStrictMode();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _loadQuestions() {
    final qs = <Question>[];
    for (var id in widget.questionIds) {
      final q = context.read<SubjectProvider>().getQuestion(id);
      if (q != null) qs.add(q);
    }
    // Shuffle the questions for the mini quiz
    qs.shuffle();
    _questions = qs;
  }

  void _answerQuestion(
    String questionId,
    int selectedIndex,
    int correctAnswer,
  ) async {
    final isCorrect = selectedIndex == correctAnswer;

    if (isCorrect) {
      HapticFeedback.mediumImpact();
    } else {
      HapticFeedback.heavyImpact();
    }

    setState(() {
      _selectedAnswer = selectedIndex;
      _answers[questionId] = isCorrect;
    });

    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = -1;
      });
    } else {
      setState(() {
        _isFinished = true;
      });
    }
  }

  void _finishMiniQuiz() {
    // For each answer in the mini-quiz, evaluate whether it stays in the queue or not.
    // In our implementation, we already passed 'processAnswer' in the review screen.
    // However, the mini-quiz acts as an extra strict evaluation.
    // If the user answered wrong here, we penalize it again.
    // If they answered right, we only keep it if _repeatCorrect is ON.
    _answers.forEach((qId, isCorrect) {
      if (!isCorrect) {
        // Penalize the card if they failed the mini quiz
        // Removed double SRS penalty
      } else {
        if (_repeatCorrect) {
          // If repeat is ON, we want to see them again later (reset interval slightly or keep it)
          // For now, doing nothing keeps them in their natural SRS flow
        } else {
          // If repeat is OFF, they learned it. We could advance its interval drastically
          // so it doesn't appear for a long time.
          // Removed double SRS reward
        }
      }
    });

    final correctCount = _answers.values.where((v) => v).length;
    final total = _questions.length;
    final score = (correctCount / total) * 20; // Nota sobre 20
    final passed = !_isStrictMode || score > 11;

    Navigator.pop(
      context,
      passed,
    ); // Return to SrsReviewScreen with pass/fail status
  }

  void _retryQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _selectedAnswer = -1;
      _answers.clear();
      _isFinished = false;
      _confettiPlayed = false;
      _questions.shuffle(); // Reshuffle for retry
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: const Center(
          child: Text(
            'Error: No hay preguntas para el quiz',
            style: TextStyle(color: _text),
          ),
        ),
      );
    }

    if (_isFinished) {
      return _buildResultsScreen();
    }

    final question = _questions[_currentQuestionIndex];
    final isAnswered = _answers.containsKey(question.id);

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Mini Quiz Rápido',
          style: TextStyle(
            color: _text,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (_currentQuestionIndex + 1) / _questions.length,
                      backgroundColor: _cardBg,
                      valueColor: const AlwaysStoppedAnimation<Color>(_blue),
                      minHeight: 6,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Pregunta ${_currentQuestionIndex + 1} de ${_questions.length}',
                          style: const TextStyle(
                            color: _blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          question.text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: _text,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 32),
                        ...List.generate(question.options.length, (index) {
                          final isCorrect = index == question.correctAnswer;
                          final isSelected = index == _selectedAnswer;

                          Color bg = _cardBg;
                          Color border = _border;

                          if (isAnswered) {
                            if (isCorrect) {
                              bg = _green.withValues(alpha: 0.2);
                              border = _green;
                            } else if (isSelected) {
                              bg = _red.withValues(alpha: 0.2);
                              border = _red;
                            }
                          } else if (isSelected) {
                            bg = _blue.withValues(alpha: 0.2);
                            border = _blue;
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Material(
                              color: bg,
                              borderRadius: BorderRadius.circular(14),
                              child: InkWell(
                                onTap: isAnswered
                                    ? null
                                    : () => _answerQuestion(
                                        question.id,
                                        index,
                                        question.correctAnswer,
                                      ),
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: border),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        String.fromCharCode(65 + index),
                                        style: TextStyle(
                                          color: border,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          question.options[index],
                                          style: const TextStyle(color: _text),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    final correctCount = _answers.values.where((v) => v).length;
    final total = _questions.length;
    final score = (correctCount / total) * 20; // Nota sobre 20
    final passed = !_isStrictMode || score > 11;

    if (passed && !_confettiPlayed) {
      _confettiPlayed = true;
      _confettiController.play();
    }

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        passed ? Icons.emoji_events : Icons.cancel_rounded,
                        color: passed ? Colors.amber : _red,
                        size: 80,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        passed
                            ? 'Resultados del Mini-Quiz'
                            : 'Mini-Quiz No Aprobado',
                        style: const TextStyle(
                          color: _text,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Has obtenido $correctCount de $total aciertos.',
                        style: const TextStyle(color: _text, fontSize: 16),
                      ),
                      Text(
                        'Nota: ${score.toStringAsFixed(1)} / 20',
                        style: TextStyle(
                          color: score > 11 ? _green : _red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      if (!passed) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: _red.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _red.withValues(alpha: 0.3),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.info_outline, color: _red, size: 18),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Modo Estricto: Debes repetir la revisión de estas tarjetas.',
                                  style: TextStyle(
                                    color: _red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _cardBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _border),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Volver a repetir las que respondí bien',
                                    style: TextStyle(
                                      color: _text,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Switch(
                                  value: _repeatCorrect,
                                  activeThumbColor: _blue,
                                  onChanged: (val) {
                                    setState(() {
                                      _repeatCorrect = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const Divider(color: _border, height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Modo Estricto',
                                        style: TextStyle(
                                          color: _text,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        'Debes sacar más de 11 para avanzar',
                                        style: TextStyle(
                                          color: _muted,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Switch(
                                  value: _isStrictMode,
                                  activeThumbColor: _blue,
                                  onChanged: (val) {
                                    setState(() {
                                      _isStrictMode = val;
                                    });
                                    context
                                        .read<LocalStorageService>()
                                        .saveStrictMode(val);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _retryQuiz,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: _text,
                                side: const BorderSide(color: _border),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text('REINTENTAR'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _finishMiniQuiz,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: passed ? _blue : _red,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Text(
                                passed ? 'CONTINUAR' : 'REPETIR REVISIÓN',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple,
                ],
                numberOfParticles: 40,
                gravity: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/providers/gamification_provider.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/data/subjects_repository.dart';
import 'package:learn/models/question.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  List<Question> _questions = [];
  int _selectedAnswer = -1;
  bool _isLoaded = false;
  bool _canPop = false;
  String? _errorMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded) {
      _loadQuestions();
    }
  }

  void _loadQuestions() {
    try {
      final session = context.read<QuizProvider>().currentSession;
      if (session != null) {
        final loadedQs = <Question>[];
        for (var id in session.questionIds) {
          final q = SubjectsRepository.getQuestion(id);
          if (q != null) loadedQs.add(q);
        }

        if (loadedQs.isEmpty) {
          context.read<QuizProvider>().cancelSession();
          _errorMessage = 'No se encontraron preguntas para este tema.';
        } else {
          _questions = loadedQs;
          // Restore progress safely
          final answered = session.answers.length;
          _currentQuestionIndex = answered < _questions.length
              ? answered
              : _questions.length - 1;
        }
      } else {
        _errorMessage = 'No hay sesión de quiz activa.';
      }
    } catch (e) {
      _errorMessage = 'Error al cargar: $e';
    }
    setState(() => _isLoaded = true);
  }

  void _answerQuestion(String questionId, int selectedIndex, int correctAnswer) {
    final isCorrect = selectedIndex == correctAnswer;
    context.read<QuizProvider>().answerQuestion(questionId, selectedIndex, isCorrect);
    if (isCorrect) context.read<GamificationProvider>().addXp(10);
    context.read<SrsProvider>().processAnswer(
      questionId,
      context.read<QuizProvider>().currentSession!.topicId,
      isCorrect,
    );
    setState(() => _selectedAnswer = selectedIndex);
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = -1;
      });
    }
  }

  void _finishQuiz() {
    context.read<QuizProvider>().finishSession();
    Navigator.pushReplacementNamed(context, '/quiz-results');
  }

  void _exitQuiz() {
    final session = context.read<QuizProvider>().currentSession;
    if (session != null && session.answers.isNotEmpty) {
      _finishQuiz();
    } else {
      context.read<QuizProvider>().cancelSession();
      setState(() => _canPop = true);
      Future.microtask(() {
        if (mounted) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Loading state
    if (!_isLoaded) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F172A),
        body: Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6))),
      );
    }

    // Error / empty state
    if (_errorMessage != null || _questions.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        appBar: AppBar(
          title: const Text('Quiz', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 48),
                const SizedBox(height: 16),
                Text(
                  _errorMessage ?? 'No hay quiz activo',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Volver al inicio'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Guard: clamp index to valid range
    if (_currentQuestionIndex >= _questions.length) {
      _currentQuestionIndex = _questions.length - 1;
    }
    if (_currentQuestionIndex < 0) {
      _currentQuestionIndex = 0;
    }

    final session = context.watch<QuizProvider>().currentSession;
    if (session == null) {
      // Session was cancelled elsewhere — bail
      return Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Sesión finalizada', style: TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false),
                child: const Text('Volver al inicio'),
              ),
            ],
          ),
        ),
      );
    }

    final question = _questions[_currentQuestionIndex];
    final isAnswered = session.correctness.containsKey(question.id);
    final isCorrect = session.correctness[question.id] ?? false;
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _exitQuiz();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        body: SafeArea(
          child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _exitQuiz,
                    icon: const Icon(Icons.close, color: Colors.white60),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: const Color(0xFF1E293B),
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${_currentQuestionIndex + 1} de ${_questions.length}',
                          style: const TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // Question + options
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Question number badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Pregunta ${_currentQuestionIndex + 1}',
                        style: const TextStyle(
                          color: Color(0xFF3B82F6),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Question text
                    Center(
                      child: Text(
                        question.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Options
                    ...List.generate(question.options.length, (i) {
                      Color bg = const Color(0xFF1E293B);
                      Color border = const Color(0xFF334155);
                      Color textColor = Colors.white;
                      Widget? trailing;

                      if (isAnswered) {
                        if (i == question.correctAnswer) {
                          bg = const Color(0xFF052E16);
                          border = const Color(0xFF16A34A);
                          textColor = const Color(0xFF86EFAC);
                          trailing = const Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 22);
                        } else if (i == _selectedAnswer && i != question.correctAnswer) {
                          bg = const Color(0xFF2D0A0A);
                          border = const Color(0xFFDC2626);
                          textColor = const Color(0xFFFCA5A5);
                          trailing = const Icon(Icons.cancel, color: Color(0xFFDC2626), size: 22);
                        }
                      } else if (i == _selectedAnswer) {
                        bg = const Color(0xFF1E3A5F);
                        border = const Color(0xFF3B82F6);
                        textColor = const Color(0xFF93C5FD);
                      }

                      // Hide unselected wrong options after answering
                      if (isAnswered && i != question.correctAnswer && i != _selectedAnswer) {
                        return const SizedBox.shrink();
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Material(
                          color: bg,
                          borderRadius: BorderRadius.circular(14),
                          child: InkWell(
                            onTap: isAnswered ? null : () => _answerQuestion(question.id, i, question.correctAnswer),
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: border, width: 1.5),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: border.withValues(alpha: 0.2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        String.fromCharCode(65 + i),
                                        style: TextStyle(
                                          color: border,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      question.options[i],
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: textColor,
                                        fontWeight: FontWeight.w500,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                  if (trailing != null) ...[
                                    const SizedBox(width: 8),
                                    trailing,
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),

                    // Explanation
                    if (isAnswered && question.explanation.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF334155)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('💡', style: TextStyle(fontSize: 22)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Concepto a repasar',
                                    style: TextStyle(
                                      color: Color(0xFF60A5FA),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      letterSpacing: 1.1,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    question.explanation,
                                    style: const TextStyle(
                                      color: Color(0xFFE2E8F0),
                                      fontSize: 15,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom action
            if (isAnswered)
              Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                decoration: const BoxDecoration(
                  color: Color(0xFF0F172A),
                  border: Border(top: BorderSide(color: Color(0xFF1E293B))),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _currentQuestionIndex < _questions.length - 1
                        ? _nextQuestion
                        : _finishQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                    child: Text(
                      _currentQuestionIndex < _questions.length - 1
                          ? 'Siguiente  →'
                          : '¡Finalizar Quiz!',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ));
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/providers/gamification_provider.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/models/question.dart';
import 'package:learn/core/services/audio_service.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/config/neural_design_system.dart';
import 'package:learn/core/services/gemini_service.dart';
import 'package:go_router/go_router.dart';

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
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

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
          final q = context.read<SubjectProvider>().getQuestion(id);
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
    final session = context.read<QuizProvider>().currentSession;
    if (session == null || session.correctness.containsKey(questionId)) return;

    final isCorrect = selectedIndex == correctAnswer;
    
    if (isCorrect) {
      HapticFeedback.mediumImpact();
      context.read<AudioService>().playCorrectSound();
    } else {
      HapticFeedback.heavyImpact();
      context.read<AudioService>().playIncorrectSound();
    }

    context.read<QuizProvider>().answerQuestion(questionId, selectedIndex, isCorrect);
    if (isCorrect) context.read<GamificationProvider>().addXp(10);
    context.read<SrsProvider>().processAnswer(
      questionId,
      session.topicId,
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
    context.replace('/quiz-results');
  }

  void _exitQuiz() {
    final session = context.read<QuizProvider>().currentSession;
    if (session != null && session.answers.isEmpty) {
      context.read<QuizProvider>().cancelSession();
    }
    
    // Si hay respuestas, simplemente salimos sin cancelar ni finalizar la sesión.
    // Esto permite reanudarla después ("Continuar respondiendo").
    setState(() => _canPop = true);
    Future.microtask(() {
      if (mounted) Navigator.pop(context);
    });
  }

  Future<void> _askAlipio(Question question, int selected) async {
    final respElegida = selected >= 0 && selected < question.options.length ? question.options[selected] : 'Ninguna';
    final respCorrecta = question.options[question.correctAnswer];
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(
        child: CircularProgressIndicator(color: NeuralDesignSystem.blueGoogle),
      ),
    );

    final explanation = await GeminiService.explicarError(question.text, respElegida, respCorrecta);
    
    if (mounted) {
      Navigator.pop(context); // close loading
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: NeuralDesignSystem.surfaceCard,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Text('💡', style: TextStyle(fontSize: 24)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Alipio dice:',
                  style: TextStyle(color: Colors.white, fontFamily: 'Outfit', fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: Text(
            explanation,
            style: const TextStyle(color: NeuralDesignSystem.textPrimaryAlt, fontSize: 15, height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Entendido', style: TextStyle(color: NeuralDesignSystem.blueGoogle)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Loading state
    if (!_isLoaded) {
      return const Scaffold(
        backgroundColor: NeuralDesignSystem.background,
        body: NeuralBackgroundWrapper(
          child: Center(child: CircularProgressIndicator(color: NeuralDesignSystem.blueGoogle)),
        ),
      );
    }

    // Error / empty state
    if (_errorMessage != null || _questions.isEmpty) {
      return Scaffold(
        backgroundColor: NeuralDesignSystem.background,
        appBar: AppBar(
          title: const Text('Quiz',
              style: TextStyle(fontFamily: 'Outfit', color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: NeuralBackgroundWrapper(
          child: Center(
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
                      backgroundColor: NeuralDesignSystem.blueGoogle,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Volver al inicio'),
                  ),
                ],
              ),
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
      return Scaffold(
        backgroundColor: NeuralDesignSystem.background,
        body: NeuralBackgroundWrapper(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sesión finalizada',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Outfit')),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: NeuralDesignSystem.blueGoogle,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Volver al inicio', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final question = _questions[_currentQuestionIndex];
    final isAnswered = session.correctness.containsKey(question.id);
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _exitQuiz();
      },
      child: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent) {
            final key = event.logicalKey;
            if (!isAnswered) {
              int selectedIndex = -1;
              if (key == LogicalKeyboardKey.keyA || key == LogicalKeyboardKey.digit1) {
                selectedIndex = 0;
              } else if (key == LogicalKeyboardKey.keyB || key == LogicalKeyboardKey.digit2) {
                selectedIndex = 1;
              } else if (key == LogicalKeyboardKey.keyC || key == LogicalKeyboardKey.digit3) {
                selectedIndex = 2;
              } else if (key == LogicalKeyboardKey.keyD || key == LogicalKeyboardKey.digit4) {
                selectedIndex = 3;
              }
              if (selectedIndex != -1 && selectedIndex < question.options.length) {
                _answerQuestion(question.id, selectedIndex, question.correctAnswer);
              }
            } else {
              if (key == LogicalKeyboardKey.space || key == LogicalKeyboardKey.enter) {
                if (_currentQuestionIndex < _questions.length - 1) {
                  _nextQuestion();
                } else {
                  _finishQuiz();
                }
              }
            }
          }
        },
        child: Scaffold(
          backgroundColor: NeuralDesignSystem.background,
          body: NeuralBackgroundWrapper(
            child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 650),
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
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: NeuralDesignSystem.surfaceCard,
                                valueColor: const AlwaysStoppedAnimation<Color>(NeuralDesignSystem.blueGoogle),
                                minHeight: 7,
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
                          Color bg = NeuralDesignSystem.surfaceCard.withValues(alpha: 0.6);
                          Color border = Colors.white.withValues(alpha: 0.1);
                          Color textColor = NeuralDesignSystem.textPrimaryAlt;
                          Widget? trailing;

                          if (isAnswered) {
                            if (i == question.correctAnswer) {
                              bg = const Color(0xFF052E16).withValues(alpha: 0.8);
                              border = const Color(0xFF16A34A);
                              textColor = const Color(0xFF86EFAC);
                              trailing = const Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 22);
                            } else if (i == _selectedAnswer && i != question.correctAnswer) {
                              bg = const Color(0xFF2D0A0A).withValues(alpha: 0.8);
                              border = NeuralDesignSystem.pink;
                              textColor = const Color(0xFFFCA5A5);
                              trailing = const Icon(Icons.cancel, color: NeuralDesignSystem.pink, size: 22);
                            }
                          } else if (i == _selectedAnswer) {
                            bg = NeuralDesignSystem.blueGoogle.withValues(alpha: 0.12);
                            border = NeuralDesignSystem.blueGoogle;
                            textColor = const Color(0xFF93C5FD);
                          }
    
                          if (isAnswered && i != question.correctAnswer && i != _selectedAnswer) {
                            return const SizedBox.shrink();
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
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
                                                  fontFamily: 'Outfit',
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
                                                fontFamily: 'Inter',
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
                              ),
                            ),
                          );
                        }),
    
                        // Explanation
                        if (isAnswered && question.explanation.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: NeuralDesignSystem.purple.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: NeuralDesignSystem.purple.withValues(alpha: 0.3),
                                  ),
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
                                            'CONCEPTO CLAVE',
                                            style: TextStyle(
                                              color: NeuralDesignSystem.cyan,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                              letterSpacing: 1.2,
                                              fontFamily: 'Outfit',
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            question.explanation,
                                            style: const TextStyle(
                                              color: NeuralDesignSystem.textPrimaryAlt,
                                              fontSize: 15,
                                              height: 1.5,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                        
                        // Alipio Button for Wrong Answers
                        if (isAnswered && _selectedAnswer != question.correctAnswer) ...[
                          const SizedBox(height: 16),
                          Center(
                            child: OutlinedButton.icon(
                              onPressed: () => _askAlipio(question, _selectedAnswer),
                              icon: const Text('🤖', style: TextStyle(fontSize: 18)),
                              label: const Text('Preguntar a Alipio por qué fallé'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: NeuralDesignSystem.blueGoogle,
                                side: BorderSide(color: NeuralDesignSystem.blueGoogle.withValues(alpha: 0.5)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
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
                    decoration: BoxDecoration(
                      color: NeuralDesignSystem.background.withValues(alpha: 0.9),
                      border: Border(
                        top: BorderSide(
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: NeuralDesignSystem.neuralGradient,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: NeuralDesignSystem.blueGoogle.withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _currentQuestionIndex < _questions.length - 1
                              ? _nextQuestion
                              : _finishQuiz,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            elevation: 0,
                          ),
                          child: Text(
                            _currentQuestionIndex < _questions.length - 1
                                ? 'Siguiente  →'
                                : '¡Finalizar Quiz!',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        ),  // NeuralBackgroundWrapper
      ),
    ),
    ),
  );
}
}

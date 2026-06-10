import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:learn/models/question.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/providers/gamification_provider.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/services/audio_service.dart';
import 'package:go_router/go_router.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  late List<Question> _questions;
  int _currentIndex = 0;
  final Map<String, int> _answers = {}; // questionId -> selectedIndex
  final FocusNode _focusNode = FocusNode();
  
  // Timer
  static const int _examDuration = 3 * 60 * 60; // 3 hours in seconds
  int _secondsLeft = _examDuration;
  Timer? _timer;
  late DateTime _endTime;
  bool _canPop = false;

  @override
  void initState() {
    super.initState();
    _questions = context.read<SubjectProvider>().generateExamQuestions();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  void _startTimer() {
    _endTime = DateTime.now().add(const Duration(seconds: _examDuration));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = _endTime.difference(DateTime.now()).inSeconds;
      if (remaining > 0) {
        setState(() => _secondsLeft = remaining);
      } else {
        setState(() => _secondsLeft = 0);
        _finishExam();
      }
    });
  }

  String get _formattedTime {
    final h = (_secondsLeft ~/ 3600).toString().padLeft(2, '0');
    final m = ((_secondsLeft % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  void _answerQuestion(String qId, int selected) {
    HapticFeedback.selectionClick();
    context.read<AudioService>().playCorrectSound(); // Un sonido genérico de clic/selección o correct para feedback
    final wasAlreadyAnswered = _answers.containsKey(qId);
    setState(() {
      _answers[qId] = selected;
    });
    
    // Auto-advance only if answering for the first time
    if (!wasAlreadyAnswered && _currentIndex < _questions.length - 1) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          // Double-check if the user is still on the same question (didn't navigate manually)
          if (_currentIndex < _questions.length && _questions[_currentIndex].id == qId) {
            setState(() => _currentIndex++);
          }
        }
      });
    }
  }

  void _finishExam() {
    _timer?.cancel();
    int correctCount = 0;
    
    final srs = context.read<SrsProvider>();
    final gamification = context.read<GamificationProvider>();

    for (var q in _questions) {
      bool isCorrect = _answers[q.id] == q.correctAnswer;
      if (isCorrect) {
        correctCount++;
      }
      // UPDATE SRS
      srs.processAnswer(q.id, q.topicId, isCorrect);
    }
    
    // UPDATE GAMIFICATION
    if (correctCount > 0) {
      gamification.addXp(correctCount * 10);
    }
    // Bonus for finishing exam
    gamification.addXp(50);
    
    context.replace('/exam-results', extra: {
        'score': correctCount,
        'total': _questions.length,
        'timeSpent': _examDuration - _secondsLeft,
        'questions': _questions,
        'answers': _answers,
      },
    );
  }

  Future<void> _confirmFinish() async {
    int missing = _questions.length - _answers.length;
    
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('¿Entregar Examen?', style: TextStyle(color: Colors.white)),
        content: Text(
          missing > 0 
              ? 'Aún te faltan $missing preguntas por responder.\n\n¿Estás seguro de que deseas entregar el simulacro ahora?'
              : 'Has respondido todas las preguntas.\n\n¿Deseas entregar el simulacro y ver tus resultados?',
          style: const TextStyle(color: Color(0xFF94A3B8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Seguir Revisando'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
            child: const Text('Sí, Entregar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      _finishExam();
    }
  }

  Future<void> _handleExit() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('¿Abandonar el examen?', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Estás a punto de salir. Si lo haces, perderás todo el progreso de este simulacro y tu puntaje será destruido.',
          style: TextStyle(color: Color(0xFF94A3B8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Continuar Examen'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Abandonar', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      _timer?.cancel();
      setState(() => _canPop = true);
      final navigator = Navigator.of(context);
      Future.microtask(() => navigator.pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Scaffold(
        backgroundColor: Colors.transparent,
        body: NeuralBackgroundWrapper(
          child: Center(
            child: Text(
              'No se pudieron cargar las preguntas.',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }

    final question = _questions[_currentIndex];
    final selectedAnswer = _answers[question.id] ?? -1;

    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _handleExit();
      },
      child: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent) {
            final key = event.logicalKey;
            
            if (key == LogicalKeyboardKey.arrowLeft) {
              if (_currentIndex > 0) {
                setState(() => _currentIndex--);
              }
            } else if (key == LogicalKeyboardKey.arrowRight) {
              if (_currentIndex < _questions.length - 1) {
                setState(() => _currentIndex++);
              }
            } else {
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
                _answerQuestion(question.id, selectedIndex);
              }
            }
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: NeuralBackgroundWrapper(
            child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 650),
                child: Column(
                children: [
                  // ── HEADER ──
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: _handleExit,
                          icon: const Icon(Icons.close, color: Colors.white60),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: _secondsLeft < 300 ? Colors.redAccent.withValues(alpha: 0.15) : const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _secondsLeft < 300 ? Colors.redAccent : const Color(0xFF334155)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.timer_outlined, color: _secondsLeft < 300 ? Colors.redAccent : Colors.white, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                _formattedTime,
                                style: TextStyle(
                                  color: _secondsLeft < 300 ? Colors.redAccent : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: _confirmFinish,
                          child: const Text('Entregar', style: TextStyle(color: Colors.blueAccent)),
                        ),
                      ],
                    ),
                  ),
    
                  // ── PREGUNTA ──
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // Navigator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: _currentIndex > 0 ? () => setState(() => _currentIndex--) : null,
                                icon: const Icon(Icons.arrow_back_ios, size: 18),
                                color: Colors.white,
                                disabledColor: Colors.white24,
                              ),
                              Text(
                                'Pregunta ${_currentIndex + 1} de ${_questions.length}',
                                style: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: _currentIndex < _questions.length - 1 ? () => setState(() => _currentIndex++) : null,
                                icon: const Icon(Icons.arrow_forward_ios, size: 18),
                                color: Colors.white,
                                disabledColor: Colors.white24,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
    
                          // Texto de la pregunta
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
                          const SizedBox(height: 32),
    
                          // Opciones
                          ...List.generate(question.options.length, (i) {
                            final isSelected = selectedAnswer == i;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Material(
                                color: isSelected ? const Color(0xFF1E3A5F) : const Color(0xFF1E293B),
                                borderRadius: BorderRadius.circular(14),
                                child: InkWell(
                                  onTap: () => _answerQuestion(question.id, i),
                                  borderRadius: BorderRadius.circular(14),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF334155),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isSelected ? const Color(0xFF3B82F6).withValues(alpha: 0.2) : const Color(0xFF334155).withValues(alpha: 0.2),
                                          ),
                                          child: Center(
                                            child: Text(
                                              String.fromCharCode(65 + i),
                                              style: TextStyle(
                                                color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF334155),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 14),
                                        Expanded(
                                          child: Text(
                                            question.options[i],
                                            style: TextStyle(
                                              color: isSelected ? const Color(0xFF93C5FD) : Colors.white,
                                              fontSize: 15,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 20),
                          if (_currentIndex == _questions.length - 1)
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: _confirmFinish,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                ),
                                child: const Text('Entregar Simulacro', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                              ),
                            ),
                          const SizedBox(height: 40), // Espacio al final
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    ),
    );
  }
}

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
import 'package:learn/core/services/local_storage_service.dart';
import 'package:learn/models/subject.dart';
import 'package:learn/data/repository/subjects_repository.dart';

class ExamScreen extends StatefulWidget {
  final bool resume;
  const ExamScreen({super.key, this.resume = false});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  late List<Question> _questions;
  int _currentIndex = 0;
  final Map<String, int> _answers = {}; // questionId -> selectedIndex
  final Set<String> _flaggedQuestionIds = {}; // questionId flagged for review
  final FocusNode _focusNode = FocusNode();

  // Timer
  static const int _examDuration = 3 * 60 * 60; // 3 hours in seconds
  int _secondsLeft = _examDuration;
  Timer? _timer;
  late DateTime _endTime;
  bool _canPop = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    final storage = context.read<LocalStorageService>();
    if (widget.resume) {
      final savedState = storage.getActiveExamState();
      if (savedState != null) {
        try {
          final List<dynamic> qList = savedState['questions'] as List;
          _questions = qList
              .map(
                (e) => Question.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList();

          final Map<dynamic, dynamic> ansMap =
              savedState['answers'] as Map? ?? {};
          ansMap.forEach((key, val) {
            _answers[key.toString()] = val as int;
          });

          final List<dynamic> flaggedList =
              savedState['flagged'] as List? ?? [];
          for (final f in flaggedList) {
            _flaggedQuestionIds.add(f.toString());
          }

          _secondsLeft = savedState['secondsLeft'] as int? ?? _examDuration;
          _currentIndex = savedState['currentIndex'] as int? ?? 0;
        } catch (e) {
          debugPrint('Error restoring exam state: $e');
          _questions = context.read<SubjectProvider>().generateExamQuestions();
        }
      } else {
        _questions = context.read<SubjectProvider>().generateExamQuestions();
      }
    } else {
      _questions = context.read<SubjectProvider>().generateExamQuestions();
      storage.clearActiveExamState();
    }

    _startTimer();

    if (!widget.resume) {
      _saveExamProgress();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  void _startTimer() {
    _endTime = DateTime.now().add(Duration(seconds: _secondsLeft));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = _endTime.difference(DateTime.now()).inSeconds;
      if (remaining > 0) {
        if (mounted) {
          setState(() => _secondsLeft = remaining);
        }
      } else {
        if (mounted) {
          setState(() => _secondsLeft = 0);
          _finishExam();
        }
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isPaused = true;
    });
    _saveExamProgress();
  }

  void _resumeTimer() {
    _endTime = DateTime.now().add(Duration(seconds: _secondsLeft));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = _endTime.difference(DateTime.now()).inSeconds;
      if (remaining > 0) {
        if (mounted) {
          setState(() => _secondsLeft = remaining);
        }
      } else {
        if (mounted) {
          setState(() => _secondsLeft = 0);
          _finishExam();
        }
      }
    });
    setState(() {
      _isPaused = false;
    });
  }

  void _saveExamProgress() {
    try {
      final storage = context.read<LocalStorageService>();
      final state = {
        'questions': _questions.map((q) => q.toJson()).toList(),
        'answers': _answers,
        'flagged': _flaggedQuestionIds.toList(),
        'secondsLeft': _secondsLeft,
        'currentIndex': _currentIndex,
      };
      storage.saveActiveExamState(state);
    } catch (e) {
      debugPrint('Error saving exam progress: $e');
    }
  }

  void _saveAndExit() {
    _timer?.cancel();
    _saveExamProgress();
    setState(() => _canPop = true);
    context.go('/home');
  }

  String get _formattedTime {
    final h = (_secondsLeft ~/ 3600).toString().padLeft(2, '0');
    final m = ((_secondsLeft % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Subject? _getCurrentSubject(Question q) {
    final topic = SubjectsRepository.getTopic(q.topicId);
    if (topic == null) return null;
    return SubjectsRepository.getSubject(topic.subjectId);
  }

  void _answerQuestion(String qId, int selected) {
    HapticFeedback.selectionClick();
    context.read<AudioService>().playCorrectSound();
    final wasAlreadyAnswered = _answers.containsKey(qId);
    setState(() {
      _answers[qId] = selected;
    });
    _saveExamProgress();

    // Auto-advance only if answering for the first time
    if (!wasAlreadyAnswered && _currentIndex < _questions.length - 1) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() => _currentIndex++);
          _saveExamProgress();
        }
      });
    }
  }

  void _finishExam() {
    _timer?.cancel();
    int correctCount = 0;

    final srs = context.read<SrsProvider>();
    final gamification = context.read<GamificationProvider>();
    final storage = context.read<LocalStorageService>();

    for (var q in _questions) {
      bool isCorrect = _answers[q.id] == q.correctAnswer;
      if (isCorrect) {
        correctCount++;
      }
      srs.processAnswer(q.id, q.topicId, isCorrect);
    }

    if (correctCount > 0) {
      gamification.addXp(correctCount * 10);
    }
    gamification.addXp(50); // Bonus for finishing exam

    // Save to history
    final record = {
      'date': DateTime.now().toIso8601String(),
      'score': correctCount,
      'total': _questions.length,
      'timeSpent': _examDuration - _secondsLeft,
    };
    storage.saveExamHistory(record);

    // Clear active state
    storage.clearActiveExamState();

    context.replace(
      '/exam-results',
      extra: {
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
        title: const Text(
          '¿Entregar Examen?',
          style: TextStyle(color: Colors.white),
        ),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
            ),
            child: const Text(
              'Sí, Entregar',
              style: TextStyle(color: Colors.white),
            ),
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
        title: const Text(
          '¿Abandonar el examen?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          '¿Qué deseas hacer? Puedes guardar tu progreso para continuar después o abandonar permanentemente y destruir tu puntaje.',
          style: TextStyle(color: Color(0xFF94A3B8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Volver al examen'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx, false);
              _saveAndExit();
            },
            child: const Text(
              'Guardar y Salir',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<LocalStorageService>().clearActiveExamState();
              Navigator.pop(ctx, true);
            },
            child: const Text(
              'Abandonar',
              style: TextStyle(color: Colors.redAccent),
            ),
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

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
        ),
      ],
    );
  }

  void _showNavigationGrid() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF334155),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        'Mapa de Preguntas',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white70),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildLegendItem(const Color(0xFF1E293B), 'Pendiente'),
                      _buildLegendItem(const Color(0xFF3B82F6), 'Respondida'),
                      _buildLegendItem(Colors.orange, 'Marcada (Bandera)'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      controller: scrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemCount: _questions.length,
                      itemBuilder: (context, index) {
                        final q = _questions[index];
                        final isAnswered = _answers.containsKey(q.id);
                        final isFlagged = _flaggedQuestionIds.contains(q.id);
                        final isCurrent = index == _currentIndex;

                        Color bgColor = const Color(0xFF1E293B);
                        Color textColor = const Color(0xFF94A3B8);
                        Border? border;

                        if (isAnswered) {
                          bgColor = const Color(0xFF3B82F6);
                          textColor = Colors.white;
                        }
                        if (isFlagged) {
                          bgColor = Colors.orange;
                          textColor = Colors.white;
                        }
                        if (isCurrent) {
                          border = Border.all(color: Colors.white, width: 2);
                        }

                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(ctx);
                            setState(() => _currentIndex = index);
                            _saveExamProgress();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(10),
                              border: border,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSidebarGrid() {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(left: 20, top: 16, bottom: 16, right: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mapa de Preguntas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLegendItem(const Color(0xFF1E293B), 'Pendiente'),
              _buildLegendItem(const Color(0xFF3B82F6), 'Lista'),
              _buildLegendItem(Colors.orange, 'Marcada'),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                final q = _questions[index];
                final isAnswered = _answers.containsKey(q.id);
                final isFlagged = _flaggedQuestionIds.contains(q.id);
                final isCurrent = index == _currentIndex;

                Color bgColor = const Color(0xFF1E293B);
                Color textColor = const Color(0xFF94A3B8);
                Border? border;

                if (isAnswered) {
                  bgColor = const Color(0xFF3B82F6);
                  textColor = Colors.white;
                }
                if (isFlagged) {
                  bgColor = Colors.orange;
                  textColor = Colors.white;
                }
                if (isCurrent) {
                  border = Border.all(color: Colors.white, width: 2);
                }

                return GestureDetector(
                  onTap: () {
                    setState(() => _currentIndex = index);
                    _saveExamProgress();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(8),
                      border: border,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainQuestionColumn(
    String subjectIcon,
    Color subjectColor,
    Subject? currentSubject,
    Question question,
    int selectedAnswer,
    bool isFlagged,
    bool isLargeScreen,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isLargeScreen ? double.infinity : 650,
        ),
        child: Column(
          children: [
            // ── HEADER ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _handleExit,
                    icon: const Icon(Icons.close, color: Colors.white60),
                  ),
                  const Spacer(),
                  // Pausa + Timer
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _secondsLeft < 300
                          ? Colors.redAccent.withValues(alpha: 0.15)
                          : const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _secondsLeft < 300
                            ? Colors.redAccent
                            : const Color(0xFF334155),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          icon: const Icon(
                            Icons.pause,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: _pauseTimer,
                        ),
                        const SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            color: Color(0xFF334155),
                            width: 1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.timer_outlined,
                          color: _secondsLeft < 300
                              ? Colors.redAccent
                              : Colors.white70,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _formattedTime,
                          style: TextStyle(
                            color: _secondsLeft < 300
                                ? Colors.redAccent
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 4),
                      ],
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _confirmFinish,
                    child: const Text(
                      'Entregar',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── BARRA DE PROGRESO ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _questions.isEmpty
                          ? 0
                          : (_currentIndex + 1) / _questions.length,
                      backgroundColor: const Color(0xFF1E293B),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF3B82F6),
                      ),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pregunta ${_currentIndex + 1} de ${_questions.length}',
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Respondidas: ${_answers.length}/${_questions.length}',
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // ── MATERIA Y BANDERA ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: subjectColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: subjectColor.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(subjectIcon, style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 6),
                        Text(
                          currentSubject?.name.toUpperCase() ?? 'MATERIA',
                          style: TextStyle(
                            color: subjectColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      if (!isLargeScreen)
                        IconButton(
                          icon: const Icon(
                            Icons.grid_view_rounded,
                            color: Colors.white70,
                          ),
                          onPressed: _showNavigationGrid,
                          tooltip: 'Ver todas las preguntas',
                        ),
                      IconButton(
                        icon: Icon(
                          isFlagged ? Icons.flag : Icons.flag_outlined,
                          color: isFlagged ? Colors.orange : Colors.white60,
                        ),
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          setState(() {
                            if (isFlagged) {
                              _flaggedQuestionIds.remove(question.id);
                            } else {
                              _flaggedQuestionIds.add(question.id);
                            }
                          });
                          _saveExamProgress();
                        },
                        tooltip: 'Marcar para revisión',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── PREGUNTA Y OPCIONES ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Flechas de navegación rápida en la tarjeta
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: _currentIndex > 0
                              ? () {
                                  setState(() => _currentIndex--);
                                  _saveExamProgress();
                                }
                              : null,
                          icon: const Icon(Icons.arrow_back_ios, size: 18),
                          color: Colors.white,
                          disabledColor: Colors.white24,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: _currentIndex < _questions.length - 1
                              ? () {
                                  setState(() => _currentIndex++);
                                  _saveExamProgress();
                                }
                              : null,
                          icon: const Icon(Icons.arrow_forward_ios, size: 18),
                          color: Colors.white,
                          disabledColor: Colors.white24,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

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
                          color: isSelected
                              ? const Color(0xFF1E3A5F)
                              : const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(14),
                          child: InkWell(
                            onTap: () => _answerQuestion(question.id, i),
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF3B82F6)
                                      : const Color(0xFF334155),
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
                                      color: isSelected
                                          ? const Color(
                                              0xFF3B82F6,
                                            ).withValues(alpha: 0.2)
                                          : const Color(
                                              0xFF334155,
                                            ).withValues(alpha: 0.2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        String.fromCharCode(65 + i),
                                        style: TextStyle(
                                          color: isSelected
                                              ? const Color(0xFF3B82F6)
                                              : const Color(0xFF334155),
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
                                        color: isSelected
                                            ? const Color(0xFF93C5FD)
                                            : Colors.white,
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Entregar Simulacro',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
    final isFlagged = _flaggedQuestionIds.contains(question.id);

    final currentSubject = _getCurrentSubject(question);
    final subjectColorHex = currentSubject?.color ?? '#3B82F6';
    final colorVal =
        int.tryParse(subjectColorHex.replaceAll('#', ''), radix: 16) ??
        0xFF3B82F6;
    final subjectColor = Color(colorVal | 0xFF000000);
    final subjectIcon = currentSubject?.icon ?? '📚';

    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 950;

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
          if (event is KeyDownEvent && !_isPaused) {
            final key = event.logicalKey;

            if (key == LogicalKeyboardKey.arrowLeft) {
              if (_currentIndex > 0) {
                setState(() => _currentIndex--);
                _saveExamProgress();
              }
            } else if (key == LogicalKeyboardKey.arrowRight) {
              if (_currentIndex < _questions.length - 1) {
                setState(() => _currentIndex++);
                _saveExamProgress();
              }
            } else {
              int selectedIndex = -1;
              if (key == LogicalKeyboardKey.keyA ||
                  key == LogicalKeyboardKey.digit1) {
                selectedIndex = 0;
              } else if (key == LogicalKeyboardKey.keyB ||
                  key == LogicalKeyboardKey.digit2) {
                selectedIndex = 1;
              } else if (key == LogicalKeyboardKey.keyC ||
                  key == LogicalKeyboardKey.digit3) {
                selectedIndex = 2;
              } else if (key == LogicalKeyboardKey.keyD ||
                  key == LogicalKeyboardKey.digit4) {
                selectedIndex = 3;
              }
              if (selectedIndex != -1 &&
                  selectedIndex < question.options.length) {
                _answerQuestion(question.id, selectedIndex);
              }
            }
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              NeuralBackgroundWrapper(
                child: SafeArea(
                  child: isLargeScreen
                      ? Center(
                          child: SizedBox(
                            width: screenWidth.clamp(0.0, 960.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: _buildMainQuestionColumn(
                                    subjectIcon,
                                    subjectColor,
                                    currentSubject,
                                    question,
                                    selectedAnswer,
                                    isFlagged,
                                    isLargeScreen,
                                  ),
                                ),
                                _buildSidebarGrid(),
                              ],
                            ),
                          ),
                        )
                      : _buildMainQuestionColumn(
                          subjectIcon,
                          subjectColor,
                          currentSubject,
                          question,
                          selectedAnswer,
                          isFlagged,
                          isLargeScreen,
                        ),
                ),
              ),

              // ── PAUSE OVERLAY ──
              if (_isPaused)
                Positioned.fill(
                  child: Container(
                    color: const Color(0xFB0F172A), // Fondo sólido opaco
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.pause_circle_filled_rounded,
                            size: 90,
                            color: Color(0xFF3B82F6),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Simulacro Pausado',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'El contenido de las preguntas está oculto.',
                            style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 36),
                          ElevatedButton.icon(
                            onPressed: _resumeTimer,
                            icon: const Icon(Icons.play_arrow_rounded),
                            label: const Text('Reanudar Examen'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3B82F6),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextButton.icon(
                            onPressed: _saveAndExit,
                            icon: const Icon(Icons.save_rounded),
                            label: const Text('Guardar Progreso y Salir'),
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF94A3B8),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

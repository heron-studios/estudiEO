import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/models/learning_level.dart';
import 'package:learn/models/learning_session.dart';
import 'package:learn/models/question.dart';
import 'package:learn/providers/learning_provider.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/core/services/limits_service.dart';

/// Pantalla 2 del Modo Aprendizaje Guiado — Fase Reto (Bucle de 10).
///
/// Muestra la pregunta actual de la cola. Si el usuario acierta, la elimina
/// de la cola y sube el contador. Si falla, muestra un BottomSheet con
/// la respuesta correcta y la justificación, y reencola la pregunta al final.
class LearningQuizScreen extends StatefulWidget {
  final String topicId;
  final Dificultad nivel;

  const LearningQuizScreen({
    super.key,
    required this.topicId,
    required this.nivel,
  });

  @override
  State<LearningQuizScreen> createState() => _LearningQuizScreenState();
}

class _LearningQuizScreenState extends State<LearningQuizScreen>
    with TickerProviderStateMixin {
  int _selectedAnswer = -1;
  bool _isAnswering = false;

  // Animaciones de feedback
  late AnimationController _feedbackController;
  late Animation<double> _feedbackOpacity;
  bool _showCorrectOverlay = false;

  @override
  void initState() {
    super.initState();
    _feedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _feedbackOpacity = CurvedAnimation(
      parent: _feedbackController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _onAnswerSelected(int index, Question question) async {
    if (_isAnswering) return;
    setState(() {
      _isAnswering = true;
      _selectedAnswer = index;
    });

    final auth = context.read<AuthService>();
    if (!auth.isPremium) {
      LimitsService.incrementQuestionCount();
    }

    final isCorrect = index == question.correctAnswer;

    // Integra la respuesta con el algoritmo de Repaso Espaciado (SRS)
    context.read<SrsProvider>().processAnswer(
      question.id,
      question.topicId,
      isCorrect,
    );

    if (isCorrect) {
      // Mostrar overlay de éxito brevemente
      setState(() => _showCorrectOverlay = true);
      _feedbackController.forward(from: 0);
      await Future.delayed(const Duration(milliseconds: 900));
      if (!mounted) return;

      // Procesar respuesta (esto modifica la cola)
      context.read<LearningProvider>().responder(
        question.id,
        index,
        question.correctAnswer,
      );

      // Verificar si terminó
      final lp = context.read<LearningProvider>();
      if (lp.isFinished) {
        if (mounted) {
          context.replace(
            '/learning-levelup',
            extra: {
              'topicId': widget.topicId,
              'nivel': widget.nivel,
              'elapsed': lp.currentSession?.elapsed ?? Duration.zero,
            },
          );
        }
        return;
      }

      if (mounted) {
        setState(() {
          _showCorrectOverlay = false;
          _selectedAnswer = -1;
          _isAnswering = false;
        });
        _feedbackController.reset();
      }
    } else {
      // Mostrar BottomSheet de feedback de error
      if (!mounted) return;
      await _showIncorrectBottomSheet(context, question);
      if (!mounted) return;

      // Procesar respuesta incorrecta (reencola)
      context.read<LearningProvider>().responder(
        question.id,
        index,
        question.correctAnswer,
      );

      if (mounted) {
        setState(() {
          _selectedAnswer = -1;
          _isAnswering = false;
        });
      }
    }
  }

  Future<void> _showIncorrectBottomSheet(
    BuildContext context,
    Question question,
  ) async {
    await showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _IncorrectFeedbackSheet(
        question: question,
        selectedAnswer: _selectedAnswer,
        nivel: widget.nivel,
      ),
    );
  }

  void _exitSession(BuildContext context) {
    // Solo limpia de memoria, la sesión persiste en storage para reanudar
    context.read<LearningProvider>().clearCurrentSession();
    Navigator.popUntil(context, ModalRoute.withName('/topics'));
  }

  @override
  Widget build(BuildContext context) {
    final lp = context.watch<LearningProvider>();
    final session = lp.currentSession;
    final question = lp.currentQuestion;

    if (session == null || question == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF0A0F1E),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.white38, size: 48),
              const SizedBox(height: 16),
              const Text(
                'No hay sesión activa',
                style: TextStyle(color: Colors.white60, fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Volver'),
              ),
            ],
          ),
        ),
      );
    }

    final correctCount = session.correctCount;
    const total = LearningSession.targetCorrect;
    final queueSize = session.questionQueue.length;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _exitSession(context);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0F1E),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),
              child: Stack(
                children: [
                  Column(
                    children: [
                      // ─── Top bar con progreso ──────────────────────────
                      _QuizTopBar(
                        correctCount: correctCount,
                        total: total,
                        queueSize: queueSize,
                        nivel: widget.nivel,
                        onExit: () => _exitSession(context),
                      ),

                      // ─── Cuerpo de la pregunta ─────────────────────────
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),

                              // Badge de nivel
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: widget.nivel.color.withValues(
                                        alpha: 0.15,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: widget.nivel.color.withValues(
                                          alpha: 0.4,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      '${widget.nivel.emoji} ${widget.nivel.displayName}',
                                      style: TextStyle(
                                        color: widget.nivel.color,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Quedan $queueSize en cola',
                                    style: const TextStyle(
                                      color: Colors.white38,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Texto de la pregunta
                              Text(
                                question.text,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  height: 1.55,
                                ),
                              ),
                              const SizedBox(height: 28),

                              // Opciones
                              ...List.generate(question.options.length, (i) {
                                return _OptionTile(
                                  index: i,
                                  text: question.options[i],
                                  isSelected: _selectedAnswer == i,
                                  isEnabled: !_isAnswering,
                                  onTap: () => _onAnswerSelected(i, question),
                                );
                              }),

                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ─── Overlay de respuesta correcta ─────────────────────
                  if (_showCorrectOverlay)
                    FadeTransition(
                      opacity: _feedbackOpacity,
                      child: Container(
                        color: const Color(0xFF052E16).withValues(alpha: 0.92),
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_rounded,
                                color: Color(0xFF22C55E),
                                size: 80,
                              ),
                              SizedBox(height: 16),
                              Text(
                                '¡Correcto!',
                                style: TextStyle(
                                  color: Color(0xFF22C55E),
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Widgets internos
// ─────────────────────────────────────────────────────────────────────────────

class _QuizTopBar extends StatelessWidget {
  final int correctCount;
  final int total;
  final int queueSize;
  final Dificultad nivel;
  final VoidCallback onExit;

  const _QuizTopBar({
    required this.correctCount,
    required this.total,
    required this.queueSize,
    required this.nivel,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    final progress = correctCount / total;

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0F1E),
        border: Border(bottom: BorderSide(color: Color(0xFF1E293B))),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onExit,
            icon: const Icon(Icons.close, color: Colors.white60, size: 22),
          ),
          Expanded(
            child: Column(
              children: [
                // Barra de progreso de aciertos
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor: const Color(0xFF1E293B),
                    valueColor: AlwaysStoppedAnimation<Color>(nivel.color),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Aciertos: $correctCount / $total',
                      style: TextStyle(
                        color: nivel.color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Meta: 10 ✓',
                      style: TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final int index;
  final String text;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  const _OptionTile({
    required this.index,
    required this.text,
    required this.isSelected,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = isSelected
        ? const Color(0xFF1E3A5F)
        : const Color(0xFF111827);
    final Color border = isSelected
        ? const Color(0xFF3B82F6)
        : const Color(0xFF1F2937);
    final Color textColor = isSelected ? const Color(0xFF93C5FD) : Colors.white;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: isEnabled ? onTap : null,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(color: border, width: 1.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: border.withValues(alpha: 0.25),
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index),
                      style: TextStyle(
                        color: isSelected
                            ? const Color(0xFF3B82F6)
                            : Colors.white54,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      height: 1.45,
                      fontWeight: FontWeight.w500,
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
}

class _IncorrectFeedbackSheet extends StatelessWidget {
  final Question question;
  final int selectedAnswer;
  final Dificultad nivel;

  const _IncorrectFeedbackSheet({
    required this.question,
    required this.selectedAnswer,
    required this.nivel,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF111827),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Encabezado de error
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF450A0A),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFEF4444),
                                width: 2,
                              ),
                            ),
                            child: const Center(
                              child: Text('❌', style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Respuesta incorrecta',
                                  style: TextStyle(
                                    color: Color(0xFFFCA5A5),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'La pregunta volverá al final de la cola',
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Respuesta correcta
                      const Text(
                        'La respuesta correcta era:',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF052E16),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF16A34A),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Color(0xFF22C55E),
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                question.options[question.correctAnswer],
                                style: const TextStyle(
                                  color: Color(0xFF86EFAC),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Tu respuesta
                      if (selectedAnswer >= 0 &&
                          selectedAnswer < question.options.length) ...[
                        const SizedBox(height: 12),
                        const Text(
                          'Tu respuesta:',
                          style: TextStyle(color: Colors.white38, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D0A0A),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFDC2626),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.cancel,
                                color: Color(0xFFEF4444),
                                size: 22,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  question.options[selectedAnswer],
                                  style: const TextStyle(
                                    color: Color(0xFFFCA5A5),
                                    fontSize: 15,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Justificación
                      if (question.explanation.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F172A),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF1E3A5F),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('💡', style: TextStyle(fontSize: 20)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Concepto a aprender',
                                      style: TextStyle(
                                        color: Color(0xFF60A5FA),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      question.explanation,
                                      style: const TextStyle(
                                        color: Color(0xFFCBD5E1),
                                        fontSize: 14,
                                        height: 1.65,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 28),

                      // Botón continuar
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1D4ED8),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Continuar aprendiendo',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:learn/features/psicolearn/domain/models/psico_question.dart';
import 'package:learn/features/psicolearn/domain/services/psico_service.dart';

class SimulatorScreen extends StatefulWidget {
  const SimulatorScreen({super.key});

  @override
  State<SimulatorScreen> createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends State<SimulatorScreen>
    with TickerProviderStateMixin {
  final PsicoService _service = PsicoService();
  List<PsicoQuestion>? _questions;
  int _currentIndex = 0;
  final Map<int, String> _answers = {};
  bool _isFinished = false;

  late Timer _timer;
  int _secondsRemaining = 120 * 60; // 2 horas para 100 preguntas
  bool _timerStarted = false;

  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final questions = await _service.loadDailyMission(100);
    if (!mounted) return;
    setState(() {
      _questions = questions;
    });
    _startTimer();
  }

  void _startTimer() {
    _timerStarted = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _timer.cancel();
        _finishExam();
      }
    });
  }

  String _formatTime(int totalSeconds) {
    final int h = totalSeconds ~/ 3600;
    final int m = (totalSeconds % 3600) ~/ 60;
    final int s = totalSeconds % 60;
    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  Color _timerColor() {
    if (_secondsRemaining < 300) return const Color(0xFFEF4444); // rojo < 5 min
    if (_secondsRemaining < 900) return const Color(0xFFF59E0B); // ámbar < 15 min
    return const Color(0xFF4ADE80); // verde
  }

  @override
  void dispose() {
    if (_timerStarted) _timer.cancel();
    _progressController.dispose();
    super.dispose();
  }

  void _onOptionSelected(String optionKey) {
    if (_questions == null || _isFinished) return;
    final question = _questions![_currentIndex];
    setState(() {
      _answers[question.id] = optionKey;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions!.length - 1) {
      setState(() => _currentIndex++);
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  void _finishExam() {
    final int unansweredCount = _questions!.length - _answers.length;
    if (unansweredCount > 0 && mounted) {
      showDialog(
        context: context,
        builder: (context) => _buildDialog(
          title: 'Preguntas sin responder',
          titleColor: NeuralTheme.of(context).warningAmber,
          content:
              'Tienes $unansweredCount pregunta${unansweredCount > 1 ? 's' : ''} sin responder. '
              'Si finalizas ahora, se marcarán como incorrectas y pasarán a tu Re Entrenamiento.\n\n'
              '¿Estás seguro de finalizar el simulador?',
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Volver al simulador',
                  style: TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _isFinished = true);
                if (_timerStarted) _timer.cancel();
                _showResultDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: NeuralTheme.of(context).pink,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Finalizar de todos modos'),
            ),
          ],
        ),
      );
    } else {
      setState(() => _isFinished = true);
      if (_timerStarted) _timer.cancel();
      _showResultDialog();
    }
  }

  Future<bool> _onWillPop() async {
    if (_isFinished) return true;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => _buildDialog(
        title: '¿Abandonar simulador?',
        titleColor: Colors.white,
        content: 'Si sales ahora perderás todo tu progreso en este simulacro.',
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:
                const Text('Cancelar', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: NeuralTheme.of(context).pink,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Abandonar'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _showResultDialog() {
    int correctCount = 0;
    int totalScore = 0;
    int maxPossibleScore = 0;

    for (final q in _questions!) {
      final ans = _answers[q.id];
      if (ans == q.correctAnswer) {
        correctCount++;
      } else {
        context.read<LocalStorageService>().addFailedPsicoQuestion(q.id);
      }
      totalScore += q.puntosOpciones[ans] ?? 0;
      maxPossibleScore += q.puntajeMaximo;
    }

    final double percentage =
        maxPossibleScore > 0 ? (totalScore / maxPossibleScore) : 0;
    final bool isApto = percentage >= 0.70;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final nt = NeuralTheme.of(context);
        final resultColor = isApto ? nt.successGreen : nt.pink;
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: nt.surfaceCard,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                  color: resultColor.withValues(alpha: 0.5), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: resultColor.withValues(alpha: 0.15),
                  blurRadius: 40,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icono animado
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: resultColor.withValues(alpha: 0.15),
                    border: Border.all(
                        color: resultColor.withValues(alpha: 0.4), width: 2),
                  ),
                  child: Icon(
                    isApto
                        ? Icons.military_tech_rounded
                        : Icons.refresh_rounded,
                    color: resultColor,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  isApto ? '¡LOGRADO, ASPIRANTE!' : 'EXAMEN NO SUPERADO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: resultColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    letterSpacing: 1.5,
                    fontFamily: 'Outfit',
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: resultColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: resultColor.withValues(alpha: 0.3), width: 1),
                  ),
                  child: Text(
                    isApto ? 'APTO' : 'INAPTO',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: resultColor,
                      letterSpacing: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildStatCard(
                  label: 'Respuestas Correctas',
                  value: '$correctCount / ${_questions!.length}',
                  icon: Icons.check_circle_outline_rounded,
                  color: nt.successGreen,
                ),
                const SizedBox(height: 8),
                _buildStatCard(
                  label: 'Puntaje Total',
                  value: '$totalScore / $maxPossibleScore',
                  icon: Icons.stars_rounded,
                  color: nt.warningAmber,
                ),
                const SizedBox(height: 8),
                _buildStatCard(
                  label: 'Rendimiento',
                  value: '${(percentage * 100).toStringAsFixed(1)}%',
                  icon: Icons.analytics_rounded,
                  color: nt.blueGoogle,
                ),
                const SizedBox(height: 20),
                // Barra de progreso visual
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: percentage,
                    backgroundColor: Colors.white10,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(resultColor),
                    minHeight: 10,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isApto
                      ? 'Tu perfil psicológico y conocimientos cumplen con los estándares.'
                      : 'Sigue preparándote. Revisa tus debilidades en Re Entrenamiento.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white60, fontSize: 13),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.pop();
                    },
                    icon: const Icon(Icons.home_rounded),
                    label: const Text('VOLVER AL INICIO',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: nt.blueGoogle,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.white60, fontSize: 13)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildDialog({
    required String title,
    required Color titleColor,
    required String content,
    required List<Widget> actions,
  }) {
    return AlertDialog(
      backgroundColor: NeuralTheme.of(context).surfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
            color: NeuralTheme.of(context).blueGoogle.withValues(alpha: 0.3)),
      ),
      title:
          Text(title, style: TextStyle(color: titleColor, fontWeight: FontWeight.bold)),
      content:
          Text(content, style: const TextStyle(color: Colors.white70)),
      actions: actions,
    );
  }

  void _showGridBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: NeuralTheme.of(context).background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(
              color: NeuralTheme.of(context).blueGoogle.withValues(alpha: 0.3)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Text(
              'Navegación Rápida',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit'),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendDot(NeuralTheme.of(context).blueGoogle,
                    'Respondida'),
                const SizedBox(width: 16),
                _buildLegendDot(Colors.white24, 'Sin responder'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _questions!.length,
                itemBuilder: (context, index) {
                  final isAnswered =
                      _answers.containsKey(_questions![index].id);
                  final isCurrent = index == _currentIndex;
                  return InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _currentIndex = index);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? NeuralTheme.of(context).blueGoogle
                            : (isAnswered
                                ? NeuralTheme.of(context)
                                    .blueGoogle
                                    .withValues(alpha: 0.25)
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isCurrent
                              ? NeuralTheme.of(context).blueGoogle
                              : (isAnswered
                                  ? NeuralTheme.of(context)
                                      .blueGoogle
                                      .withValues(alpha: 0.5)
                                  : Colors.white24),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: isCurrent || isAnswered
                              ? Colors.white
                              : Colors.white60,
                          fontWeight: isCurrent
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(color: Colors.white60, fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions == null) {
      return Scaffold(
        backgroundColor: NeuralTheme.of(context).background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                  color: NeuralTheme.of(context).blueGoogle),
              const SizedBox(height: 16),
              const Text('Preparando simulacro...',
                  style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      );
    }

    final question = _questions![_currentIndex];
    final bool isLast = _currentIndex == _questions!.length - 1;
    final nt = NeuralTheme.of(context);
    final int answeredCount = _answers.length;
    final int totalCount = _questions!.length;

    return PopScope(
      canPop: _isFinished,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        if (await _onWillPop() && mounted) {
          if (context.mounted) context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: nt.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white60),
            onPressed: () async {
              final shouldPop = await _onWillPop();
              if (shouldPop && context.mounted) context.pop();
            },
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: _timerColor().withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: _timerColor().withValues(alpha: 0.4), width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.timer_rounded,
                        color: _timerColor(), size: 16),
                    const SizedBox(width: 6),
                    Text(
                      _formatTime(_secondsRemaining),
                      style: TextStyle(
                        color: _timerColor(),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon:
                  Icon(Icons.grid_view_rounded, color: nt.blueGoogle),
              onPressed: _showGridBottomSheet,
              tooltip: 'Navegación rápida',
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Barra de progreso con estadísticas
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pregunta ${_currentIndex + 1} de $totalCount',
                          style: TextStyle(
                            color: nt.blueGoogle,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.check_circle_rounded,
                                color: nt.successGreen, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              '$answeredCount respondidas',
                              style: const TextStyle(
                                  color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (_currentIndex + 1) / totalCount,
                        backgroundColor: Colors.white10,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(nt.blueGoogle),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ),
              ),

              // Contenido principal
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 8),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Etiqueta de dimensión
                          if (question.dimension.isNotEmpty &&
                              question.dimension != 'General')
                            Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color:
                                    nt.purple.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: nt.purple.withValues(alpha: 0.3)),
                              ),
                              child: Text(
                                question.displayDimension.toUpperCase(),
                                style: TextStyle(
                                  color: nt.purple,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),

                          // Pregunta
                          StaticGlassContainer(
                            padding: const EdgeInsets.all(24),
                            borderRadius: BorderRadius.circular(20),
                            child: Text(
                              question.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Opciones (renderizadas dinámicamente)
                          ...question.options.entries
                              .toList()
                              .asMap()
                              .entries
                              .map((indexedEntry) {
                            final idx = indexedEntry.key;
                            final entry = indexedEntry.value;
                            final labels = ['A', 'B', 'C', 'D', 'E'];
                            final label = idx < labels.length
                                ? labels[idx]
                                : entry.key;
                            final isSelected =
                                _answers[question.id] == entry.key;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: InkWell(
                                onTap: () =>
                                    _onOptionSelected(entry.key),
                                borderRadius: BorderRadius.circular(16),
                                child: AnimatedContainer(
                                  duration:
                                      const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? nt.blueGoogle
                                            .withValues(alpha: 0.15)
                                        : nt.surfaceCard,
                                    borderRadius:
                                        BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected
                                          ? nt.blueGoogle
                                          : Colors.white10,
                                      width: isSelected ? 1.5 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isSelected
                                              ? nt.blueGoogle
                                              : Colors.white10,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          label,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.white54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Text(
                                          entry.value,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.white70,
                                            fontSize: 15,
                                            height: 1.3,
                                          ),
                                        ),
                                      ),
                                      if (isSelected)
                                        Icon(
                                          Icons.radio_button_checked_rounded,
                                          color: nt.blueGoogle,
                                          size: 20,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Barra de navegación inferior
              Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                decoration: BoxDecoration(
                  color: nt.surfaceCard,
                  border: const Border(top: BorderSide(color: Colors.white10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _currentIndex > 0
                        ? TextButton.icon(
                            onPressed: _previousQuestion,
                            icon: const Icon(Icons.arrow_back_rounded,
                                color: Colors.white60, size: 18),
                            label: const Text('Anterior',
                                style: TextStyle(color: Colors.white60)),
                          )
                        : const SizedBox(width: 100),
                    isLast
                        ? ElevatedButton.icon(
                            onPressed: _finishExam,
                            icon: const Icon(Icons.flag_rounded, size: 18),
                            label: const Text('FINALIZAR',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: nt.blueGoogle,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          )
                        : ElevatedButton.icon(
                            onPressed: _nextQuestion,
                            icon: const Icon(Icons.arrow_forward_rounded,
                                size: 18),
                            label: const Text('Siguiente'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white10,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

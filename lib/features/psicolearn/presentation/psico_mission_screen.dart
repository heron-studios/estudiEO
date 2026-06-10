import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/features/psicolearn/domain/models/psico_question.dart';
import 'package:learn/features/psicolearn/domain/services/psico_service.dart';
import 'package:learn/core/services/audio_service.dart';
import 'package:learn/core/services/local_storage_service.dart';

class PsicoMissionScreen extends StatefulWidget {
  const PsicoMissionScreen({super.key});

  @override
  State<PsicoMissionScreen> createState() => _PsicoMissionScreenState();
}

class _PsicoMissionScreenState extends State<PsicoMissionScreen>
    with TickerProviderStateMixin {
  final PsicoService _service = PsicoService();
  List<PsicoQuestion>? _questions;
  int _currentIndex = 0;
  final Map<int, String> _answers = {};
  bool _isFinished = false;

  bool _showingFeedback = false;
  bool _selectedIsCorrect = false;
  String? _selectedOptionKey;

  // Seguimiento para Combos y Diagnóstico
  int _comboCount = 0;
  final Map<String, int> _dimensionScores = {};
  final Map<String, int> _dimensionMax = {};

  late AnimationController _comboController;
  late Animation<double> _comboAnimation;
  late AnimationController _feedbackController;
  late Animation<double> _feedbackAnimation;

  @override
  void initState() {
    super.initState();
    _loadQuestions();

    _comboController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _comboAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _comboController, curve: Curves.elasticOut),
    );

    _feedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _feedbackAnimation = CurvedAnimation(
      parent: _feedbackController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _comboController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _loadQuestions() async {
    final storage = context.read<LocalStorageService>();
    final savedIds = storage.getPsicoDailyMissionIds();
    final savedIndex = storage.getPsicoMissionCurrentIndex();

    List<PsicoQuestion> questions;
    if (savedIds != null && savedIds.isNotEmpty) {
      questions = await _service.getQuestionsByIds(savedIds);
      if (questions.isEmpty) {
        questions = await _service.loadDailyMission(20);
        storage.savePsicoDailyMissionIds(
            questions.map((q) => q.id).toList());
      }
    } else {
      questions = await _service.loadDailyMission(20);
      storage.savePsicoDailyMissionIds(
          questions.map((q) => q.id).toList());
    }

    if (!mounted) return;

    setState(() {
      _questions = questions;
      if (savedIndex < questions.length) {
        _currentIndex = savedIndex;
      }
    });
  }

  void _onOptionSelected(String optionKey) {
    if (_questions == null || _showingFeedback) return;

    final question = _questions![_currentIndex];
    _answers[question.id] = optionKey;
    final isCorrect = optionKey == question.correctAnswer;

    final dim = question.dimension;
    final int score = question.puntosOpciones[optionKey] ??
        (isCorrect ? question.puntajeMaximo : 0);
    _dimensionScores[dim] = (_dimensionScores[dim] ?? 0) + score;
    _dimensionMax[dim] = (_dimensionMax[dim] ?? 0) + question.puntajeMaximo;

    if (isCorrect) {
      _comboCount++;
      context.read<AudioService>().playCorrectSound();
      if (_comboCount >= 3) {
        _comboController.forward(from: 0);
      }
    } else {
      _comboCount = 0;
      context.read<AudioService>().playIncorrectSound();
      context.read<LocalStorageService>().addFailedPsicoQuestion(question.id);
    }

    _feedbackController.forward(from: 0);

    setState(() {
      _selectedOptionKey = optionKey;
      _selectedIsCorrect = isCorrect;
      _showingFeedback = true;
    });

    if (isCorrect) {
      if (question.contextoCorrecto.isEmpty) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted && _showingFeedback && _selectedIsCorrect) {
            _nextQuestion();
          }
        });
      }
    }
  }

  void _nextQuestion() {
    if (_currentIndex < _questions!.length - 1) {
      _feedbackController.reset();
      setState(() {
        _currentIndex++;
        _showingFeedback = false;
        _selectedOptionKey = null;
      });
      context
          .read<LocalStorageService>()
          .savePsicoMissionCurrentIndex(_currentIndex);
    } else {
      context.read<LocalStorageService>().markPsicoMissionCompleted();
      context.read<LocalStorageService>().savePsicoMissionCurrentIndex(0);
      setState(() {
        _isFinished = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return NeuralBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.stars_rounded, color: Colors.amber, size: 18),
              SizedBox(width: 8),
              Text(
                'Misión Diaria',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit',
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildContent(nt),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(NeuralThemeData nt) {
    if (_questions == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: nt.blueGoogle),
            const SizedBox(height: 16),
            const Text('Preparando tu misión...',
                style: TextStyle(color: Colors.white70)),
          ],
        ),
      );
    }

    if (_isFinished) {
      return _buildEndScreen(nt);
    }

    final question = _questions![_currentIndex];
    final progress = (_currentIndex + 1) / _questions!.length;

    return Column(
      children: [
        // Barra de progreso
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(nt.blueGoogle),
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${_currentIndex + 1}/${_questions!.length}',
                  style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ],
            ),
          ],
        ),

        // Combo badge
        if (_comboCount >= 3) ...[
          const SizedBox(height: 12),
          ScaleTransition(
            scale: _comboAnimation,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFFFF6F00), Color(0xFFFF9100)]),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF6F00).withValues(alpha: 0.4),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.local_fire_department_rounded,
                      color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    '¡COMBO x$_comboCount!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 28),

        // Pregunta + opciones
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.04, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: SingleChildScrollView(
              key: ValueKey<int>(_currentIndex),
              child: Column(
                children: [
                  // Dimensión badge
                  if (question.dimension.isNotEmpty &&
                      question.dimension != 'General')
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: nt.purple.withValues(alpha: 0.15),
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
                    ),

                  // Texto de pregunta
                  Text(
                    question.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Opciones (dinámicas)
                  ...question.options.entries
                      .toList()
                      .asMap()
                      .entries
                      .map((indexedEntry) {
                    final idx = indexedEntry.key;
                    final entry = indexedEntry.value;
                    final labels = ['A', 'B', 'C', 'D', 'E'];
                    final label =
                        idx < labels.length ? labels[idx] : entry.key;
                    final isSelected = _selectedOptionKey == entry.key;
                    final isCorrectAnswer =
                        entry.key == question.correctAnswer;

                    Color borderColor = Colors.white.withValues(alpha: 0.12);
                    Color bgColor = Colors.white.withValues(alpha: 0.04);
                    Widget? trailingWidget;

                    if (_showingFeedback) {
                      if (isCorrectAnswer) {
                        borderColor = const Color(0xFF4ADE80);
                        bgColor = const Color(0xFF4ADE80).withValues(alpha: 0.08);
                        trailingWidget = const Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFF4ADE80),
                            size: 20);
                      } else if (isSelected) {
                        borderColor = const Color(0xFFEF4444);
                        bgColor = const Color(0xFFEF4444).withValues(alpha: 0.08);
                        trailingWidget = const Icon(Icons.cancel_rounded,
                            color: Color(0xFFEF4444), size: 20);
                      }
                    } else if (isSelected) {
                      borderColor = nt.blueGoogle;
                      bgColor = nt.blueGoogle.withValues(alpha: 0.1);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: HoverGlassCard(
                        onTap: _showingFeedback
                            ? null
                            : () => _onOptionSelected(entry.key),
                        hoverGradientBorder: !_showingFeedback,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 280),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 20),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: borderColor,
                              width: _showingFeedback &&
                                      (isCorrectAnswer || isSelected)
                                  ? 1.5
                                  : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _showingFeedback
                                      ? (isCorrectAnswer
                                          ? const Color(0xFF4ADE80)
                                              .withValues(alpha: 0.2)
                                          : (isSelected
                                              ? const Color(0xFFEF4444)
                                                  .withValues(alpha: 0.2)
                                              : Colors.white10))
                                      : (isSelected
                                          ? nt.blueGoogle.withValues(alpha: 0.2)
                                          : Colors.white10),
                                  border: Border.all(
                                    color: _showingFeedback
                                        ? (isCorrectAnswer
                                            ? const Color(0xFF4ADE80)
                                            : (isSelected
                                                ? const Color(0xFFEF4444)
                                                : Colors.transparent))
                                        : (isSelected
                                            ? nt.blueGoogle
                                            : Colors.transparent),
                                    width: 1,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  label,
                                  style: TextStyle(
                                    color: _showingFeedback &&
                                            (isCorrectAnswer || isSelected)
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
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              if (trailingWidget != null) ...[
                                const SizedBox(width: 8),
                                trailingWidget,
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),

        // Feedback panel (si se equivoca o si acertó y hay un contexto explicativo)
        if (_showingFeedback && (!_selectedIsCorrect || question.contextoCorrecto.isNotEmpty))
          FadeTransition(
            opacity: _feedbackAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(_feedbackAnimation),
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: StaticGlassContainer(
                  padding: const EdgeInsets.all(18),
                  borderRadius: BorderRadius.circular(20),
                  borderColor: (_selectedIsCorrect
                          ? const Color(0xFF4ADE80)
                          : const Color(0xFFEF4444))
                      .withValues(alpha: 0.4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: (_selectedIsCorrect
                                      ? const Color(0xFF4ADE80)
                                      : Colors.orangeAccent)
                                  .withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                                _selectedIsCorrect
                                    ? Icons.stars_rounded
                                    : Icons.psychology_alt_rounded,
                                color: _selectedIsCorrect
                                    ? const Color(0xFF4ADE80)
                                    : Colors.orangeAccent,
                                size: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedIsCorrect
                                      ? '¡Respuesta Correcta!'
                                      : 'Revisemos esta respuesta',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  question.displayDimension,
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      if (!_selectedIsCorrect) ...[
                        _buildFeedbackBlock(
                          title: 'Respuesta recomendada',
                          content: question.options[question.correctAnswer] ??
                              'N/A',
                          color: const Color(0xFF4ADE80),
                          icon: Icons.task_alt_rounded,
                        ),
                        const SizedBox(height: 10),
                      ],
                      _buildFeedbackBlock(
                        title: _selectedIsCorrect
                            ? 'Explicación del acierto'
                            : 'Orientación psicológica',
                        content: _selectedIsCorrect
                            ? question.contextoCorrecto
                            : (question.contextoIncorrecto.isNotEmpty
                                ? question.contextoIncorrecto
                                : (question.hint.isNotEmpty
                                    ? question.hint
                                    : 'En este tipo de preguntas, suele haber una opción que refleja mayor equilibrio o resiliencia.')),
                        color: _selectedIsCorrect
                            ? const Color(0xFF4ADE80)
                            : Colors.orangeAccent,
                        icon: Icons.lightbulb_outline_rounded,
                      ),

                      if (question.esEscalaMentira) ...[
                        const SizedBox(height: 10),
                        _buildFeedbackBlock(
                          title: 'Escala de Sinceridad',
                          content:
                              'Evita responder como si fueras perfecto. El perfil mejora cuando refleja autocontrol real y honestidad.',
                          color: const Color(0xFFFFC857),
                          icon: Icons.warning_amber_rounded,
                        ),
                      ],

                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _nextQuestion,
                        icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                        label: const Text('Continuar',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: nt.blueGoogle,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFeedbackBlock({
    required String title,
    required String content,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: color, width: 3),
          top: BorderSide(color: color.withValues(alpha: 0.15)),
          bottom: BorderSide(color: color.withValues(alpha: 0.15)),
          right: BorderSide(color: color.withValues(alpha: 0.15)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEndScreen(NeuralThemeData nt) {
    // Calcular la dimensión con mejor puntaje
    String topDim = 'Sin datos';
    double topScore = -1;
    if (_dimensionScores.isNotEmpty) {
      _dimensionScores.forEach((key, val) {
        final maxVal = _dimensionMax[key] ?? 1;
        double pct = val / (maxVal == 0 ? 1 : maxVal);
        if (pct > topScore) {
          topScore = pct;
          topDim = key;
        }
      });
    }

    // Calcular puntaje general
    int totalScore = _dimensionScores.values.fold(0, (a, b) => a + b);
    int totalMax = _dimensionMax.values.fold(0, (a, b) => a + b);
    double overallPct = totalMax > 0 ? totalScore / totalMax : 0;

    Color resultColor = overallPct >= 0.7
        ? nt.successGreen
        : (overallPct >= 0.5 ? nt.warningAmber : nt.pink);

    return SingleChildScrollView(
      child: Column(
        children: [
          StaticGlassContainer(
            padding: const EdgeInsets.all(28),
            borderRadius: BorderRadius.circular(28),
            borderColor: resultColor.withValues(alpha: 0.4),
            child: Column(
              children: [
                // Ícono de resultado
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: resultColor.withValues(alpha: 0.15),
                    border: Border.all(
                        color: resultColor.withValues(alpha: 0.4), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: resultColor.withValues(alpha: 0.2),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    overallPct >= 0.7
                        ? Icons.military_tech_rounded
                        : Icons.analytics_rounded,
                    color: resultColor,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Diagnóstico de Misión',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Outfit',
                  ),
                ),
                const SizedBox(height: 8),

                // Puntaje general
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: resultColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: resultColor.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.stars_rounded, color: resultColor, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        '${(overallPct * 100).toInt()}% de rendimiento',
                        style: TextStyle(
                          color: resultColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Dimensión destacada: $topDim',
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Progreso general
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: overallPct,
                    minHeight: 10,
                    backgroundColor: Colors.white10,
                    valueColor: AlwaysStoppedAnimation<Color>(resultColor),
                  ),
                ),
                const SizedBox(height: 24),

                // Barras por dimensión
                if (_dimensionScores.isNotEmpty) ...[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'DESGLOSE POR DIMENSIÓN',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ..._dimensionScores.entries.map((e) {
                    final maxP = _dimensionMax[e.key] ?? 1;
                    final valP = e.value;
                    final pct = maxP > 0 ? valP / maxP : 0.0;
                    final dimColor = pct >= 0.7
                        ? nt.successGreen
                        : (pct >= 0.5 ? nt.warningAmber : nt.pink);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  e.key,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${(pct * 100).toInt()}%',
                                style: TextStyle(
                                    color: dimColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: pct,
                              minHeight: 8,
                              backgroundColor: Colors.white12,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(dimColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.check_rounded),
                    label: const Text('COMPLETAR MISIÓN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, letterSpacing: 0.5)),
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
        ],
      ),
    );
  }
}

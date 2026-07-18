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

class SilogismosScreen extends StatefulWidget {
  const SilogismosScreen({super.key});

  @override
  State<SilogismosScreen> createState() => _SilogismosScreenState();
}

class _SilogismosScreenState extends State<SilogismosScreen>
    with TickerProviderStateMixin {
  final PsicoService _service = PsicoService();
  List<PsicoQuestion>? _questions;
  int _currentIndex = 0;
  final Map<int, String> _answers = {};
  bool _isFinished = false;

  bool _showingFeedback = false;
  bool _selectedIsCorrect = false;
  String? _selectedOptionKey;

  int _correctStreak = 0;
  int _totalCorrect = 0;
  final Map<String, int> _dimensionScores = {};
  final Map<String, int> _dimensionMax = {};

  late AnimationController _streakController;
  late Animation<double> _streakScale;
  late AnimationController _questionController;

  @override
  void initState() {
    super.initState();

    _streakController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _streakScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _streakController, curve: Curves.elasticOut),
    );

    _questionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _questionController.forward();

    _loadQuestions();
  }

  @override
  void dispose() {
    _streakController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  Future<void> _loadQuestions() async {
    final questions = await _service.loadSilogismos();
    if (!mounted) return;
    setState(() {
      _questions = questions;
    });
  }

  void _onOptionSelected(String optionKey) {
    if (_questions == null || _showingFeedback) return;

    final question = _questions![_currentIndex];
    _answers[question.id] = optionKey;
    final isCorrect = optionKey == question.correctAnswer;

    final dim = question.dimension;
    final int score =
        question.puntosOpciones[optionKey] ??
        (isCorrect ? question.puntajeMaximo : 0);
    _dimensionScores[dim] = (_dimensionScores[dim] ?? 0) + score;
    _dimensionMax[dim] = (_dimensionMax[dim] ?? 0) + question.puntajeMaximo;

    if (isCorrect) {
      _correctStreak++;
      _totalCorrect++;
      context.read<AudioService>().playCorrectSound();
      _streakController.forward(from: 0);
    } else {
      _correctStreak = 0;
      context.read<AudioService>().playIncorrectSound();
      context.read<LocalStorageService>().addFailedPsicoQuestion(question.id);
    }

    setState(() {
      _selectedOptionKey = optionKey;
      _selectedIsCorrect = isCorrect;
      _showingFeedback = true;
    });

    if (isCorrect) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) _nextQuestion();
      });
    }
  }

  void _nextQuestion() {
    if (_currentIndex < _questions!.length - 1) {
      _questionController.reset();
      setState(() {
        _currentIndex++;
        _showingFeedback = false;
        _selectedOptionKey = null;
      });
      _questionController.forward();
    } else {
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
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF14B8A6).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.account_tree_rounded,
                  color: Color(0xFF14B8A6),
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Razonamiento',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit',
                ),
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            if (_questions != null)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Text(
                    '${_currentIndex + 1}/${_questions!.length}',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
          ],
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: _buildContent(nt),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(NeuralThemeData nt) {
    if (_questions == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Color(0xFF14B8A6)),
            SizedBox(height: 16),
            Text(
              'Cargando silogismos...',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      );
    }

    if (_questions!.isEmpty) {
      return Center(
        child: StaticGlassContainer(
          padding: const EdgeInsets.all(32),
          borderRadius: BorderRadius.circular(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: Colors.white54,
                size: 48,
              ),
              const SizedBox(height: 16),
              const Text(
                'No hay silogismos disponibles',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'El banco de preguntas de silogismos está vacío.',
                style: TextStyle(color: Colors.white54),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Volver'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF14B8A6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_isFinished) return _buildEndScreen(nt);

    final question = _questions![_currentIndex];
    final progress = (_currentIndex + 1) / _questions!.length;

    return Column(
      children: [
        // Barra de progreso con streak
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF14B8A6),
                  ),
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Streak badge
            if (_correctStreak >= 2)
              ScaleTransition(
                scale: _streakScale,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF14B8A6), Color(0xFF0EA5E9)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.bolt_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                      Text(
                        ' x$_correctStreak',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),

        // Contenido de pregunta
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.04, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: SingleChildScrollView(
              key: ValueKey<int>(_currentIndex),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header de lógica
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF14B8A6).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF14B8A6).withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.lightbulb_outline_rounded,
                          color: Color(0xFF14B8A6),
                          size: 14,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'SILOGISMO · RAZONAMIENTO LÓGICO',
                          style: TextStyle(
                            color: Color(0xFF14B8A6),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tarjeta de premisas / enunciado
                  StaticGlassContainer(
                    padding: const EdgeInsets.all(22),
                    borderRadius: BorderRadius.circular(20),
                    borderColor: const Color(
                      0xFF14B8A6,
                    ).withValues(alpha: 0.25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF14B8A6,
                                ).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.format_quote_rounded,
                                color: Color(0xFF14B8A6),
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Enunciado',
                              style: TextStyle(
                                color: Color(0xFF14B8A6),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          question.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Conclusión label
                  const Text(
                    'CONCLUSIÓN CORRECTA:',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Opciones
                  ...question.options.entries.toList().asMap().entries.map((
                    indexedEntry,
                  ) {
                    final idx = indexedEntry.key;
                    final entry = indexedEntry.value;
                    final labels = ['A', 'B', 'C', 'D', 'E'];
                    final label = idx < labels.length ? labels[idx] : entry.key;
                    final isSelected = _selectedOptionKey == entry.key;
                    final isCorrectAnswer = entry.key == question.correctAnswer;

                    Color borderColor = Colors.white.withValues(alpha: 0.1);
                    Color bgColor = Colors.white.withValues(alpha: 0.04);
                    Color circleColor = Colors.white10;

                    if (_showingFeedback) {
                      if (isCorrectAnswer) {
                        borderColor = const Color(0xFF4ADE80);
                        bgColor = const Color(
                          0xFF4ADE80,
                        ).withValues(alpha: 0.08);
                        circleColor = const Color(0xFF4ADE80);
                      } else if (isSelected) {
                        borderColor = const Color(0xFFEF4444);
                        bgColor = const Color(
                          0xFFEF4444,
                        ).withValues(alpha: 0.08);
                        circleColor = const Color(0xFFEF4444);
                      }
                    } else if (isSelected) {
                      borderColor = const Color(0xFF14B8A6);
                      bgColor = const Color(0xFF14B8A6).withValues(alpha: 0.1);
                      circleColor = const Color(0xFF14B8A6);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: HoverGlassCard(
                        onTap: _showingFeedback
                            ? null
                            : () => _onOptionSelected(entry.key),
                        hoverGradientBorder: !_showingFeedback,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 260),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 18,
                          ),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: borderColor,
                              width:
                                  _showingFeedback &&
                                      (isCorrectAnswer || isSelected)
                                  ? 1.5
                                  : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 260),
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: circleColor.withValues(alpha: 0.2),
                                  border: Border.all(
                                    color: circleColor,
                                    width: 1.5,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  label,
                                  style: TextStyle(
                                    color:
                                        _showingFeedback &&
                                            (isCorrectAnswer || isSelected)
                                        ? Colors.white
                                        : (isSelected
                                              ? Colors.white
                                              : Colors.white54),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  entry.value,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              if (_showingFeedback && isCorrectAnswer)
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: Color(0xFF4ADE80),
                                  size: 20,
                                ),
                              if (_showingFeedback &&
                                  isSelected &&
                                  !isCorrectAnswer)
                                const Icon(
                                  Icons.cancel_rounded,
                                  color: Color(0xFFEF4444),
                                  size: 20,
                                ),
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

        // Panel de feedback si se equivoca
        if (_showingFeedback && !_selectedIsCorrect)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: StaticGlassContainer(
              padding: const EdgeInsets.all(16),
              borderRadius: BorderRadius.circular(18),
              borderColor: const Color(0xFFEF4444).withValues(alpha: 0.4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF14B8A6,
                          ).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          color: Color(0xFF14B8A6),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Analicemos el silogismo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildFeedbackBlock(
                    title: 'Conclusión correcta',
                    content:
                        _questions![_currentIndex]
                            .options[_questions![_currentIndex]
                            .correctAnswer] ??
                        'N/A',
                    color: const Color(0xFF4ADE80),
                    icon: Icons.task_alt_rounded,
                  ),
                  if (_questions![_currentIndex].hint.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    _buildFeedbackBlock(
                      title: 'Explicación lógica',
                      content: _questions![_currentIndex].hint,
                      color: const Color(0xFF14B8A6),
                      icon: Icons.lightbulb_outline_rounded,
                    ),
                  ],
                  const SizedBox(height: 14),
                  ElevatedButton.icon(
                    onPressed: _nextQuestion,
                    icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                    label: const Text(
                      'Continuar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF14B8A6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
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
    final totalQuestions = _questions!.length;
    final accuracy = totalQuestions > 0 ? _totalCorrect / totalQuestions : 0.0;

    Color resultColor = accuracy >= 0.8
        ? const Color(0xFF14B8A6)
        : (accuracy >= 0.6 ? nt.warningAmber : nt.pink);

    String resultLabel = accuracy >= 0.8
        ? '¡Excelente razonador!'
        : (accuracy >= 0.6 ? 'Buen progreso' : 'Sigue practicando');

    return SingleChildScrollView(
      child: StaticGlassContainer(
        padding: const EdgeInsets.all(28),
        borderRadius: BorderRadius.circular(28),
        borderColor: resultColor.withValues(alpha: 0.4),
        child: Column(
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: resultColor.withValues(alpha: 0.12),
                border: Border.all(
                  color: resultColor.withValues(alpha: 0.4),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: resultColor.withValues(alpha: 0.2),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.account_tree_rounded,
                color: resultColor,
                size: 44,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              resultLabel,
              style: TextStyle(
                color: resultColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Outfit',
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Sesión de Razonamiento Completada',
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),
            const SizedBox(height: 24),

            // Stats
            Row(
              children: [
                Expanded(
                  child: _buildEndStatBlock(
                    value: '$_totalCorrect',
                    label: 'Correctas',
                    color: const Color(0xFF4ADE80),
                    icon: Icons.check_circle_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildEndStatBlock(
                    value: '${totalQuestions - _totalCorrect}',
                    label: 'Incorrectas',
                    color: nt.pink,
                    icon: Icons.cancel_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildEndStatBlock(
                    value: '${(accuracy * 100).toInt()}%',
                    label: 'Precisión',
                    color: resultColor,
                    icon: Icons.analytics_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Barra de precisión
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: accuracy,
                minHeight: 10,
                backgroundColor: Colors.white10,
                valueColor: AlwaysStoppedAnimation<Color>(resultColor),
              ),
            ),
            const SizedBox(height: 24),

            // Desglose por dimensión
            if (_dimensionScores.isNotEmpty) ...[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'DESGLOSE',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ..._dimensionScores.entries.map((e) {
                final maxP = _dimensionMax[e.key] ?? 1;
                final pct = maxP > 0 ? e.value / maxP : 0.0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.key,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '${(pct * 100).toInt()}%',
                            style: TextStyle(
                              color: resultColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: pct,
                          minHeight: 7,
                          backgroundColor: Colors.white12,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF14B8A6),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 10),
            ],

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text(
                  'VOLVER',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF14B8A6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEndStatBlock({
    required String value,
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

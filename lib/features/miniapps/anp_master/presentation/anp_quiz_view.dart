import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:confetti/confetti.dart';
import '../data/anp_repository.dart';
import '../data/anp_model.dart';
import '../domain/spaced_repetition_engine.dart';
import 'dart:async';
import 'dart:math';

enum _Difficulty { easy, normal, expert }

enum _QuestionType { region, useType, category, fauna, established }

class ANPQuizView extends StatefulWidget {
  const ANPQuizView({super.key});

  @override
  State<ANPQuizView> createState() => _ANPQuizViewState();
}

class _ANPQuizViewState extends State<ANPQuizView>
    with TickerProviderStateMixin {
  // State
  bool _gameStarted = false;
  _Difficulty _selectedDifficulty = _Difficulty.normal;

  final SpacedRepetitionEngine _engine = SpacedRepetitionEngine();
  final List<ANPModel> _allAnps = ANPRepository.getAllANPs();

  late List<String> _dueItems;
  int _currentIndex = 0;

  String? _selectedAnswer;
  bool _answered = false;

  // Game rules
  int _lives = 3;
  int _score = 0;
  int _streak = 0;
  int _multiplier = 1;

  // Power-up: 50/50
  bool _fiftyFiftyUsed = false;
  Set<String> _eliminatedOptions = {};

  // Timer
  late AnimationController _timerController;

  // Stats for end screen
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  Map<_QuestionType, int> _correctByType = {};
  Map<_QuestionType, int> _totalByType = {};

  // Current question data
  late List<String> _options;
  late String _correctAnswer;
  late _QuestionType _currentQuestionType;
  late ANPModel _currentANP;

  late ConfettiController _confettiController;

  // Answer animation
  late AnimationController _answerFeedbackController;
  late Animation<double> _answerScaleAnim;

  int get _timerSeconds {
    switch (_selectedDifficulty) {
      case _Difficulty.easy:
        return 25;
      case _Difficulty.normal:
        return 15;
      case _Difficulty.expert:
        return 10;
    }
  }

  int get _initialLives {
    switch (_selectedDifficulty) {
      case _Difficulty.easy:
        return 5;
      case _Difficulty.normal:
        return 3;
      case _Difficulty.expert:
        return 2;
    }
  }

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));

    _timerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    );
    _timerController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _handleTimeOut();
      }
    });

    _answerFeedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _answerScaleAnim = TweenSequence([
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 1.04), weight: 50),
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.04, end: 1.0), weight: 50),
    ]).animate(_answerFeedbackController);

    _engine.initItems(_allAnps.map((e) => e.id).toList());
  }

  @override
  void dispose() {
    _timerController.dispose();
    _confettiController.dispose();
    _answerFeedbackController.dispose();
    super.dispose();
  }

  void _startGame() {
    _lives = _initialLives;
    _score = 0;
    _streak = 0;
    _multiplier = 1;
    _fiftyFiftyUsed = false;
    _correctAnswers = 0;
    _wrongAnswers = 0;
    _correctByType = {};
    _totalByType = {};

    _timerController.duration = Duration(seconds: _timerSeconds);

    _dueItems = _engine.getDueItems(10);
    if (_dueItems.length < 5) {
      _dueItems = _allAnps.map((e) => e.id).toList()..shuffle();
      _dueItems = _dueItems.take(8).toList();
    }

    setState(() {
      _gameStarted = true;
      _currentIndex = 0;
      _eliminatedOptions = {};
    });
    _generateQuestion(_dueItems[0]);
  }

  List<_QuestionType> get _availableTypes {
    if (_selectedDifficulty == _Difficulty.easy) {
      return [
        _QuestionType.useType,
        _QuestionType.category,
        _QuestionType.region
      ];
    }
    if (_selectedDifficulty == _Difficulty.expert) {
      return _QuestionType.values;
    }
    return [
      _QuestionType.region,
      _QuestionType.useType,
      _QuestionType.category,
      _QuestionType.fauna,
    ];
  }

  void _generateQuestion(String anpId) {
    _currentANP = _allAnps.firstWhere((e) => e.id == anpId);
    final random = Random();
    _currentQuestionType =
        _availableTypes[random.nextInt(_availableTypes.length)];
    _options = [];
    _selectedAnswer = null;
    _answered = false;
    _eliminatedOptions = {};

    switch (_currentQuestionType) {
      case _QuestionType.region:
        _correctAnswer = _currentANP.regions.join(', ');
        final otherRegions = _allAnps
            .where((e) => e.id != _currentANP.id)
            .map((e) => e.regions.join(', '))
            .toSet()
            .toList()
          ..shuffle();
        _options.add(_correctAnswer);
        _options.addAll(otherRegions.take(3));
        break;
      case _QuestionType.useType:
        _correctAnswer = _currentANP.useType;
        _options = [
          'Directo (Tangible/Sostenible)',
          'Indirecto (Intangible)',
        ];
        break;
      case _QuestionType.category:
        _correctAnswer = _currentANP.category;
        final categories = _allAnps
            .map((e) => e.category)
            .toSet()
            .toList()
          ..remove(_correctAnswer)
          ..shuffle();
        _options.add(_correctAnswer);
        _options.addAll(categories.take(3));
        break;
      case _QuestionType.fauna:
        _correctAnswer = _currentANP.keyFauna.first;
        final otherFauna = _allAnps
            .where((e) => e.id != _currentANP.id)
            .expand((e) => e.keyFauna)
            .toSet()
            .toList()
          ..shuffle();
        _options.add(_correctAnswer);
        _options.addAll(otherFauna.take(3));
        break;
      case _QuestionType.established:
        _correctAnswer = _currentANP.establishedYear.toString();
        final otherYears = _allAnps
            .where((e) => e.id != _currentANP.id)
            .map((e) => e.establishedYear.toString())
            .toSet()
            .toList()
          ..shuffle();
        _options.add(_correctAnswer);
        _options.addAll(otherYears.take(3));
        break;
    }

    _options = _options.toSet().toList()..shuffle();

    _totalByType[_currentQuestionType] =
        (_totalByType[_currentQuestionType] ?? 0) + 1;

    _timerController.duration = Duration(seconds: _timerSeconds);
    _timerController.reset();
    _timerController.forward();
  }

  void _useFiftyFifty() {
    if (_fiftyFiftyUsed || _answered) return;
    final wrongOptions = _options.where((o) => o != _correctAnswer).toList()
      ..shuffle();
    setState(() {
      _fiftyFiftyUsed = true;
      _eliminatedOptions = {wrongOptions[0], wrongOptions[1]};
    });
  }

  void _submitAnswer(String answer) {
    if (_answered || _eliminatedOptions.contains(answer)) return;
    _timerController.stop();
    _answerFeedbackController.forward(from: 0);

    setState(() {
      _selectedAnswer = answer;
      _answered = true;
      final isCorrect = answer == _correctAnswer;

      if (isCorrect) {
        _streak++;
        _multiplier = _streak >= 3 ? 2 : 1;
        final timeBonus =
            ((1.0 - _timerController.value) * 10).round();
        _score += (10 + timeBonus) * _multiplier;
        _engine.processAnswer(_dueItems[_currentIndex], 5);
        _correctAnswers++;
        _correctByType[_currentQuestionType] =
            (_correctByType[_currentQuestionType] ?? 0) + 1;
      } else {
        _streak = 0;
        _multiplier = 1;
        _lives--;
        _engine.processAnswer(_dueItems[_currentIndex], 2);
        _wrongAnswers++;
        if (_lives <= 0) {
          Future.delayed(const Duration(milliseconds: 1600), () {
            if (mounted) _showResultsScreen(success: false);
          });
        }
      }
    });
  }

  void _handleTimeOut() {
    if (_answered) return;
    setState(() {
      _answered = true;
      _streak = 0;
      _multiplier = 1;
      _lives--;
      _engine.processAnswer(_dueItems[_currentIndex], 1);
      _wrongAnswers++;
      if (_lives <= 0) {
        _showResultsScreen(success: false);
      }
    });
  }

  void _nextQuestion() {
    if (_lives <= 0) return;
    setState(() {
      if (_currentIndex < _dueItems.length - 1) {
        _currentIndex++;
        _generateQuestion(_dueItems[_currentIndex]);
      } else {
        _confettiController.play();
        _showResultsScreen(success: true);
      }
    });
  }

  void _showResultsScreen({required bool success}) {
    _timerController.stop();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final nt = NeuralTheme.of(context);
        return AlertDialog(
          backgroundColor: nt.surfaceCard,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28)),
          contentPadding: const EdgeInsets.all(24),
          title: Row(
            children: [
              Text(
                success ? '🏆 ' : '💔 ',
                style: const TextStyle(fontSize: 24),
              ),
              Expanded(
                child: Text(
                  success
                      ? '¡Desafío Completado!'
                      : '¡Fin de la Partida!',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Score highlight
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _resultStat('Puntos', '$_score', Colors.greenAccent),
                    _resultStat(
                        'Correctas', '$_correctAnswers', nt.successGreen),
                    _resultStat('Errores', '$_wrongAnswers', nt.pink),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // By type breakdown
              ..._totalByType.entries.map((entry) {
                final correct = _correctByType[entry.key] ?? 0;
                final total = entry.value;
                final pct =
                    total > 0 ? (correct / total * 100).round() : 0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        _typeLabel(entry.key),
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                      const Spacer(),
                      Text(
                        '$correct/$total ($pct%)',
                        style: TextStyle(
                            color: pct >= 70
                                ? Colors.greenAccent
                                : nt.pink,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                context.pop();
              },
              child: const Text('Salir',
                  style: TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              onPressed: () {
                context.pop();
                setState(() => _gameStarted = false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: nt.blueGoogle,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Jugar de Nuevo',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Widget _resultStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                color: color,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        Text(label,
            style: const TextStyle(
                color: Colors.white54, fontSize: 11)),
      ],
    );
  }

  String _typeLabel(_QuestionType type) {
    switch (type) {
      case _QuestionType.region:
        return 'Regiones';
      case _QuestionType.useType:
        return 'Tipo de Uso';
      case _QuestionType.category:
        return 'Categoría';
      case _QuestionType.fauna:
        return 'Fauna Clave';
      case _QuestionType.established:
        return 'Año de Establecimiento';
    }
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    if (!_gameStarted) {
      return _buildStartScreen(nt);
    }

    return Scaffold(
      backgroundColor: nt.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Desafío ${_currentIndex + 1}/${_dueItems.length}',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: NeuralBackgroundWrapper(
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHUDRow(nt),
                    const SizedBox(height: 12),
                    // Timer row with 50/50
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        // 50/50 power-up
                        GestureDetector(
                          onTap: _fiftyFiftyUsed || _answered
                              ? null
                              : _useFiftyFifty,
                          child: AnimatedContainer(
                            duration:
                                const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: _fiftyFiftyUsed
                                  ? Colors.white
                                      .withValues(alpha: 0.04)
                                  : nt.warningAmber
                                      .withValues(alpha: 0.15),
                              borderRadius:
                                  BorderRadius.circular(12),
                              border: Border.all(
                                color: _fiftyFiftyUsed
                                    ? Colors.white12
                                    : nt.warningAmber
                                        .withValues(alpha: 0.4),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.flash_on_rounded,
                                  color: _fiftyFiftyUsed
                                      ? Colors.white24
                                      : nt.warningAmber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '50/50',
                                  style: TextStyle(
                                    color: _fiftyFiftyUsed
                                        ? Colors.white24
                                        : nt.warningAmber,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Circular timer
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedBuilder(
                              animation: _timerController,
                              builder: (context, child) {
                                final value =
                                    1.0 - _timerController.value;
                                Color ringColor =
                                    Colors.greenAccent;
                                if (value < 0.3) {
                                  ringColor = Colors.redAccent;
                                } else if (value < 0.6) {
                                  ringColor = Colors.orangeAccent;
                                }
                                return SizedBox(
                                  width: 52,
                                  height: 52,
                                  child: CircularProgressIndicator(
                                    value: value,
                                    strokeWidth: 5,
                                    color: ringColor,
                                    backgroundColor:
                                        Colors.white10,
                                  ),
                                );
                              },
                            ),
                            AnimatedBuilder(
                              animation: _timerController,
                              builder: (context, child) {
                                final secs = (_timerSeconds *
                                        (1.0 -
                                            _timerController
                                                .value))
                                    .ceil();
                                return Text(
                                  '$secs',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        // Multiplier badge
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: _multiplier > 1
                                ? nt.pink.withValues(alpha: 0.2)
                                : Colors.white
                                    .withValues(alpha: 0.04),
                            borderRadius:
                                BorderRadius.circular(12),
                            border: Border.all(
                              color: _multiplier > 1
                                  ? nt.pink
                                      .withValues(alpha: 0.5)
                                  : Colors.white12,
                            ),
                          ),
                          child: Text(
                            'x$_multiplier',
                            style: TextStyle(
                              color: _multiplier > 1
                                  ? nt.pink
                                  : Colors.white38,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Question panel
                    StaticGlassContainer(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            _getQuestionTitleText(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: nt.cyan,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _currentANP.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Options list
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          ..._options
                              .where((o) =>
                                  !_eliminatedOptions.contains(o))
                              .map((option) =>
                                  _buildOptionCard(nt, option)),
                          if (_answered && _lives > 0) ...[
                            const SizedBox(height: 10),
                            _buildExplanationCard(nt),
                            const SizedBox(height: 14),
                            ScaleTransition(
                              scale: _answerScaleAnim,
                              child: ElevatedButton(
                                onPressed: _nextQuestion,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: nt.blueGoogle,
                                  padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 16),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(
                                              16)),
                                ),
                                child: const Text(
                                  'Siguiente Desafío →',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Confetti
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartScreen(NeuralThemeData nt) {
    return Scaffold(
      backgroundColor: nt.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                // Title
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: nt.purple.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: nt.purple.withValues(alpha: 0.4),
                          width: 2),
                    ),
                    child: Icon(Icons.shield_rounded,
                        color: nt.purple, size: 48),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Quiz Guardaparque',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Demuestra tu dominio de las ANPs del SINANPE\ncon vidas, rachas y contrarreloj.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                      height: 1.5),
                ),
                const SizedBox(height: 32),
                Text(
                  'Selecciona la dificultad:',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                // Difficulty selection
                ..._Difficulty.values
                    .map((d) => _buildDifficultyCard(nt, d)),
                const SizedBox(height: 24),
                // Game rules preview
                StaticGlassContainer(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _ruleRow(Icons.favorite_rounded,
                          'Vidas: $_initialLives corazones', nt.pink),
                      _ruleRow(Icons.timer_rounded,
                          'Tiempo: ${_timerSeconds}s por pregunta',
                          nt.warningAmber),
                      _ruleRow(Icons.flash_on_rounded,
                          'Power-up 50/50 disponible (x1)',
                          nt.successGreen),
                      _ruleRow(Icons.local_fire_department_rounded,
                          'Racha x2 a partir de 3 correctas', nt.cyan),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: nt.purple,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                  ),
                  child: const Text(
                    '¡Comenzar Desafío!',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyCard(NeuralThemeData nt, _Difficulty d) {
    final isSelected = _selectedDifficulty == d;
    String label, subtitle;
    Color color;
    IconData icon;
    switch (d) {
      case _Difficulty.easy:
        label = 'Fácil';
        subtitle = '25s · 5 vidas · Preguntas básicas';
        color = nt.successGreen;
        icon = Icons.sentiment_satisfied_alt_rounded;
        break;
      case _Difficulty.normal:
        label = 'Normal';
        subtitle = '15s · 3 vidas · Preguntas variadas';
        color = nt.warningAmber;
        icon = Icons.sentiment_neutral_rounded;
        break;
      case _Difficulty.expert:
        label = 'Experto';
        subtitle = '10s · 2 vidas · Todas las categorías';
        color = nt.pink;
        icon = Icons.local_fire_department_rounded;
        break;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () =>
            setState(() => _selectedDifficulty = d),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? color.withValues(alpha: 0.15)
                : Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? color.withValues(alpha: 0.6)
                  : Colors.white.withValues(alpha: 0.1),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(icon,
                  color: isSelected ? color : Colors.white38,
                  size: 24),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: isSelected ? color : Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white
                            .withValues(alpha: 0.4),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle_rounded,
                    color: color, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ruleRow(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 10),
          Text(text,
              style: const TextStyle(
                  color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildHUDRow(NeuralThemeData nt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SCORE: $_score',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
            if (_streak > 0)
              Row(
                children: [
                  Icon(Icons.local_fire_department_rounded,
                      color: nt.warningAmber, size: 12),
                  const SizedBox(width: 3),
                  Text(
                    'Racha: $_streak',
                    style: TextStyle(
                        color: nt.warningAmber,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
          ],
        ),
        // Hearts
        Row(
          children: List.generate(_initialLives, (i) {
            final isLost = i >= _lives;
            return Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: AnimatedScale(
                scale: isLost ? 0.8 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  isLost
                      ? Icons.favorite_border_rounded
                      : Icons.favorite_rounded,
                  color: isLost ? Colors.white24 : nt.pink,
                  size: 22,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  String _getQuestionTitleText() {
    switch (_currentQuestionType) {
      case _QuestionType.region:
        return '¿EN QUÉ REGIÓN SE ENCUENTRA ESTA ANP?';
      case _QuestionType.useType:
        return '¿CUÁL ES EL TIPO DE USO JURÍDICO?';
      case _QuestionType.category:
        return '¿CUÁL ES LA CATEGORÍA DE ESTA ÁREA?';
      case _QuestionType.fauna:
        return '¿QUÉ ESPECIE CLAVE PROTEGE ESTA ANP?';
      case _QuestionType.established:
        return '¿EN QUÉ AÑO SE ESTABLECIÓ?';
    }
  }

  Widget _buildExplanationCard(NeuralThemeData nt) {
    return StaticGlassContainer(
      padding: const EdgeInsets.all(14),
      borderColor: Colors.white10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline_rounded,
                  color: nt.warningAmber, size: 16),
              const SizedBox(width: 8),
              const Text(
                'Justificación y Mnemotecnia',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${_currentANP.name} es un ${_currentANP.category} de '
            '${_currentANP.useType}. Se ubica en ${_currentANP.regions.join(", ")}.\n\n'
            '"${_currentANP.mnemonicHint}"',
            style: const TextStyle(
                color: Colors.white70, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(NeuralThemeData nt, String option) {
    final isSelected = _selectedAnswer == option;
    final isCorrect = option == _correctAnswer;

    Color borderColor = Colors.white.withValues(alpha: 0.1);
    Color bgColor = nt.surfaceCard;
    Color textColor = Colors.white;

    if (_answered) {
      if (isCorrect) {
        borderColor = Colors.greenAccent;
        bgColor = Colors.greenAccent.withValues(alpha: 0.1);
        textColor = Colors.greenAccent;
      } else if (isSelected) {
        borderColor = Colors.redAccent;
        bgColor = Colors.redAccent.withValues(alpha: 0.1);
        textColor = Colors.redAccent;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: _answered ? null : () => _submitAnswer(option),
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  option,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              if (_answered && isCorrect)
                const Icon(Icons.check_circle_rounded,
                    color: Colors.greenAccent, size: 20),
              if (_answered && isSelected && !isCorrect)
                const Icon(Icons.cancel_rounded,
                    color: Colors.redAccent, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

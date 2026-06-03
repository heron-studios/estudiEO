import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/data/periodic_table_data.dart';
import 'package:learn/models/chemical_element.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';

enum QuestionType {
  symbolToName,
  nameToSymbol,
  atomicNumber,
  family,
}

class PtSurvivalView extends StatefulWidget {
  const PtSurvivalView({super.key});

  @override
  State<PtSurvivalView> createState() => _PtSurvivalViewState();
}

class _PtSurvivalViewState extends State<PtSurvivalView> with SingleTickerProviderStateMixin {
  final Random _random = Random();
  late ChemicalElement _currentElement;
  late List<String> _options;
  late QuestionType _questionType;
  
  int _score = 0;
  int _comboMultiplier = 1;
  int _correctInARow = 0;
  
  String? _selectedAnswer;
  bool _answered = false;

  int _timeLeft = 60;
  Timer? _timer;
  bool _isPlaying = false;
  bool _isGameOver = false;
  String? _hintMessage;
  
  // Animation for time changes
  int _timeChange = 0;
  bool _showTimeChange = false;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      _isPlaying = true;
      _isGameOver = false;
      _score = 0;
      _comboMultiplier = 1;
      _correctInARow = 0;
      _timeLeft = 60;
      _hintMessage = null;
      _generateQuestion();
    });
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _endGame();
        }
      });
    });
  }

  void _endGame() {
    _timer?.cancel();
    setState(() {
      _isPlaying = false;
      _isGameOver = true;
    });
  }

  void _generateQuestion() {
    _answered = false;
    _selectedAnswer = null;
    _hintMessage = null;
    
    // Difficulty progression based on score or time passed
    int difficultyLevel = _score ~/ 100; // Increase difficulty every 100 points
    
    int typeRand = _random.nextInt(10);
    if (difficultyLevel == 0) {
      // Easy level: only symbol/name
      _questionType = typeRand < 5 ? QuestionType.symbolToName : QuestionType.nameToSymbol;
    } else if (difficultyLevel == 1) {
      // Medium level: add atomic number
      if (typeRand < 4) _questionType = QuestionType.symbolToName;
      else if (typeRand < 8) _questionType = QuestionType.nameToSymbol;
      else _questionType = QuestionType.atomicNumber;
    } else {
      // Hard level: add families
      if (typeRand < 3) _questionType = QuestionType.symbolToName;
      else if (typeRand < 6) _questionType = QuestionType.nameToSymbol;
      else if (typeRand < 8) _questionType = QuestionType.atomicNumber;
      else _questionType = QuestionType.family;
    }
    
    // Filter elements based on difficulty? We can just pick randomly for now, 
    // maybe pick lighter elements more often early on.
    if (difficultyLevel < 2) {
      // First 36 elements
      _currentElement = periodicTableElements[_random.nextInt(min(36, periodicTableElements.length))];
    } else {
      _currentElement = periodicTableElements[_random.nextInt(periodicTableElements.length)];
    }
    
    String correctAnswer;
    switch (_questionType) {
      case QuestionType.symbolToName:
        correctAnswer = _currentElement.name;
        break;
      case QuestionType.nameToSymbol:
        correctAnswer = _currentElement.symbol;
        break;
      case QuestionType.atomicNumber:
        correctAnswer = _currentElement.name;
        break;
      case QuestionType.family:
        correctAnswer = _currentElement.family;
        break;
    }
    
    Set<String> optionsSet = {correctAnswer};
    
    int optionsCount = difficultyLevel >= 3 ? 6 : 4;
    
    while (optionsSet.length < optionsCount) {
      ChemicalElement randomElement = periodicTableElements[_random.nextInt(periodicTableElements.length)];
      switch (_questionType) {
        case QuestionType.symbolToName:
          optionsSet.add(randomElement.name);
          break;
        case QuestionType.nameToSymbol:
          optionsSet.add(randomElement.symbol);
          break;
        case QuestionType.atomicNumber:
          optionsSet.add(randomElement.name);
          break;
        case QuestionType.family:
          optionsSet.add(randomElement.family);
          break;
      }
    }
    
    _options = optionsSet.toList();
    _options.shuffle();
  }

  void _showTimeChangeAnimation(int change) {
    setState(() {
      _timeChange = change;
      _showTimeChange = true;
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => _showTimeChange = false);
    });
  }

  void _handleAnswer(String selected) {
    if (_answered || !_isPlaying) return;
    
    setState(() {
      _answered = true;
      _selectedAnswer = selected;
      
      bool isCorrect = false;
      switch (_questionType) {
        case QuestionType.symbolToName:
          isCorrect = selected == _currentElement.name;
          break;
        case QuestionType.nameToSymbol:
          isCorrect = selected == _currentElement.symbol;
          break;
        case QuestionType.atomicNumber:
          isCorrect = selected == _currentElement.name;
          break;
        case QuestionType.family:
          isCorrect = selected == _currentElement.family;
          break;
      }

      if (isCorrect) {
        _correctInARow++;
        if (_correctInARow % 3 == 0) {
          _comboMultiplier++; // Increase multiplier every 3 correct answers
        }
        
        _score += 10 * _comboMultiplier;
        
        // Add time
        int addedTime = 2;
        _timeLeft += addedTime;
        _showTimeChangeAnimation(addedTime);

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted && _isPlaying) {
            setState(() => _generateQuestion());
          }
        });
      } else {
        // Reset combo
        _correctInARow = 0;
        _comboMultiplier = 1;
        
        // Subtract time
        int subTime = -5;
        _timeLeft += subTime;
        if (_timeLeft < 0) _timeLeft = 0;
        _showTimeChangeAnimation(subTime);

        _timer?.cancel();
        _hintMessage = _getHint(_currentElement, selected);
        
        if (_timeLeft <= 0) {
          _endGame();
        }
      }
    });
  }

  void _continueAfterHint() {
    if (_timeLeft <= 0) {
      _endGame();
      return;
    }
    setState(() {
      _generateQuestion();
      _startTimer();
    });
  }

  String _getHint(ChemicalElement correct, String wrong) {
    String msg = "";
    switch (_questionType) {
      case QuestionType.symbolToName:
        msg = "Elegiste '$wrong' pero el símbolo ${correct.symbol} le pertenece a '${correct.name}'.\n";
        break;
      case QuestionType.nameToSymbol:
        msg = "Elegiste '$wrong' pero '${correct.name}' se representa con ${correct.symbol}.\n";
        break;
      case QuestionType.atomicNumber:
        msg = "Elegiste '$wrong' pero el elemento con Z=${correct.atomicNumber} es '${correct.name}'.\n";
        break;
      case QuestionType.family:
        msg = "Elegiste '$wrong' pero '${correct.name}' es un(a) '${correct.family}'.\n";
        break;
    }

    if (correct.symbol == 'Na') {
      msg += '💡 Regla: Na viene de Natrium (latín). ¡Na-trium = Na-Sodio!';
    } else if (correct.symbol == 'K') {
      msg += "💡 Regla: K viene de Kalium. ¡Piensa en el 'Potasio' como una vitamina K gigante!";
    } else if (correct.symbol == 'Fe') {
      msg += "💡 Regla: Fe = Ferrum. Acuérdate de la palabra 'Ferro-carril' que está hecho de Hierro.";
    } else if (correct.symbol == 'Cu') {
      msg += "💡 Regla: Cu = Cuprum. Piensa en un 'CUbo' de Cobre brillante.";
    } else if (correct.symbol == 'Ag') {
      msg += "💡 Regla: Ag = Argentum. 'Argentina' significa tierra de plata. Ag = Plata.";
    } else if (correct.symbol == 'Sn') {
      msg += "💡 Regla: Sn = Stannum. 'eStañó' suena parecido si te fijas en la S y la N.";
    } else if (correct.symbol == 'Sb') {
      msg += '💡 Regla: Sb = Stibium. Antimonio es Sb... ¡Suena nada parecido, es el más rebelde de la tabla!';
    } else if (correct.symbol == 'W') {
      msg += "💡 Regla: W = Wolframio (Tungsteno). El filamento de los focos viejos formaba una 'W'.";
    } else if (correct.symbol == 'Au') {
      msg += "💡 Regla: Au = Aurum. Cuando ves oro robado gritas '¡Au, mi oro!'";
    } else if (correct.symbol == 'Hg') {
      msg += '💡 Regla: Hg = Hydrargyrum. Piensa en un termómetro antiguo de Mercurio.';
    } else if (correct.symbol == 'Pb') {
      msg += '💡 Regla: Pb = Plumbum. Viene de Plomero, porque antes usaban tubos de Plomo (Pb).';
    } else if (correct.symbol == 'P') {
      msg += "💡 Regla: P = Fósforo. En griego es 'Phosphorus', por eso lleva P.";
    } else if (correct.symbol == 'S') {
      msg += "💡 Regla: S = Azufre. En inglés es 'Sulphur', por eso lleva S.";
    } else {
      msg += "💡 Regla: Fíjate en las letras de '${correct.name}', coinciden con su símbolo '${correct.symbol}'.";
    }

    return msg;
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    if (!_isPlaying && !_isGameOver) {
      return _buildStartScreen(nt);
    }

    if (_isGameOver) {
      return _buildGameOverScreen(nt);
    }

    String promptText = "";
    String hintText = "";
    
    switch (_questionType) {
      case QuestionType.symbolToName:
        promptText = _currentElement.symbol;
        hintText = '¿Cuál es su nombre?';
        break;
      case QuestionType.nameToSymbol:
        promptText = _currentElement.name;
        hintText = '¿Cuál es su símbolo?';
        break;
      case QuestionType.atomicNumber:
        promptText = 'Z = ${_currentElement.atomicNumber}';
        hintText = '¿Qué elemento es?';
        break;
      case QuestionType.family:
        promptText = _currentElement.name;
        hintText = '¿A qué familia pertenece?';
        break;
    }

    final progressColor = _timeLeft > 15 ? nt.successGreen : nt.pink;

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header (Timer and Score)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timer_outlined, color: progressColor),
                        const SizedBox(width: 8),
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '00:${_timeLeft.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                color: progressColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (_showTimeChange)
                              Positioned(
                                top: -20,
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0.0, end: -10.0),
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.easeOut,
                                  builder: (context, value, child) {
                                    return Transform.translate(
                                      offset: Offset(0, value),
                                      child: Opacity(
                                        opacity: 1.0 - (value.abs() / 10),
                                        child: Text(
                                          _timeChange > 0 ? '+$_timeChange' : '$_timeChange',
                                          style: TextStyle(
                                            color: _timeChange > 0 ? nt.successGreen : nt.pink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (_comboMultiplier > 1)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: nt.warningAmber.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: nt.warningAmber.withValues(alpha: 0.5)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.bolt, color: nt.warningAmber, size: 16),
                                Text(
                                  'x$_comboMultiplier',
                                  style: TextStyle(color: nt.warningAmber, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: nt.blueGoogle.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: nt.blueGoogle.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            '$_score pts',
                            style: TextStyle(color: nt.blueGoogle, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: _timeLeft / 60,
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 24),

                // Main Card
                Expanded(
                  flex: 2,
                  child: HoverGlassCard(
                    borderRadius: BorderRadius.circular(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                promptText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  // Adjust size slightly if it's family text
                                  fontSize: _questionType == QuestionType.family ? 40 : 80, 
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: nt.blueGoogle.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            hintText,
                            style: TextStyle(color: nt.blueGoogle, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Inline Hint
                if (_hintMessage != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: nt.pink.withValues(alpha: 0.1),
                      border: Border.all(color: nt.pink.withValues(alpha: 0.5)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.timer_off_rounded, color: nt.pink),
                            const SizedBox(width: 8),
                            const Text('¡Error!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _hintMessage!,
                          style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _continueAfterHint,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: nt.pink,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('CONTINUAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                  ),

                // Options Grid
                if (_hintMessage == null)
                  Expanded(
                    flex: 3,
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: _options.length > 4 ? 2.5 : 1.6,
                      physics: const NeverScrollableScrollPhysics(),
                      children: _options.map((option) => _buildOptionCard(nt, option)).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStartScreen(NeuralThemeData nt) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: nt.warningAmber.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: nt.warningAmber.withValues(alpha: 0.3), width: 2),
                boxShadow: [
                  BoxShadow(color: nt.warningAmber.withValues(alpha: 0.2), blurRadius: 20, spreadRadius: 5),
                ]
              ),
              child: Icon(Icons.timer_rounded, color: nt.warningAmber, size: 80),
            ),
            const SizedBox(height: 32),
            const Text(
              'Supervivencia',
              style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Adivina elementos rápidamente.\n¡Aciertos suman tiempo, errores restan!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
            const SizedBox(height: 64),
            SizedBox(
              width: 200,
              height: 56,
              child: ElevatedButton(
                onPressed: _startGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: nt.warningAmber,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  elevation: 8,
                  shadowColor: nt.warningAmber.withValues(alpha: 0.5),
                ),
                child: const Text('Comenzar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameOverScreen(NeuralThemeData nt) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Tiempo Agotado!',
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: nt.surfaceElevated,
                shape: BoxShape.circle,
                border: Border.all(color: nt.blueGoogle.withValues(alpha: 0.5), width: 4),
                boxShadow: [
                  BoxShadow(color: nt.blueGoogle.withValues(alpha: 0.2), blurRadius: 40, spreadRadius: 10),
                ]
              ),
              child: Column(
                children: [
                  Text('PUNTAJE', style: TextStyle(color: nt.blueGoogle, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  const SizedBox(height: 8),
                  Text(
                    '$_score',
                    style: const TextStyle(color: Colors.white, fontSize: 80, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 64),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _startGame,
                icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                label: const Text('Jugar de Nuevo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: nt.blueGoogle,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(NeuralThemeData nt, String option) {
    Color borderColor = Colors.white.withValues(alpha: 0.1);
    Color bgColor = nt.surfaceElevated;
    Color textColor = Colors.white;

    bool isCorrectOption = false;
    switch (_questionType) {
      case QuestionType.symbolToName:
        isCorrectOption = option == _currentElement.name;
        break;
      case QuestionType.nameToSymbol:
        isCorrectOption = option == _currentElement.symbol;
        break;
      case QuestionType.atomicNumber:
        isCorrectOption = option == _currentElement.name;
        break;
      case QuestionType.family:
        isCorrectOption = option == _currentElement.family;
        break;
    }

    if (_answered) {
      if (isCorrectOption) {
        borderColor = nt.successGreen;
        bgColor = nt.successGreen.withValues(alpha: 0.15);
        textColor = nt.successGreen;
      } else if (option == _selectedAnswer) {
        borderColor = nt.pink;
        bgColor = nt.pink.withValues(alpha: 0.15);
        textColor = nt.pink;
      }
    }

    return InkWell(
      onTap: () => _handleAnswer(option),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                option,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

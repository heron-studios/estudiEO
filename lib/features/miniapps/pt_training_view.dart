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

class PtTrainingView extends StatefulWidget {
  const PtTrainingView({super.key});

  @override
  State<PtTrainingView> createState() => _PtTrainingViewState();
}

class _PtTrainingViewState extends State<PtTrainingView> with SingleTickerProviderStateMixin {
  final Random _random = Random();
  late ChemicalElement _currentElement;
  late List<String> _options;
  late QuestionType _questionType;
  
  int _score = 0;
  int _streak = 0;
  int _lives = 3;
  
  String? _selectedAnswer;
  bool _answered = false;
  String? _hintMessage;
  bool _isGameOver = false;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    if (_lives <= 0) {
      setState(() {
        _isGameOver = true;
      });
      return;
    }

    _answered = false;
    _selectedAnswer = null;
    _hintMessage = null;
    
    // Select question type based on a bit of randomness, 
    // maybe family and atomic number are slightly less frequent.
    int typeRand = _random.nextInt(10);
    if (typeRand < 3) {
      _questionType = QuestionType.symbolToName;
    } else if (typeRand < 6) {
      _questionType = QuestionType.nameToSymbol;
    } else if (typeRand < 8) {
      _questionType = QuestionType.atomicNumber;
    } else {
      _questionType = QuestionType.family;
    }
    
    _currentElement = periodicTableElements[_random.nextInt(periodicTableElements.length)];
    
    // Determine the correct answer string based on the question type
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
    
    // Generate other options
    while (optionsSet.length < (_streak > 10 ? 6 : 4)) {
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

  void _handleAnswer(String selected) {
    if (_answered || _isGameOver) return;
    
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
        _score += 10 + (_streak * 2);
        _streak++;
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) setState(() => _generateQuestion());
        });
      } else {
        _streak = 0;
        _lives--;
        _hintMessage = _getHint(_currentElement, selected);
      }
    });
  }

  String _getHint(ChemicalElement correct, String wrong) {
    String msg = '';
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

    if (_lives <= 0) {
      msg += '\n\n💀 ¡Te has quedado sin vidas!';
    }

    return msg;
  }

  void _restartGame() {
    setState(() {
      _score = 0;
      _streak = 0;
      _lives = 3;
      _isGameOver = false;
      _generateQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    
    if (_isGameOver) {
      return _buildGameOverScreen(nt);
    }

    String promptText = '';
    String hintText = '';
    
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

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(3, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Icon(
                            index < _lives ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            color: nt.pink,
                            size: 28,
                          ),
                        );
                      }),
                    ),
                    Row(
                      children: [
                        _StatPill(icon: Icons.star_rounded, value: '$_score', color: nt.blueGoogle),
                        const SizedBox(width: 8),
                        _StatPill(icon: Icons.local_fire_department_rounded, value: '$_streak', color: nt.warningAmber),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Main Question Card
                Expanded(
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
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
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
                            border: Border.all(color: nt.blueGoogle.withValues(alpha: 0.3)),
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
                const SizedBox(height: 16),

                // Inline Feedback (Hint) - Animated
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutBack,
                  child: _hintMessage != null
                      ? Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: nt.pink.withValues(alpha: 0.1),
                            border: Border.all(color: nt.pink.withValues(alpha: 0.5)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.lightbulb_outline_rounded, color: nt.pink),
                                  const SizedBox(width: 8),
                                  const Text('¡Sigue intentando!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                                  onPressed: () => setState(() => _generateQuestion()),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: nt.pink,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: Text(_lives > 0 ? 'SIGUIENTE PREGUNTA' : 'TERMINAR', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                // Options Grid - Always visible
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: _options.length > 4 ? 2.5 : 2.0, // Flatter buttons for more options
                  physics: const NeverScrollableScrollPhysics(),
                  children: _options.map((option) => _buildOptionCard(nt, option)).toList(),
                ),
              ],
            ),
          ),
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
              '¡Entrenamiento Finalizado!',
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: nt.surfaceElevated,
                shape: BoxShape.circle,
                border: Border.all(color: nt.pink.withValues(alpha: 0.5), width: 4),
                boxShadow: [
                  BoxShadow(color: nt.pink.withValues(alpha: 0.2), blurRadius: 40, spreadRadius: 10),
                ]
              ),
              child: Column(
                children: [
                  Text('PUNTAJE', style: TextStyle(color: nt.pink, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2)),
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
                onPressed: _restartGame,
                icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                label: const Text('Entrenar de Nuevo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
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
          boxShadow: [
            if (_answered && isCorrectOption)
              BoxShadow(
                color: nt.successGreen.withValues(alpha: 0.2),
                blurRadius: 15,
                spreadRadius: 1,
              )
          ],
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

class _StatPill extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const _StatPill({required this.icon, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: color, blurRadius: 8)],
            ),
          ),
        ],
      ),
    );
  }
}

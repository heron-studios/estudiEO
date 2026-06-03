import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/data/periodic_table_data.dart';
import 'package:learn/models/chemical_element.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';

class PtSurvivalView extends StatefulWidget {
  const PtSurvivalView({super.key});

  @override
  State<PtSurvivalView> createState() => _PtSurvivalViewState();
}

class _PtSurvivalViewState extends State<PtSurvivalView> with SingleTickerProviderStateMixin {
  final Random _random = Random();
  late ChemicalElement _currentElement;
  late List<ChemicalElement> _options;
  bool _isSymbolToName = true;
  
  int _score = 0;
  ChemicalElement? _selectedAnswer;
  bool _answered = false;

  int _timeLeft = 60;
  Timer? _timer;
  bool _isPlaying = false;
  bool _isGameOver = false;
  String? _hintMessage;

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
    _isSymbolToName = _random.nextBool();
    
    _currentElement = periodicTableElements[_random.nextInt(periodicTableElements.length)];
    
    Set<ChemicalElement> optionsSet = {_currentElement};
    while (optionsSet.length < 4) {
      optionsSet.add(periodicTableElements[_random.nextInt(periodicTableElements.length)]);
    }
    
    _options = optionsSet.toList();
    _options.shuffle();
  }

  void _handleAnswer(ChemicalElement selected) {
    if (_answered || !_isPlaying) return;
    
    setState(() {
      _answered = true;
      _selectedAnswer = selected;
      
      if (selected.atomicNumber == _currentElement.atomicNumber) {
        _score += 10;
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted && _isPlaying) {
            setState(() => _generateQuestion());
          }
        });
      } else {
        // Stop timer to read the hint
        _timer?.cancel();
        _hintMessage = _getHint(_currentElement, selected);
      }
    });
  }

  void _continueAfterHint() {
    setState(() {
      _generateQuestion();
      _startTimer();
    });
  }

  String _getHint(ChemicalElement correct, ChemicalElement wrong) {
    String msg = _isSymbolToName 
        ? "Elegiste '${wrong.name}' pero el sÃ­mbolo ${correct.symbol} le pertenece a '${correct.name}'.\n"
        : "Elegiste '${wrong.symbol}' pero '${correct.name}' se representa con ${correct.symbol}.\n";

    if (correct.symbol == 'Na') {
      msg += 'ðŸ’¡ Regla: Na viene de Natrium (latÃ­n). Â¡Na-trium = Na-Sodio!';
    } else if (correct.symbol == 'K') {
      msg += "ðŸ’¡ Regla: K viene de Kalium. Â¡Piensa en el 'Potasio' como una vitamina K gigante!";
    } else if (correct.symbol == 'Fe') {
      msg += "ðŸ’¡ Regla: Fe = Ferrum. AcuÃ©rdate de la palabra 'Ferro-carril' que estÃ¡ hecho de Hierro.";
    } else if (correct.symbol == 'Cu') {
      msg += "ðŸ’¡ Regla: Cu = Cuprum. Piensa en un 'CUbo' de Cobre brillante.";
    } else if (correct.symbol == 'Ag') {
      msg += "ðŸ’¡ Regla: Ag = Argentum. 'Argentina' significa tierra de plata. Ag = Plata.";
    } else if (correct.symbol == 'Sn') {
      msg += "ðŸ’¡ Regla: Sn = Stannum. 'eStaÃ±Ã³' suena parecido si te fijas en la S y la N.";
    } else if (correct.symbol == 'Sb') {
      msg += 'ðŸ’¡ Regla: Sb = Stibium. Antimonio es Sb... Â¡Suena nada parecido, es el mÃ¡s rebelde de la tabla!';
    } else if (correct.symbol == 'W') {
      msg += "ðŸ’¡ Regla: W = Wolframio (Tungsteno). El filamento de los focos viejos formaba una 'W'.";
    } else if (correct.symbol == 'Au') {
      msg += "ðŸ’¡ Regla: Au = Aurum. Cuando ves oro robado gritas 'Â¡Au, mi oro!'";
    } else if (correct.symbol == 'Hg') {
      msg += 'ðŸ’¡ Regla: Hg = Hydrargyrum. Piensa en un termÃ³metro antiguo de Mercurio.';
    } else if (correct.symbol == 'Pb') {
      msg += 'ðŸ’¡ Regla: Pb = Plumbum. Viene de Plomero, porque antes usaban tubos de Plomo (Pb).';
    } else if (correct.symbol == 'P') {
      msg += "ðŸ’¡ Regla: P = FÃ³sforo. En griego es 'Phosphorus', por eso lleva P.";
    } else if (correct.symbol == 'S') {
      msg += "ðŸ’¡ Regla: S = Azufre. En inglÃ©s es 'Sulphur', por eso lleva S.";
    } else {
      msg += "ðŸ’¡ Regla: FÃ­jate en las letras de '${correct.name}', coinciden con su sÃ­mbolo '${correct.symbol}'.";
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

    final promptText = _isSymbolToName ? _currentElement.symbol : _currentElement.name;
    final hintText = _isSymbolToName ? 'Z: ${_currentElement.atomicNumber}' : 'Â¿SÃ­mbolo?';
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
                        Text(
                          '00:${_timeLeft.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            color: progressColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: nt.blueGoogle.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: nt.blueGoogle.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        'Puntos: $_score',
                        style: TextStyle(color: nt.blueGoogle, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            promptText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                            const Text('Â¡Error!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                      childAspectRatio: 1.6,
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
              'Adivina la mayor cantidad de elementos en 60 segundos. Â¡SÃ© veloz!',
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
              'Â¡Tiempo Agotado!',
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

  Widget _buildOptionCard(NeuralThemeData nt, ChemicalElement option) {
    final optionText = _isSymbolToName ? option.name : option.symbol;
    
    Color borderColor = Colors.white.withValues(alpha: 0.1);
    Color bgColor = nt.surfaceElevated;
    Color textColor = Colors.white;

    if (_answered) {
      if (option.atomicNumber == _currentElement.atomicNumber) {
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
                optionText,
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

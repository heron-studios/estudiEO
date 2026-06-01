import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:learn/config/neural_theme.dart';
import 'package:learn/data/periodic_table_data.dart';
import 'package:learn/models/chemical_element.dart';
import 'package:learn/widgets/glass_card_widget.dart';

class PtSurvivalView extends StatefulWidget {
  const PtSurvivalView({super.key});

  @override
  State<PtSurvivalView> createState() => _PtSurvivalViewState();
}

class _PtSurvivalViewState extends State<PtSurvivalView> {
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
      _generateQuestion();
    });

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
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted && _isPlaying) {
            setState(() {
              _generateQuestion();
            });
          }
        });
      } else {
        final nt = NeuralTheme.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_getHint(_currentElement)),
            backgroundColor: nt.pink,
            duration: const Duration(milliseconds: 1500),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted && _isPlaying) {
            setState(() {
              _generateQuestion();
            });
          }
        });
      }
    });

  }

  String _getHint(ChemicalElement element) {
    if (element.symbol == 'Na') return 'Sodio es Na (del latín Natrium).';
    if (element.symbol == 'K') return 'Potasio es K (del latín Kalium).';
    if (element.symbol == 'Fe') return 'Hierro es Fe (del latín Ferrum).';
    if (element.symbol == 'Cu') return 'Cobre es Cu (del latín Cuprum).';
    if (element.symbol == 'Ag') return 'Plata es Ag (del latín Argentum).';
    if (element.symbol == 'Sn') return 'Estaño es Sn (del latín Stannum).';
    if (element.symbol == 'Sb') return 'Antimonio es Sb (del latín Stibium).';
    if (element.symbol == 'W') return 'Wolframio (Tungsteno) es W (Wolfram).';
    if (element.symbol == 'Au') return 'Oro es Au (del latín Aurum).';
    if (element.symbol == 'Hg') return 'Mercurio es Hg (del latín Hydrargyrum).';
    if (element.symbol == 'Pb') return 'Plomo es Pb (del latín Plumbum).';
    return 'Recuerda: ${element.name} es ${element.symbol}.';
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    if (!_isPlaying && !_isGameOver) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.timer_rounded, color: Colors.white, size: 64),
            const SizedBox(height: 24),
            const Text(
              'Modo Supervivencia',
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Responde todo lo que puedas en 60 segundos.',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: _startGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: nt.blueGoogle,
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Comenzar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      );
    }

    if (_isGameOver) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Tiempo agotado!',
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text(
              'Puntaje Final',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 18),
            ),
            Text(
              '$_score',
              style: TextStyle(color: nt.pink, fontSize: 64, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: _startGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: nt.blueGoogle,
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Jugar de nuevo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      );
    }

    final promptText = _isSymbolToName ? _currentElement.symbol : _currentElement.name;
    final hintText = _isSymbolToName ? 'Z: ${_currentElement.atomicNumber}' : '¿Símbolo?';

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight > 32 ? constraints.maxHeight - 32 : 0,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header (Timer and Score)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, color: _timeLeft <= 10 ? nt.pink : Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        '00:${_timeLeft.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          color: _timeLeft <= 10 ? nt.pink : Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Puntaje: $_score',
                    style: TextStyle(
                      color: nt.blueGoogle,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Main Card
              HoverGlassCard(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Column(
                    children: [
                      Text(
                        promptText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        hintText,
                        style: TextStyle(
                          color: nt.blueGoogle,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Options Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 2.5,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                children: _options.map((option) {
                  final optionText = _isSymbolToName ? option.name : option.symbol;
                  
                  Color borderColor = nt.borderSubtle;
                  Color bgColor = Colors.transparent;
                  Color textColor = Colors.white;

                  if (_answered) {
                    if (option.atomicNumber == _currentElement.atomicNumber) {
                      borderColor = nt.successGreen;
                      bgColor = nt.successGreen.withValues(alpha: 0.2);
                      textColor = nt.successGreen;
                    } else if (option == _selectedAnswer) {
                      borderColor = nt.pink;
                      bgColor = nt.pink.withValues(alpha: 0.2);
                      textColor = nt.pink;
                    }
                  }

                  return InkWell(
                    onTap: () => _handleAnswer(option),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor, width: 1.5),
                      ),
                      child: Center(
                        child: Text(
                          optionText,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);
      },
    );
  }
}

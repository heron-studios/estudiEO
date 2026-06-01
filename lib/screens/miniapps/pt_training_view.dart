import 'dart:math';
import 'package:flutter/material.dart';
import 'package:learn/config/neural_theme.dart';
import 'package:learn/data/periodic_table_data.dart';
import 'package:learn/models/chemical_element.dart';
import 'package:learn/widgets/glass_card_widget.dart';

class PtTrainingView extends StatefulWidget {
  const PtTrainingView({super.key});

  @override
  State<PtTrainingView> createState() => _PtTrainingViewState();
}

class _PtTrainingViewState extends State<PtTrainingView> {
  final Random _random = Random();
  late ChemicalElement _currentElement;
  late List<ChemicalElement> _options;
  bool _isSymbolToName = true;
  
  int _score = 0;
  int _streak = 0;
  
  ChemicalElement? _selectedAnswer;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    _answered = false;
    _selectedAnswer = null;
    _isSymbolToName = _random.nextBool();
    
    // Select a random element
    _currentElement = periodicTableElements[_random.nextInt(periodicTableElements.length)];
    
    // Select 3 other random options
    Set<ChemicalElement> optionsSet = {_currentElement};
    while (optionsSet.length < 4) {
      optionsSet.add(periodicTableElements[_random.nextInt(periodicTableElements.length)]);
    }
    
    _options = optionsSet.toList();
    _options.shuffle();
  }

  void _handleAnswer(ChemicalElement selected) {
    if (_answered) return;
    
    setState(() {
      _answered = true;
      _selectedAnswer = selected;
      
      if (selected.atomicNumber == _currentElement.atomicNumber) {
        _score++;
        _streak++;
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) {
            setState(() {
              _generateQuestion();
            });
          }
        });
      } else {
        _streak = 0;
        final nt = NeuralTheme.of(context);
        
        Future.delayed(const Duration(milliseconds: 500), () {
          if (!mounted) return;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              backgroundColor: nt.surfaceElevated,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              title: Row(
                children: [
                  Icon(Icons.warning_rounded, color: nt.pink, size: 32),
                  const SizedBox(width: 12),
                  const Text('¡Casi!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
              content: Text(
                _getHint(_currentElement, selected),
                style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    if (mounted) {
                      setState(() {
                        _generateQuestion();
                      });
                    }
                  },
                  child: Text('ENTENDIDO', style: TextStyle(color: nt.blueGoogle, fontWeight: FontWeight.bold, fontSize: 16)),
                )
              ],
            ),
          );
        });
      }
    });
  }

  String _getHint(ChemicalElement correct, ChemicalElement wrong) {
    String msg = _isSymbolToName 
        ? "Elegiste '${wrong.name}' pero el símbolo ${correct.symbol} le pertenece a '${correct.name}'.\n\n"
        : "Elegiste '${wrong.symbol}' pero '${correct.name}' se representa con ${correct.symbol}.\n\n";

    if (correct.symbol == 'Na') msg += "💡 Regla: Na viene de Natrium (latín). ¡Na-trium = Na-Sodio!";
    else if (correct.symbol == 'K') msg += "💡 Regla: K viene de Kalium. ¡Piensa en el 'Potasio' como una vitamina K gigante!";
    else if (correct.symbol == 'Fe') msg += "💡 Regla: Fe = Ferrum. Acuérdate de la palabra 'Ferro-carril' que está hecho de Hierro.";
    else if (correct.symbol == 'Cu') msg += "💡 Regla: Cu = Cuprum. Piensa en un 'CUbo' de Cobre brillante.";
    else if (correct.symbol == 'Ag') msg += "💡 Regla: Ag = Argentum. 'Argentina' significa tierra de plata. Ag = Plata.";
    else if (correct.symbol == 'Sn') msg += "💡 Regla: Sn = Stannum. 'eStañó' suena parecido si te fijas en la S y la N.";
    else if (correct.symbol == 'Sb') msg += "💡 Regla: Sb = Stibium. Antimonio es Sb... ¡Suena nada parecido, es el más rebelde de la tabla!";
    else if (correct.symbol == 'W') msg += "💡 Regla: W = Wolframio (Tungsteno). El filamento de los focos viejos formaba una 'W'.";
    else if (correct.symbol == 'Au') msg += "💡 Regla: Au = Aurum. Cuando ves oro robado gritas '¡Au, mi oro!'";
    else if (correct.symbol == 'Hg') msg += "💡 Regla: Hg = Hydrargyrum. Piensa en un termómetro antiguo de Mercurio.";
    else if (correct.symbol == 'Pb') msg += "💡 Regla: Pb = Plumbum. Viene de Plomero, porque antes usaban tubos de Plomo (Pb).";
    else if (correct.symbol == 'P') msg += "💡 Regla: P = Fósforo. En griego es 'Phosphorus', por eso lleva P.";
    else if (correct.symbol == 'S') msg += "💡 Regla: S = Azufre. En inglés es 'Sulphur', por eso lleva S.";
    else msg += "💡 Regla: Fíjate en las letras de '${correct.name}', coinciden con su símbolo '${correct.symbol}'.";

    return msg;
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    
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
                      borderColor = nt.pink; // Using pink as red/error
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
              
              const SizedBox(height: 48),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatBox(label: 'Puntaje', value: _score.toString(), nt: nt),
                  _StatBox(label: 'Racha', value: _streak.toString(), nt: nt),
                ],
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

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final NeuralThemeData nt;

  const _StatBox({required this.label, required this.value, required this.nt});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: nt.blueGoogle,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/data/periodic_table_data.dart';
import 'package:learn/models/chemical_element.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';

class PtTrainingView extends StatefulWidget {
  const PtTrainingView({super.key});

  @override
  State<PtTrainingView> createState() => _PtTrainingViewState();
}

class _PtTrainingViewState extends State<PtTrainingView> with SingleTickerProviderStateMixin {
  final Random _random = Random();
  late ChemicalElement _currentElement;
  late List<ChemicalElement> _options;
  bool _isSymbolToName = true;
  
  int _score = 0;
  int _streak = 0;
  
  ChemicalElement? _selectedAnswer;
  bool _answered = false;
  String? _hintMessage;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
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
    if (_answered) return;
    
    setState(() {
      _answered = true;
      _selectedAnswer = selected;
      
      if (selected.atomicNumber == _currentElement.atomicNumber) {
        _score++;
        _streak++;
        // Quick transition on correct answer
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) setState(() => _generateQuestion());
        });
      } else {
        _streak = 0;
        _hintMessage = _getHint(_currentElement, selected);
      }
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
    final promptText = _isSymbolToName ? _currentElement.symbol : _currentElement.name;
    final hintText = _isSymbolToName ? 'Z: ${_currentElement.atomicNumber}' : 'Â¿SÃ­mbolo?';

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
                    _StatPill(icon: Icons.star_rounded, value: '$_score', color: nt.blueGoogle),
                    _StatPill(icon: Icons.local_fire_department_rounded, value: '$_streak', color: nt.warningAmber),
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
                                  const Text('Â¡Sigue intentando!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                                  child: const Text('SIGUIENTE PREGUNTA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                  childAspectRatio: 2.0, // Flatter buttons to save space
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
          boxShadow: [
            if (_answered && option.atomicNumber == _currentElement.atomicNumber)
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

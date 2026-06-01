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
      } else {
        _streak = 0;
      }
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _generateQuestion();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    
    final promptText = _isSymbolToName ? _currentElement.symbol : _currentElement.name;
    final hintText = _isSymbolToName ? 'Z: ${_currentElement.atomicNumber}' : '¿Símbolo?';

    return Center(
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
              
              // Stats
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

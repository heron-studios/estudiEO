import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import '../data/anp_repository.dart';
import '../data/anp_model.dart';
import '../domain/spaced_repetition_engine.dart';
import 'dart:math';

class ANPQuizView extends StatefulWidget {
  const ANPQuizView({super.key});

  @override
  State<ANPQuizView> createState() => _ANPQuizViewState();
}

class _ANPQuizViewState extends State<ANPQuizView> {
  final SpacedRepetitionEngine _engine = SpacedRepetitionEngine();
  final List<ANPModel> _allAnps = ANPRepository.getAllANPs();
  
  late List<String> _dueItems;
  int _currentIndex = 0;
  
  String? _selectedAnswer;
  bool _answered = false;
  
  // Quiz state for current question
  late List<String> _options;
  late String _correctAnswer;
  late _QuestionType _currentQuestionType;

  @override
  void initState() {
    super.initState();
    _engine.initItems(_allAnps.map((e) => e.id).toList());
    _loadDueItems();
  }

  void _loadDueItems() {
    // For demo purposes, we will treat all items as due if none are actually due
    _dueItems = _engine.getDueItems(10);
    if (_dueItems.isEmpty) {
      _dueItems = _allAnps.map((e) => e.id).toList()..shuffle();
      _dueItems = _dueItems.take(5).toList();
    }
    if (_dueItems.isNotEmpty) {
      _generateQuestion(_dueItems[_currentIndex]);
    }
  }

  void _generateQuestion(String anpId) {
    final anp = _allAnps.firstWhere((e) => e.id == anpId);
    final random = Random();
    
    // Pick question type
    _currentQuestionType = _QuestionType.values[random.nextInt(_QuestionType.values.length)];
    
    _options = [];
    
    switch (_currentQuestionType) {
      case _QuestionType.region:
        _correctAnswer = anp.regions.join(', ');
        final otherRegions = _allAnps.where((e) => e.id != anp.id).map((e) => e.regions.join(', ')).toList();
        otherRegions.shuffle();
        _options.add(_correctAnswer);
        _options.addAll(otherRegions.take(3));
        break;
      case _QuestionType.useType:
        _correctAnswer = anp.useType;
        _options = [
          'Directo (Tangible/Sostenible)',
          'Indirecto (Intangible)',
          'Uso Mixto (Reserva Comunal)',
          'Zona de Amortiguamiento'
        ];
        break;
      case _QuestionType.category:
        _correctAnswer = anp.category;
        final categories = _allAnps.map((e) => e.category).toSet().toList();
        categories.remove(_correctAnswer);
        categories.shuffle();
        _options.add(_correctAnswer);
        _options.addAll(categories.take(3));
        break;
    }
    
    _options = _options.toSet().toList(); // Ensure unique
    _options.shuffle();
  }

  void _submitAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
      _answered = true;
      
      final isCorrect = answer == _correctAnswer;
      // Pass to SRS engine
      _engine.processAnswer(_dueItems[_currentIndex], isCorrect ? 5 : 1);
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentIndex < _dueItems.length - 1) {
        _currentIndex++;
        _selectedAnswer = null;
        _answered = false;
        _generateQuestion(_dueItems[_currentIndex]);
      } else {
        // Quiz finished
        _showResults();
      }
    });
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: NeuralTheme.of(context).surfaceCard,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text('¡Desafío Completado!', style: TextStyle(color: Colors.white)),
          content: const Text(
            'Has completado tu sesión de repaso. Vuelve mañana para reforzar las ANP que fallaste.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop(); // close dialog
                context.pop(); // return to menu
              },
              child: const Text('Volver al Menú', style: TextStyle(color: Colors.greenAccent)),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    
    if (_dueItems.isEmpty) {
      return Scaffold(
        backgroundColor: nt.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(
          child: Text('No hay ANPs para repasar ahora.', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    final currentAnpId = _dueItems[_currentIndex];
    final anp = _allAnps.firstWhere((e) => e.id == currentAnpId);

    return Scaffold(
      backgroundColor: nt.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Desafío: ${_currentIndex + 1}/${_dueItems.length}',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: nt.surfaceCard,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _getQuestionText(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        anp.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                ..._options.map((option) => _buildOptionCard(nt, option)),
                const Spacer(),
                if (_answered)
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: nt.blueGoogle,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text(
                      'Siguiente',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getQuestionText() {
    switch (_currentQuestionType) {
      case _QuestionType.region:
        return '¿En qué región se encuentra?';
      case _QuestionType.useType:
        return '¿Cuál es su tipo de uso?';
      case _QuestionType.category:
        return '¿Cuál es la categoría de esta ANP?';
    }
  }

  Widget _buildOptionCard(NeuralThemeData nt, String option) {
    bool isSelected = _selectedAnswer == option;
    bool isCorrect = option == _correctAnswer;
    
    Color borderColor = Colors.white.withValues(alpha: 0.1);
    Color bgColor = nt.surfaceCard;
    
    if (_answered) {
      if (isCorrect) {
        borderColor = Colors.greenAccent;
        bgColor = Colors.greenAccent.withValues(alpha: 0.1);
      } else if (isSelected) {
        borderColor = Colors.redAccent;
        bgColor = Colors.redAccent.withValues(alpha: 0.1);
      }
    } else if (isSelected) {
      borderColor = nt.blueGoogle;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: _answered ? null : () => _submitAnswer(option),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  option,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              if (_answered && isCorrect)
                const Icon(Icons.check_circle_rounded, color: Colors.greenAccent),
              if (_answered && isSelected && !isCorrect)
                const Icon(Icons.cancel_rounded, color: Colors.redAccent),
            ],
          ),
        ),
      ),
    );
  }
}

enum _QuestionType {
  region,
  useType,
  category,
}

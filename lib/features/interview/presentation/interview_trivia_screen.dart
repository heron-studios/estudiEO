import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:learn/core/services/audio_service.dart';
import 'package:learn/core/services/gemini_service.dart';
import 'package:go_router/go_router.dart';

class InterviewTriviaScreen extends StatefulWidget {
  const InterviewTriviaScreen({super.key});

  @override
  State<InterviewTriviaScreen> createState() => _InterviewTriviaScreenState();
}

class _InterviewTriviaScreenState extends State<InterviewTriviaScreen> with TickerProviderStateMixin {
  // Configuración del Examen
  String _difficulty = 'all'; // all, easy, medium, hard
  String _questionSource = 'local'; // local, ai
  final Map<String, bool> _categories = {
    'pnp_institutional': true,
    'constitution_civics': true,
    'peruvian_history': true,
    'peruvian_geography': true,
    'current_affairs': true,
    'ethics_values': true,
  };

  final Map<String, String> _categoryNamesSp = {
    'pnp_institutional': 'Organización y Héroes PNP',
    'constitution_civics': 'Constitución y Cívica',
    'peruvian_history': 'Historia del Perú',
    'peruvian_geography': 'Geografía del Perú',
    'current_affairs': 'Actualidad y Autoridades',
    'ethics_values': 'Ética y Valores Policiales',
  };

  // Estados del Flujo
  bool _setupPhase = true;
  bool _isLoading = false;
  String _loadingMessage = '';
  String? _errorMessage;

  // Datos de Preguntas
  List<dynamic> _questions = [];
  int _currentIndex = 0;
  List<String> _shuffledOptions = [];
  String? _selectedOption;
  bool _isAnswered = false;
  bool _isTimeout = false;

  // Temporizador
  Timer? _timer;
  double _timerProgress = 1.0;
  final int _reactionTimeSeconds = 30;

  // Puntuación y Resultados
  int _correctCount = 0;
  int _incorrectCount = 0;
  int _timeoutCount = 0;
  int _skippedCount = 0;
  String? _aiFeedback;

  // Animaciones del Jurado
  late AnimationController _interviewerPulseController;
  late Animation<double> _interviewerScale;

  @override
  void initState() {
    super.initState();
    _interviewerPulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _interviewerScale = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _interviewerPulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _interviewerPulseController.dispose();
    super.dispose();
  }

  // Carga preguntas locales o las genera con la IA
  Future<void> _startExam() async {
    setState(() {
      _setupPhase = false;
      _isLoading = true;
      _errorMessage = null;
      _loadingMessage = _questionSource == 'local'
          ? 'Cargando balotario local PNP...'
          : 'Conectando con el Jurado con IA...';
    });

    try {
      List<dynamic> loadedQuestions = [];

      if (_questionSource == 'local') {
        // Carga offline desde assets/data/pnp_trivia.json
        final String response = await rootBundle.loadString('assets/data/pnp_trivia.json');
        final Map<String, dynamic> data = jsonDecode(response);
        final List<dynamic> rawQuestions = data['preguntas_pnp'] ?? [];

        // Filtrar por categorías seleccionadas y dificultad
        loadedQuestions = rawQuestions.where((q) {
          final cat = q['category'] ?? '';
          final diff = q['difficulty'] ?? '';
          final isCatSelected = _categories[cat] ?? false;
          final isDiffSelected = _difficulty == 'all' || diff == _difficulty;
          return isCatSelected && isDiffSelected;
        }).toList();

        // Mezclar y tomar un límite de 10
        loadedQuestions.shuffle();
        if (loadedQuestions.length > 10) {
          loadedQuestions = loadedQuestions.sublist(0, 10);
        }

        // Si por filtros rigurosos de dificultad no hay suficientes preguntas, cargamos cualquier 10 preguntas
        if (loadedQuestions.isEmpty) {
          final List<dynamic> fallback = List.from(rawQuestions)..shuffle();
          loadedQuestions = fallback.take(10).toList();
        }
      } else {
        // Generar preguntas mediante Gemini
        final activeCategoriesList = _categories.entries
            .where((e) => e.value)
            .map((e) => e.key)
            .toList();

        final rawQuestions = await GeminiService.generarPreguntasTriviaPNP(
          activeCategoriesList,
          _difficulty,
          10,
        );

        if (rawQuestions.isNotEmpty) {
          loadedQuestions = rawQuestions;
        } else {
          // Fallback a local si falla el API de Gemini (offline / sin API key)
          debugPrint('Fallo en generación con IA. Activando fallback local...');
          final String response = await rootBundle.loadString('assets/data/pnp_trivia.json');
          final Map<String, dynamic> data = jsonDecode(response);
          final List<dynamic> rawQuestionsLocal = data['preguntas_pnp'] ?? [];
          
          loadedQuestions = rawQuestionsLocal.where((q) {
            final cat = q['category'] ?? '';
            final isCatSelected = _categories[cat] ?? false;
            return isCatSelected;
          }).toList();
          
          loadedQuestions.shuffle();
          if (loadedQuestions.length > 10) {
            loadedQuestions = loadedQuestions.sublist(0, 10);
          }
          if (loadedQuestions.isEmpty) {
            loadedQuestions = (List.from(rawQuestionsLocal)..shuffle()).take(10).toList();
          }
        }
      }

      if (loadedQuestions.isEmpty) {
        throw Exception('No se encontraron preguntas en el balotario local.');
      }

      setState(() {
        _questions = loadedQuestions;
        _currentIndex = 0;
        _isLoading = false;
        _correctCount = 0;
        _incorrectCount = 0;
        _timeoutCount = 0;
        _skippedCount = 0;
        _setupQuestion();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'No se pudo iniciar el examen. Detalles: ${e.toString().split(':').last.trim()}.\nVerifica los recursos del sistema.';
      });
    }
  }

  void _setupQuestion() {
    if (_currentIndex >= _questions.length) {
      _finishExam();
      return;
    }

    final question = _questions[_currentIndex];
    final String correct = question['correctAnswer'];
    final List<String> incorrects = List<String>.from(question['incorrectAnswers']);

    setState(() {
      _shuffledOptions = [correct, ...incorrects];
      _shuffledOptions.shuffle();
      _selectedOption = null;
      _isAnswered = false;
      _isTimeout = false;
      _timerProgress = 1.0;
    });

    _interviewerPulseController.repeat(reverse: true);
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    final startTime = DateTime.now();

    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      final elapsed = DateTime.now().difference(startTime);
      final remainingMs = (_reactionTimeSeconds * 1000) - elapsed.inMilliseconds;

      if (remainingMs <= 0) {
        timer.cancel();
        _handleTimeout();
      } else {
        setState(() {
          _timerProgress = remainingMs / (_reactionTimeSeconds * 1000);
        });
        if (remainingMs < 3000 && remainingMs % 500 < 50) {
          HapticFeedback.lightImpact();
        }
      }
    });
  }

  void _handleTimeout() {
    if (_isAnswered) return;
    context.read<AudioService>().playIncorrectSound();
    HapticFeedback.vibrate();

    setState(() {
      _isAnswered = true;
      _isTimeout = true;
      _timeoutCount++;
    });
    _interviewerPulseController.stop();
  }

  void _selectOption(String option) {
    if (_isAnswered) return;
    _timer?.cancel();
    _interviewerPulseController.stop();

    final question = _questions[_currentIndex];
    final String correct = question['correctAnswer'];
    final bool correctSelected = option == correct;

    if (correctSelected) {
      context.read<AudioService>().playCorrectSound();
      _correctCount++;
    } else {
      context.read<AudioService>().playIncorrectSound();
      _incorrectCount++;
    }

    setState(() {
      _selectedOption = option;
      _isAnswered = true;
    });
  }

  void _skipQuestion() {
    if (_isAnswered) return;
    _timer?.cancel();
    _interviewerPulseController.stop();

    setState(() {
      _isAnswered = true;
      _selectedOption = null;
      _skippedCount++;
    });

    _nextQuestion();
  }

  void _nextQuestion() {
    setState(() {
      _currentIndex++;
    });
    _setupQuestion();
  }

  Future<void> _finishExam() async {
    setState(() {
      _isLoading = true;
      _loadingMessage = 'Generando feedback del jurado...';
    });

    try {
      final feedback = await GeminiService.generarFeedbackEntrevistaTrivia(_correctCount, _questions.length);
      setState(() {
        _aiFeedback = feedback;
      });
    } catch (e) {
      setState(() {
        _aiFeedback = '¡Buen esfuerzo! Continúa practicando tu cultura general para asegurar tu aptitud.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _resetToSetup() {
    setState(() {
      _setupPhase = true;
      _questions = [];
      _aiFeedback = null;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return NeuralBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            onPressed: () {
              if (_setupPhase) {
                context.pop();
              } else {
                _showExitWarning();
              }
            },
          ),
          title: const Text(
            'ENTREVISTA: CULTURA GENERAL',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 1.5,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: _isLoading
              ? _buildLoadingState(nt)
              : _errorMessage != null
                  ? _buildErrorState(nt)
                  : _setupPhase
                      ? _buildSetupPhase(nt)
                      : _questions.isEmpty
                          ? const SizedBox.shrink()
                          : _currentIndex < _questions.length
                              ? _buildActiveExam(nt, isDark)
                              : _buildResultsState(nt, isDark),
        ),
      ),
    );
  }

  // 1. Pantalla de carga
  Widget _buildLoadingState(NeuralThemeData nt) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.purpleAccent),
            const SizedBox(height: 24),
            Text(
              _loadingMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // 2. Pantalla de error
  Widget _buildErrorState(NeuralThemeData nt) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded, size: 64, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'Ocurrió un error desconocido.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _startExam,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Reintentar', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _resetToSetup,
              child: const Text('Volver a Configuración', style: TextStyle(color: Colors.white60)),
            ),
          ],
        ),
      ),
    );
  }

  // 3. Pantalla de configuración previa
  Widget _buildSetupPhase(NeuralThemeData nt) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Banner / Ilustración
              HoverGlassCard(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple.withValues(alpha: 0.1), Colors.deepPurple.withValues(alpha: 0.25)],
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.purple.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.purpleAccent.withValues(alpha: 0.3)),
                        ),
                        child: const Icon(Icons.record_voice_over_rounded, size: 40, color: Colors.purpleAccent),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Simulador de Balotario Oral',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Outfit'),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'En la entrevista personal de la PNP, el jurado realiza preguntas aleatorias para medir tus conocimientos de cultura general. Practica responder bajo presión.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Origen de Preguntas
              const Text('ORIGEN DE LAS PREGUNTAS', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.8)),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildSourceChip('local', 'Balotario Local', Icons.offline_pin_rounded, nt),
                  const SizedBox(width: 12),
                  _buildSourceChip('ai', 'Jurado con IA', Icons.psychology_rounded, nt),
                ],
              ),
              const SizedBox(height: 24),

              // Dificultad
              const Text('DIFICULTAD DEL EXAMEN', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.8)),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildDifficultyChip('all', 'Todos', nt),
                  const SizedBox(width: 8),
                  _buildDifficultyChip('easy', 'Fácil', nt),
                  const SizedBox(width: 8),
                  _buildDifficultyChip('medium', 'Medio', nt),
                  const SizedBox(width: 8),
                  _buildDifficultyChip('hard', 'Difícil', nt),
                ],
              ),
              const SizedBox(height: 24),

              // Categorías
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('TEMAS A EVALUAR', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.8)),
                  TextButton(
                    onPressed: _selectAllCategories,
                    child: const Text('Todos / Ninguno', style: TextStyle(color: Colors.purpleAccent, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categories.keys.map((cat) {
                  final isSelected = _categories[cat]!;
                  return FilterChip(
                    label: Text(_categoryNamesSp[cat]!),
                    selected: isSelected,
                    onSelected: (val) {
                      setState(() {
                        _categories[cat] = val;
                      });
                    },
                    selectedColor: Colors.purpleAccent.withValues(alpha: 0.25),
                    checkmarkColor: Colors.purpleAccent,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white60,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    ),
                    backgroundColor: Colors.white.withValues(alpha: 0.05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: isSelected ? Colors.purpleAccent.withValues(alpha: 0.5) : Colors.white10),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 36),

              // Iniciar
              ElevatedButton(
                onPressed: _startExam,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 8,
                  shadowColor: Colors.purpleAccent.withValues(alpha: 0.5),
                ),
                child: const Text('INICIAR SIMULACIÓN', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyChip(String val, String label, NeuralThemeData nt) {
    final isSelected = _difficulty == val;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _difficulty = val),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.purpleAccent.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.purpleAccent : Colors.white10,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white60,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSourceChip(String val, String label, IconData icon, NeuralThemeData nt) {
    final isSelected = _questionSource == val;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _questionSource = val),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? Colors.purpleAccent.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.purpleAccent : Colors.white10,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? Colors.purpleAccent : Colors.white60, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white60,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectAllCategories() {
    final anyActive = _categories.values.any((v) => v);
    setState(() {
      _categories.updateAll((key, value) => !anyActive);
    });
  }

  // 4. Examen Activo
  Widget _buildActiveExam(NeuralThemeData nt, bool isDark) {
    final question = _questions[_currentIndex];
    final String questionText = question['question']['text'];
    final String category = question['category'];
    final String difficulty = question['difficulty'];

    // Determinar color de la categoría
    Color categoryColor = Colors.purpleAccent;
    if (category == 'peruvian_history') categoryColor = Colors.amber;
    if (category == 'peruvian_geography') categoryColor = Colors.blueAccent;
    if (category == 'pnp_institutional') categoryColor = Colors.greenAccent;
    if (category == 'constitution_civics') categoryColor = Colors.redAccent;
    if (category == 'current_affairs') categoryColor = Colors.orangeAccent;
    if (category == 'ethics_values') categoryColor = Colors.tealAccent;

    // Rango dinámico del Jurado según dificultad
    String rankName = 'Coronel PNP';
    if (difficulty == 'easy') rankName = 'Mayor PNP';
    if (difficulty == 'medium') rankName = 'Comandante PNP';
    if (difficulty == 'hard') rankName = 'Coronel PNP';

    // Discurso realista del jurado
    String jurySpeech;
    Color speechColor = Colors.white;
    if (_isTimeout) {
      jurySpeech = '«¡Tiempo agotado, postulante! En la Policía la indecisión cuesta vidas. No responder a tiempo demuestra falta de preparación táctica y mental. Siguiente pregunta.»';
      speechColor = Colors.redAccent;
    } else if (_isAnswered) {
      if (_selectedOption == null) {
        jurySpeech = '«Ha decidido evadir la pregunta. Un oficial de policía debe afrontar los retos, no evadirlos. La respuesta correcta era: ${question['correctAnswer']}.»';
        speechColor = Colors.orangeAccent;
      } else {
        final bool correctSelected = _selectedOption == question['correctAnswer'];
        if (correctSelected) {
          jurySpeech = '«Respuesta conforme, postulante. Demuestra conocimiento e instrucción. Prosiga con firmeza.»';
          speechColor = nt.successGreen;
        } else {
          jurySpeech = '«¡Incorrecto! Esa respuesta es errónea. Un error de conocimiento constitucional o de doctrina policial es inadmisible en nuestro servicio. La respuesta correcta es: ${question['correctAnswer']}.»';
          speechColor = Colors.orangeAccent;
        }
      }
    } else {
      jurySpeech = '«Postulante, responda con firmeza la siguiente interrogante: $questionText»';
      speechColor = Colors.white;
    }

    return Column(
      children: [
        // Temporizador lineal
        _buildTimerBar(nt),

        // Barra de Progreso
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: categoryColor.withValues(alpha: 0.4)),
                ),
                child: Text(
                  _categoryNamesSp[category]?.toUpperCase() ?? category.toUpperCase(),
                  style: TextStyle(color: categoryColor, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1.0),
                ),
              ),
              Text(
                'Pregunta ${_currentIndex + 1} de ${_questions.length}',
                style: const TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        // Área Central: Entrevistador + Burbuja
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Entrevistador
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _interviewerScale,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _interviewerScale.value,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Colors.purpleAccent, Colors.deepPurple],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purpleAccent.withValues(alpha: 0.3),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                )
                              ],
                            ),
                            child: const Center(
                              child: Icon(Icons.security_rounded, color: Colors.white, size: 30),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'JURADO EVALUADOR',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 1.2),
                        ),
                        Text(
                          'Rango: $rankName • Dificultad: ${difficulty.toUpperCase()}',
                          style: const TextStyle(color: Colors.white54, fontSize: 9),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Burbuja de la Pregunta
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? nt.surfaceCard : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                      bottomLeft: Radius.circular(4),
                    ),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Text(
                    jurySpeech,
                    style: TextStyle(
                      color: speechColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Opciones de respuesta
                ..._shuffledOptions.map((opt) => _buildOptionCard(opt, question['correctAnswer'], nt)),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),

        // Barra inferior de navegación
        _buildBottomActionBar(nt),
      ],
    );
  }

  Widget _buildTimerBar(NeuralThemeData nt) {
    Color timerColor = _timerProgress < 0.25 ? Colors.redAccent : Colors.purpleAccent;
    return Container(
      width: double.infinity,
      height: 4,
      color: Colors.white10,
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: _timerProgress,
        child: Container(color: timerColor),
      ),
    );
  }

  Widget _buildOptionCard(String option, String correctAnswer, NeuralThemeData nt) {
    final bool isCorrect = option == correctAnswer;
    final bool isSelected = _selectedOption == option;

    Color cardBorderColor = Colors.white.withValues(alpha: 0.1);
    Color cardBgColor = Colors.white.withValues(alpha: 0.03);
    Widget? iconSuffix;

    if (_isAnswered) {
      if (isCorrect) {
        cardBorderColor = nt.successGreen.withValues(alpha: 0.6);
        cardBgColor = nt.successGreen.withValues(alpha: 0.1);
        iconSuffix = Icon(Icons.check_circle_rounded, color: nt.successGreen, size: 20);
      } else if (isSelected) {
        cardBorderColor = Colors.redAccent.withValues(alpha: 0.6);
        cardBgColor = Colors.redAccent.withValues(alpha: 0.1);
        iconSuffix = const Icon(Icons.cancel_rounded, color: Colors.redAccent, size: 20);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => _selectOption(option),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: cardBgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cardBorderColor, width: 1.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  option,
                  style: TextStyle(
                    color: _isAnswered && !isCorrect && !isSelected ? Colors.white38 : Colors.white,
                    fontSize: 14,
                    fontWeight: isSelected || (_isAnswered && isCorrect) ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              if (iconSuffix != null) ...[
                const SizedBox(width: 10),
                iconSuffix,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActionBar(NeuralThemeData nt) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
      ),
      child: Row(
        children: [
          if (!_isAnswered) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: _skipQuestion,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white24),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('SALTAR PREGUNTA', style: TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ),
          ] else ...[
            Expanded(
              child: ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  _currentIndex < _questions.length - 1 ? 'SIGUIENTE PREGUNTA' : 'VER RESULTADOS',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  // 5. Pantalla de Resultados
  Widget _buildResultsState(NeuralThemeData nt, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Encabezado
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? nt.surfaceCard : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.analytics_rounded, size: 50, color: Colors.purpleAccent),
                    const SizedBox(height: 12),
                    const Text('RESUMEN DE EVALUACIÓN', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                    const SizedBox(height: 20),
                    _buildResultRow('Correctas', '$_correctCount', nt.successGreen),
                    const Divider(color: Colors.white10),
                    _buildResultRow('Incorrectas', '$_incorrectCount', Colors.redAccent),
                    const Divider(color: Colors.white10),
                    _buildResultRow('Sin responder (Timeout)', '$_timeoutCount', Colors.orangeAccent),
                    const Divider(color: Colors.white10),
                    _buildResultRow('Saltadas', '$_skippedCount', Colors.grey),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Retroalimentación de la evaluación
              if (_aiFeedback != null) ...[
                StaticGlassContainer(
                  padding: const EdgeInsets.all(20),
                  borderRadius: BorderRadius.circular(24),
                  borderColor: Colors.purpleAccent.withValues(alpha: 0.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.purple.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.psychology_rounded, color: Colors.purpleAccent, size: 20),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'RETROALIMENTACIÓN DE IA',
                            style: TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 0.8),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        _aiFeedback!,
                        style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
              ],

              // Botones de salida
              ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('FINALIZAR Y VOLVER', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _resetToSetup,
                child: const Text('Realizar otra simulación', style: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
          Text(value, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  void _showExitWarning() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1F20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('¿Abandonar Simulación?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text(
          'Si sales ahora, perderás el progreso de esta entrevista de cultura general.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Continuar', style: TextStyle(color: Colors.purpleAccent)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Salir', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

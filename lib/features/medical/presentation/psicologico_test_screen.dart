import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';

class PsicologicoTestScreen extends StatefulWidget {
  const PsicologicoTestScreen({super.key});

  @override
  State<PsicologicoTestScreen> createState() => _PsicologicoTestScreenState();
}

class _PsicologicoTestScreenState extends State<PsicologicoTestScreen> {
  final List<String> _questions = [
    'No me interesan los problemas de los demás',
    'Creo que la ley no se debe cumplir estrictamente, si la puedo evadir lo hago',
    'Constantemente siento que no soy capaz de hacer frente a las cosas nuevas',
    'En muchas ocasiones suelo precipitarme',
    'Con cierta regularidad le gusta mantener distancia con los demás',
    'A veces pongo trabas a las opiniones de otras personas',
    'Raramente evito a las multitudes',
    'Con poca frecuencia se cómo debo hacer las cosas',
    'Suelo dejar mis decisiones en manos del grupo',
    'Por lo general, no me siento a gusto conmigo mismo',
    'Espero que los demás tomen el liderazgo',
    'No entiendo a la gente sentimental',
    'Me afectan las situaciones sociales difíciles',
    'Dedico poco tiempo y esfuerzo a mi trabajo',
    'Raramente me tomo mi revancha con los demás',
    'Soy incapaz de controlar mis deseos',
    'Siempre suelo hablar de mis cualidades a los demás',
    'Me gusta la acción y el peligro',
    'Siempre miro el lado bueno de la vida',
    'Me considero una persona incapaz de controlar mis deseos',
    'Rompo mis promesas con regularidad',
    'Siempre desconfio de la gente',
    'Me gusta abstraerme',
    'Me importa no hacer cosas ilegales',
    'Con mucha frecuencia dejo volar mi imaginación',
    'Me encanta experimentar de manera frecuente sensaciones fuertes',
    '¿Es impaciente por el ritmo en el que se desarrollan los acontecimientos?',
    'Terminas las frases de otras personas',
    'En el amor y la Guerra todo vale',
    'Me es difícil consumir drogas',
    'Si las drogas serían legales las consumiría',
    'Postulo a la PNP por rechazo de mis padres',
    'No es cierto que nuca he robado',
    'No es cierto que nunca he mentido',
    'Es cierto que no he consumido drogas',
    'Es cierto que no rompo las reglas',
    'Me interesa el sexo',
  ];

  int _currentIndex = 0;
  final Map<int, bool> _answers = {}; // true = SI, false = NO

  static const int _totalTimeInSeconds = 10 * 60; // 10 minutes
  int _secondsRemaining = _totalTimeInSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
        _showTimeUpDialog();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1F20),
          title: const Text('¡Tiempo agotado!', style: TextStyle(color: Colors.white)),
          content: const Text(
            'El tiempo para el Test Psicológico ha finalizado.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.pop();
              },
              child: const Text('Entendido', style: TextStyle(color: Colors.cyan)),
            ),
          ],
        );
      },
    );
  }

  void _answerQuestion(bool isYes) {
    setState(() {
      _answers[_currentIndex] = isYes;
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
      } else {
        _timer?.cancel();
        _showFinishDialog();
      }
    });
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1F20),
          title: const Text('¡Test Completado!', style: TextStyle(color: Colors.white)),
          content: Text(
            'Has respondido ${_answers.length} de ${_questions.length} preguntas.\\nFalta configurar la lógica de resultados.',
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.pop();
              },
              child: const Text('Volver al Menú', style: TextStyle(color: Colors.cyan)),
            ),
          ],
        );
      },
    );
  }

  String get _formattedTime {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    final double progress = (_currentIndex + 1) / _questions.length;

    return NeuralBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded, color: Colors.white),
            onPressed: () {
              _timer?.cancel();
              context.pop();
            },
          ),
          title: const Text(
            'Test Psicológico',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Outfit'),
          ),
          centerTitle: true,
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _secondsRemaining < 60 ? Colors.redAccent.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _secondsRemaining < 60 ? Colors.redAccent : Colors.transparent),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.timer_outlined, color: _secondsRemaining < 60 ? Colors.redAccent : Colors.white, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        _formattedTime,
                        style: TextStyle(
                          color: _secondsRemaining < 60 ? Colors.redAccent : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(nt.cyan),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Pregunta ${_currentIndex + 1} de ${_questions.length}',
                    style: const TextStyle(color: Colors.white54, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 1),
                  StaticGlassContainer(
                    padding: const EdgeInsets.all(32),
                    borderRadius: BorderRadius.circular(24),
                    borderColor: nt.cyan.withValues(alpha: 0.3),
                    child: Text(
                      _questions[_currentIndex],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(flex: 1),
                  Row(
                    children: [
                      Expanded(
                        child: _buildAnswerButton(
                          title: 'SÍ',
                          color: nt.successGreen,
                          icon: Icons.check_rounded,
                          onTap: () => _answerQuestion(true),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildAnswerButton(
                          title: 'NO',
                          color: nt.pink,
                          icon: Icons.close_rounded,
                          onTap: () => _answerQuestion(false),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerButton({
    required String title,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 36),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Outfit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

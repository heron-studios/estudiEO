import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';

class EysenckTestScreen extends StatefulWidget {
  const EysenckTestScreen({super.key});

  @override
  State<EysenckTestScreen> createState() => _EysenckTestScreenState();
}

class _EysenckTestScreenState extends State<EysenckTestScreen> {
  final List<String> _questions = [
    '¿Le gusta la abundancia de excitación y bullicio a su alrededor?',
    '¿Tiene a menudo un sentimiento de intranquilidad, como si quisiera algo, pero sin saber qué?',
    '¿Tiene casi siempre una contestación lista "a la mano" cuando se le habla?',
    '¿Se siente algunas veces feliz, otras triste sin una razón real?',
    '¿Permanece usualmente retraído (a) en fiestas y reuniones?',
    '¿Cuando niño (a) hacía siempre inmediatamente lo que le decían sin renegar?',
    '¿Se enfada a menudo?',
    'Cuando lo (a) meten en una pelea, ¿prefiere "sacar los trapos al aire" de una vez por todas, en vez de quedar callado (a) esperando que las cosas se calmen solas?',
    '¿Es usted triste, melancólico (a)?',
    '¿Le gusta mezclarse con la gente?',
    '¿Ha perdido a menudo el sueño por sus preocupaciones?',
    '¿Se pone a veces malhumorado (a)?',
    '¿Se catalogaría a sí mismo(a) como despreocupado(a) o confiado a su suerte?',
    '¿Se decide a menudo demasiado tarde?',
    '¿Le gusta trabajar solo (a)?',
    '¿Se ha sentido a menudo apático (a) y cansado (a) sin razón?',
    '¿Es por el contrario animado (a) y jovial?',
    '¿Se ríe a menudo de chistes groseros?',
    '¿Se siente a menudo hastiado (a)?',
    '¿Se siente incómodo (a) con vestidos que no son del diario?',
    '¿Se distrae (fantasea) a menudo cuando trata de prestar atención a algo?',
    '¿Puede expresar en palabras fácilmente lo que piensa?',
    '¿Se abstrae (se pierde en sus pensamientos) a menudo?',
    '¿Está completamente libre de prejuicios de cualquier tipo?',
    '¿Le gustan las bromas?',
    '¿Piensa a menudo en su pasado?',
    '¿Le gusta la buena comida?',
    'Cuando se fastidia, ¿necesita de algún(a) amigo(a) para hablar sobre ello?',
    '¿Le molesta vender cosas o pedir dinero a la gente para alguna buena causa?',
    '¿Alardea (se jacta) un poco a veces?',
    '¿Es usted muy susceptible por algunas cosas?',
    '¿Le gusta más quedarse en casa que ir a una fiesta aburrida?',
    '¿Se pone a menudo inquieto que no puede permanecer sentado durante mucho rato en una silla?',
    '¿Le gusta planear las cosas cuidadosamente con mucha anticipación?',
    '¿Tiene a menudo mareos (vértigos)?',
    '¿Contesta siempre una carta personal, tan pronto como puede, después de haberla leído?',
    '¿Hace usted usualmente las cosas mejor resolviéndolas solo(a) que hablando a otros sobre ellas?',
    '¿Le falta frecuentemente aire, sin haber hecho un trabajo pesado?',
    '¿Es usted generalmente una persona tolerante, que no se molesta si las cosas no están perfectas?',
    '¿Sufre de los "nervios"?',
    '¿Le gustaría más planear que hacer cosas?',
    '¿Deja algunas veces para mañana, lo que debería hacer hoy día?',
    '¿Se pone nervioso(a) en lugares tales como ascensores, trenes o túneles?',
    'Cuando hace nuevos amigos, ¿es usted quien inicia la relación o invita a que se produzca?',
    '¿Sufre fuertes dolores de cabeza?',
    '¿Siente generalmente que las cosas se arreglarán por sí solas y que terminarán bien de algún modo?',
    '¿Le cuesta trabajo coger el sueño al acostarse en las noches?',
    '¿Ha dicho alguna vez mentiras en su vida?',
    '¿Dice algunas veces lo primero que se le viene a la cabeza?',
    '¿Se preocupa durante un tiempo demasiado largo, después de una experiencia embarazosa?',
    '¿Se mantiene usualmente hermético (a) o encerrado (a) en sí mismo (a), excepto con amigos muy íntimos?',
    '¿Se crea a menudo problemas por hacer cosas sin pensar?',
    '¿Le gusta contar chistes y referir historias graciosas a sus amigos?',
    '¿Se le hace más difícil ganar que perder un juego?',
    '¿Se siente a menudo demasiado consciente de sí mismo(a) o poco natural cuando está con superiores?',
    'Cuando todas las probabilidades están contra usted, ¿piensa aun usualmente que vale la pena probar suerte?',
    '¿Siente "sensaciones" raras en el abdomen, antes de algún hecho importante?',
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
            'El tiempo para el test de Eysenck ha finalizado.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                context.pop(); // Go back to medical dashboard
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
        // Finished
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
            'Has respondido ${_answers.length} de ${_questions.length} preguntas.\\nFalta configurar el cálculo de dimensiones E, N, P.',
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
            'Test de Eysenck',
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

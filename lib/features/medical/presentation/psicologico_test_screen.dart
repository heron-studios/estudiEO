import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';

class PsicologicoQuestion {
  final String text;
  final bool expectedAnswer;
  final String explanation;

  PsicologicoQuestion(this.text, this.expectedAnswer, this.explanation);
}

class PsicologicoTestScreen extends StatefulWidget {
  const PsicologicoTestScreen({super.key});

  @override
  State<PsicologicoTestScreen> createState() => _PsicologicoTestScreenState();
}

class _PsicologicoTestScreenState extends State<PsicologicoTestScreen> {
  final List<PsicologicoQuestion> _questions = [
    PsicologicoQuestion('No me interesan los problemas de los demás', false, 'La empatía y vocación de servicio son fundamentales en la función policial/militar.'),
    PsicologicoQuestion('Creo que la ley no se debe cumplir estrictamente, si la puedo evadir lo hago', false, 'Un efectivo debe ser el principal garante y cumplidor de la ley.'),
    PsicologicoQuestion('Constantemente siento que no soy capaz de hacer frente a las cosas nuevas', false, 'Se busca seguridad en sí mismo y capacidad de adaptación ante nuevos retos.'),
    PsicologicoQuestion('En muchas ocasiones suelo precipitarme', false, 'La impulsividad es negativa; se debe actuar con serenidad y criterio analítico.'),
    PsicologicoQuestion('Con cierta regularidad le gusta mantener distancia con los demás', false, 'El trabajo operativo es en equipo y requiere altos niveles de sociabilidad.'),
    PsicologicoQuestion('A veces pongo trabas a las opiniones de otras personas', false, 'Demuestra falta de tolerancia y genera conflictos para el trabajo en equipo.'),
    PsicologicoQuestion('Raramente evito a las multitudes', true, 'Se trabaja constantemente en contacto masivo con el público; evitar multitudes es desfavorable.'),
    PsicologicoQuestion('Con poca frecuencia se cómo debo hacer las cosas', false, 'Refleja inseguridad y falta de iniciativa, rasgos desfavorables para la toma de decisiones.'),
    PsicologicoQuestion('Suelo dejar mis decisiones en manos del grupo', false, 'Un postulante debe tener autonomía, criterio propio y capacidad de liderazgo.'),
    PsicologicoQuestion('Por lo general, no me siento a gusto conmigo mismo', false, 'Refleja problemas de autoestima o inestabilidad emocional que afectan el desempeño.'),
    PsicologicoQuestion('Espero que los demás tomen el liderazgo', false, 'En las fuerzas del orden se valora fuertemente la proactividad y la iniciativa.'),
    PsicologicoQuestion('No entiendo a la gente sentimental', false, 'Refleja falta de empatía o frialdad emocional hacia los ciudadanos.'),
    PsicologicoQuestion('Me afectan las situaciones sociales difíciles', false, 'Se requiere gran resiliencia emocional para lidiar con situaciones críticas a diario.'),
    PsicologicoQuestion('Dedico poco tiempo y esfuerzo a mi trabajo', false, 'Muestra irresponsabilidad y falta de compromiso, actitudes inaceptables.'),
    PsicologicoQuestion('Raramente me tomo mi revancha con los demás', true, 'El rencor y la venganza son negativos; se debe actuar por justicia y racionalidad.'),
    PsicologicoQuestion('Soy incapaz de controlar mis deseos', false, 'Refleja falta de autocontrol e impulsividad, un rasgo muy peligroso al portar un arma.'),
    PsicologicoQuestion('Siempre suelo hablar de mis cualidades a los demás', false, 'Denota egocentrismo o complejo de superioridad; la institución valora la humildad.'),
    PsicologicoQuestion('Me gusta la acción y el peligro', false, 'Buscar el peligro innecesariamente indica temeridad imprudente, no valentía controlada.'),
    PsicologicoQuestion('Siempre miro el lado bueno de la vida', true, 'Refleja optimismo, estabilidad emocional y buena resiliencia ante la adversidad.'),
    PsicologicoQuestion('Me considero una persona incapaz de controlar mis deseos', false, 'La falta de control de impulsos es uno de los principales criterios de exclusión.'),
    PsicologicoQuestion('Rompo mis promesas con regularidad', false, 'Demuestra falta de integridad, deshonestidad y nula confiabilidad personal.'),
    PsicologicoQuestion('Siempre desconfio de la gente', false, 'La paranoia o suspicacia extrema dificultan las relaciones y el servicio a la comunidad.'),
    PsicologicoQuestion('Me gusta abstraerme', false, 'Se debe estar siempre alerta y conectado con su entorno (conciencia situacional).'),
    PsicologicoQuestion('Me importa no hacer cosas ilegales', true, 'Respetar la legalidad y tener una brújula moral fuerte es el requisito innegociable.'),
    PsicologicoQuestion('Con mucha frecuencia dejo volar mi imaginación', false, 'Se requiere pensamiento práctico, realista y enfocado; la distracción constante es un riesgo.'),
    PsicologicoQuestion('Me encanta experimentar de manera frecuente sensaciones fuertes', false, 'Indica búsqueda de riesgo (thrill-seeking), asociado a inestabilidad e imprudencia.'),
    PsicologicoQuestion('¿Es impaciente por el ritmo en el que se desarrollan los acontecimientos?', false, 'La impaciencia denota poco control emocional y baja tolerancia a la frustración.'),
    PsicologicoQuestion('Terminas las frases de otras personas', false, 'Demuestra ansiedad, impaciencia y falta de escucha activa hacia el interlocutor.'),
    PsicologicoQuestion('En el amor y la Guerra todo vale', false, 'El fin no justifica los medios. Siempre se debe actuar respetando los Derechos Humanos.'),
    PsicologicoQuestion('Me es difícil consumir drogas', true, 'El rechazo firme al consumo de sustancias ilícitas es un perfil obligatorio.'),
    PsicologicoQuestion('Si las drogas serían legales las consumiría', false, 'Indica propensión a las adicciones frenada únicamente por el miedo al castigo legal.'),
    PsicologicoQuestion('Postulo a la PNP por rechazo de mis padres', false, 'La motivación debe ser netamente vocacional, no una vía de escape a presiones externas.'),
    PsicologicoQuestion('No es cierto que nuca he robado', false, 'Admitir un robo es causal de exclusión. El historial de integridad debe ser intachable.'),
    PsicologicoQuestion('No es cierto que nunca he mentido', true, 'Pregunta de sinceridad. Todos han mentido alguna vez; negarlo rotundamente te marca como alguien que finge perfección (escala de mentira).'),
    PsicologicoQuestion('Es cierto que no he consumido drogas', true, 'Confirmación directa de un perfil limpio, libre de adicciones.'),
    PsicologicoQuestion('Es cierto que no rompo las reglas', true, 'Refleja tu disposición a acatar las normas y la disciplina institucional.'),
    PsicologicoQuestion('Me interesa el sexo', true, 'Es una función fisiológica normal. Negarlo suele interpretarse como falsedad en el test de sinceridad.'),
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
    bool isCorrect = _questions[_currentIndex].expectedAnswer == isYes;
    _timer?.cancel(); // Pausamos el timer para que lea la explicación tranquilo

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final nt = NeuralTheme.of(context);
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1F20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: isCorrect ? nt.successGreen : nt.pink, width: 2)),
          title: Row(
            children: [
              Icon(isCorrect ? Icons.check_circle_outline : Icons.cancel_outlined,
                  color: isCorrect ? nt.successGreen : nt.pink, size: 28),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  isCorrect ? '¡Respuesta Ideal!' : 'Cuidado con esta respuesta',
                  style: TextStyle(color: isCorrect ? nt.successGreen : nt.pink, fontSize: 18),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Respondiste: ${isYes ? "SÍ" : "NO"}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Text(
                _questions[_currentIndex].explanation,
                style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.4),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el popup
                setState(() {
                  _answers[_currentIndex] = isYes;
                  if (_currentIndex < _questions.length - 1) {
                    _currentIndex++;
                    _startTimer(); // Reanuda el timer
                  } else {
                    _showFinishDialog();
                  }
                });
              },
              child: const Text('Entendido -> Continuar',
                  style: TextStyle(color: Colors.cyan, fontSize: 16)),
            ),
          ],
        );
      },
    );
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
                      _questions[_currentIndex].text,
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

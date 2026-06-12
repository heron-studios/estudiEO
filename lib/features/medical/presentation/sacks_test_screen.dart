import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';

class SacksTestScreen extends StatefulWidget {
  const SacksTestScreen({super.key});

  @override
  State<SacksTestScreen> createState() => _SacksTestScreenState();
}

class SacksQuestion {
  final int number;
  final String text;
  final String optionA;
  final String optionB;
  final String explanationA;
  final String explanationB;
  final bool isAApt;
  final bool isBApt;

  SacksQuestion({
    required this.number,
    required this.text,
    required this.optionA,
    required this.optionB,
    required this.explanationA,
    required this.explanationB,
    required this.isAApt,
    required this.isBApt,
  });
}

class _SacksTestScreenState extends State<SacksTestScreen> {
  // Only questions 1 and 15 provided so far
  final List<SacksQuestion> _questions = [
    SacksQuestion(
      number: 1,
      text: 'Me habría gustado que mi padre:',
      optionA: 'fuera siempre mi guía y ejemplo de trabajo.',
      explanationA: 'Bien: Refleja respeto a la autoridad y valores heredados.',
      isAApt: true,
      optionB: 'hubiera estado más tiempo conmigo.',
      explanationB: 'Mal: Refleja carencia afectiva o resentimiento que puede afectar tu madurez.',
      isBApt: false,
    ),
    SacksQuestion(
      number: 15,
      text: 'La mayoría de los jefes:',
      optionA: 'son líderes que orientan el cumplimiento de las metas.',
      explanationA: 'Bien: Refleja subordinación y disposición al trabajo.',
      isAApt: true,
      optionB: 'son personas autoritarias que abusan.',
      explanationB: 'Mal: Indica que serás un elemento conflictivo y rebelde.',
      isBApt: false,
    ),
    SacksQuestion(
      number: 18,
      text: 'Si mi padre solamente:',
      optionA: 'pudiera ver todos mis logros alcanzados.',
      explanationA: 'Bien: Muestra deseo de superación y gratitud.',
      isAApt: true,
      optionB: 'no hubiera sido tan estricto.',
      explanationB: 'Mal: Revela conflictos no superados con la autoridad.',
      isBApt: false,
    ),
    SacksQuestion(
      number: 32,
      text: 'Las personas que tienen autoridad:',
      optionA: 'merecen respeto y obediencia según las normas.',
      explanationA: 'Bien: Fundamental para el perfil policial.',
      isAApt: true,
      optionB: 'a veces se aprovechan de su cargo.',
      explanationB: 'Mal: Muestra prejuicio y desconfianza hacia la jerarquía.',
      isBApt: false,
    ),
    SacksQuestion(
      number: 35,
      text: 'Pienso que mi padre:',
      optionA: 'es un hombre trabajador y un ejemplo de perseverancia.',
      explanationA: 'Bien: Identificación con valores positivos.',
      isAApt: true,
      optionB: 'fue muy duro con nosotros.',
      explanationB: 'Mal: Proyecta resentimiento.',
      isBApt: false,
    ),
    SacksQuestion(
      number: 43,
      text: 'Las madres deben:',
      optionA: 'ser el pilar de afecto y valores en el hogar.',
      explanationA: 'Bien: Concepto sano de la familia.',
      isAApt: true,
      optionB: 'dejar de ser tan controladoras.',
      explanationB: 'Mal: Refleja asfixia emocional o falta de autonomía.',
      isBApt: false,
    ),
    SacksQuestion(
      number: 52,
      text: 'Si por algo me acuerdo de mi padre es porque:',
      optionA: 'me enseñó la importancia de la responsabilidad.',
      explanationA: 'Bien: Valores alineados a la institución.',
      isAApt: true,
      optionB: 'comprarse cosas y viajar.',
      explanationB: 'Mal: Visión superficial.',
      isBApt: false,
    ),
    SacksQuestion(
      number: 3,
      text: 'Pienso que las relaciones sexuales:',
      optionA: 'son parte importante de la vida en pareja con responsabilidad.',
      explanationA: 'Bien: Madurez.',
      isAApt: true,
      optionB: 'son solo para satisfacer instintos.',
      explanationB: 'Mal: Impulsividad.',
      isBApt: false,
    ),
    SacksQuestion(
      number: 12,
      text: 'Mi esposa (o) / Novia (o):',
      optionA: 'es mi apoyo para mi crecimiento personal.',
      explanationA: 'Bien: Relación estable.',
      isAApt: true,
      optionB: 'siempre me está reclamando cosas.',
      explanationB: 'Mal: Conflicto en el entorno íntimo que genera estrés laboral.',
      isBApt: false,
    ),
    SacksQuestion(
      number: 20,
      text: 'Lo que me disgusta de lo sexual:',
      optionA: 'es la falta de respeto o valores en la relación.',
      explanationA: 'Bien: Ética personal.',
      isAApt: true,
      optionB: 'que sea algo sucio.',
      explanationB: 'Mal: Represión o traumas.',
      isBApt: false,
    ),
    SacksQuestion(
      number: 37,
      text: 'Temo que las relaciones sexuales:',
      optionA: 'sin responsabilidad traigan consecuencias negativas.',
      explanationA: 'Bien: Prudencia.',
      isAApt: true,
      optionB: 'me causen alguna enfermedad.',
      explanationB: 'Mal: Ansiedad o hipocondría.',
      isBApt: false,
    ),
    SacksQuestion(
      number: 63,
      text: 'La mayoría de las esposas (os):',
      optionA: 'son el apoyo fundamental para el desarrollo familiar.',
      explanationA: 'Bien: Visión positiva.',
      isAApt: true,
      optionB: 'solo buscan que el marido les dé dinero.',
      explanationB: 'Mal: Prejuicio y cinismo.',
      isBApt: false,
    ),
  ];

  int _currentIndex = 0;
  bool _answered = false;
  bool _selectedA = false;

  void _selectOption(bool isA) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _selectedA = isA;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _answered = false;
      });
    } else {
      _showFinishDialog();
    }
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1F20),
          title: const Text('¡Test Completado!', style: TextStyle(color: Colors.white)),
          content: const Text(
            'Has completado la sección de Autoridad y Figuras Paternas.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.pop();
              },
              child: const Text('Volver al Menú', style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    final currentQ = _questions[_currentIndex];

    return NeuralBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            'Frases de Sacks',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Outfit'),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: nt.blueGoogle.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Área: Autoridad y Figuras Paternas',
                      style: TextStyle(color: nt.blueGoogle, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Pregunta ${currentQ.number}',
                    style: const TextStyle(color: Colors.white54, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  StaticGlassContainer(
                    padding: const EdgeInsets.all(24),
                    borderRadius: BorderRadius.circular(20),
                    borderColor: nt.blueGoogle.withValues(alpha: 0.3),
                    child: Text(
                      currentQ.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildOptionCard(
                    isA: true,
                    text: currentQ.optionA,
                    explanation: currentQ.explanationA,
                    isApt: currentQ.isAApt,
                    nt: nt,
                  ),
                  const SizedBox(height: 16),
                  _buildOptionCard(
                    isA: false,
                    text: currentQ.optionB,
                    explanation: currentQ.explanationB,
                    isApt: currentQ.isBApt,
                    nt: nt,
                  ),
                  const SizedBox(height: 40),
                  if (_answered)
                    ElevatedButton(
                      onPressed: _nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: nt.blueGoogle,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        _currentIndex < _questions.length - 1 ? 'SIGUIENTE PREGUNTA' : 'FINALIZAR',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required bool isA,
    required String text,
    required String explanation,
    required bool isApt,
    required NeuralThemeData nt,
  }) {
    bool isSelected = _answered && (_selectedA == isA);
    bool showFeedback = _answered && isSelected;

    Color baseColor = Colors.white.withValues(alpha: 0.1);
    Color borderColor = Colors.white.withValues(alpha: 0.2);

    if (showFeedback) {
      baseColor = isApt ? nt.successGreen.withValues(alpha: 0.2) : nt.pink.withValues(alpha: 0.2);
      borderColor = isApt ? nt.successGreen : nt.pink;
    } else if (_answered) {
      // Not selected, dim it
      baseColor = Colors.transparent;
      borderColor = Colors.white.withValues(alpha: 0.05);
    }

    return InkWell(
      onTap: () => _selectOption(isA),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: showFeedback ? 2 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    isA ? 'A' : 'B',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: _answered && !isSelected ? Colors.white30 : Colors.white,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
                if (showFeedback)
                  Icon(
                    isApt ? Icons.check_circle_rounded : Icons.cancel_rounded,
                    color: isApt ? nt.successGreen : nt.pink,
                  ),
              ],
            ),
            if (showFeedback) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline_rounded, color: isApt ? nt.successGreen : nt.pink, size: 18),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        explanation,
                        style: TextStyle(
                          color: isApt ? nt.successGreen : nt.pink,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

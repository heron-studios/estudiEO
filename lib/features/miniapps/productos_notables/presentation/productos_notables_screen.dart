import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

// ─── Data Models ────────────────────────────────────────────────────────────

class FormulaBlock {
  final String id;
  final String label;
  final Color baseColor;
  final double w, h, x, y;
  final int order;
  final String? sign;
  final String guide;
  final String termText;

  const FormulaBlock({
    required this.id,
    required this.label,
    required this.baseColor,
    required this.w,
    required this.h,
    required this.x,
    required this.y,
    required this.order,
    this.sign,
    required this.guide,
    required this.termText,
  });
}

class FormulaConfig {
  final String key;
  final String title;
  final String eqTitle;
  final double size;
  final List<FormulaBlock> blocks;
  final String initialGuide;
  final String finalLabel;
  final String finalFormula;
  final String finalSub;
  final String doneGuide;
  final List<Map<String, dynamic>> sideLabels;
  final String? nextTab;
  final String examTip;
  final String category;

  const FormulaConfig({
    required this.key,
    required this.title,
    required this.eqTitle,
    required this.size,
    required this.blocks,
    required this.initialGuide,
    required this.finalLabel,
    required this.finalFormula,
    required this.finalSub,
    required this.doneGuide,
    required this.sideLabels,
    this.nextTab,
    required this.examTip,
    required this.category,
  });
}

// ─── Screen ─────────────────────────────────────────────────────────────────

class ProductosNotablesScreen extends StatefulWidget {
  const ProductosNotablesScreen({super.key});

  @override
  State<ProductosNotablesScreen> createState() =>
      _ProductosNotablesScreenState();
}

class _ProductosNotablesScreenState extends State<ProductosNotablesScreen>
    with TickerProviderStateMixin {
  // ── Formula data ──────────────────────────────────────────────────────────
  static const Map<String, FormulaConfig> _formulas = {
    'sum': FormulaConfig(
      key: 'sum',
      title: '(a+b)²',
      category: 'Cuadrados',
      eqTitle: 'Área total = (a + b)² =',
      size: 210,
      examTip:
          '💡 PNP TIP: "(a+b)² tiene 3 términos: a², 2ab, b²". El término medio siempre es 2ab.',
      initialGuide:
          'Un cuadrado de lado (a+b) se divide en 4 secciones. Toca a² para comenzar.',
      doneGuide: '¡Listo! Sumando las 4 áreas encontramos la fórmula completa.',
      finalLabel: 'Simplificando (ab + ab = 2ab):',
      finalFormula: '(a + b)² = a² + 2ab + b²',
      finalSub: 'Los dos rectángulos iguales (ab + ab) se combinan en 2ab.',
      nextTab: 'diff',
      sideLabels: [
        {'text': 'a', 'cx': 70.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'b', 'cx': 175.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'a', 'cx': -22.0, 'cy': 70.0, 'axis': 'left'},
        {'text': 'b', 'cx': -22.0, 'cy': 175.0, 'axis': 'left'},
      ],
      blocks: [
        FormulaBlock(
          id: 'a2',
          label: 'a²',
          baseColor: Color(0xFF1D6C87),
          w: 140,
          h: 140,
          x: 0,
          y: 0,
          order: 0,
          termText: 'a²',
          sign: null,
          guide: 'Cuadrado a²: Es el cuadrado de lado a. Área = a × a = a².',
        ),
        FormulaBlock(
          id: 'ab1',
          label: 'ab',
          baseColor: Color(0xFF6B5AA3),
          w: 70,
          h: 140,
          x: 140,
          y: 0,
          order: 1,
          termText: 'ab',
          sign: '+',
          guide:
              'Rectángulo ab (derecha): Mide b de ancho y a de alto. Área = ab.',
        ),
        FormulaBlock(
          id: 'ab2',
          label: 'ab',
          baseColor: Color(0xFF6B5AA3),
          w: 140,
          h: 70,
          x: 0,
          y: 140,
          order: 2,
          termText: 'ab',
          sign: '+',
          guide:
              'Rectángulo ab (abajo): Mide a de ancho y b de alto. ¡Igual al anterior!',
        ),
        FormulaBlock(
          id: 'b2',
          label: 'b²',
          baseColor: Color(0xFF9A6B1A),
          w: 70,
          h: 70,
          x: 140,
          y: 140,
          order: 3,
          termText: 'b²',
          sign: '+',
          guide:
              'Cuadrado b²: La esquina final, lado b. Área = b². ¡El cuadrado está completo!',
        ),
      ],
    ),
    'diff': FormulaConfig(
      key: 'diff',
      title: '(a−b)²',
      category: 'Cuadrados',
      eqTitle: 'Área del cuadrado (a − b)² =',
      size: 210,
      examTip:
          '💡 PNP TIP: "(a-b)² = a² - 2ab + b²". El signo del término medio es NEGATIVO.',
      initialGuide:
          'El cuadrado de lado (a−b). Toca a² para ver cómo se construye recortando.',
      doneGuide:
          '¡Listo! El cuadrado de lado (a−b) se obtiene quitando 2ab y devolviendo b².',
      finalLabel: 'Simplificando (−ab − ab + b²):',
      finalFormula: '(a − b)² = a² − 2ab + b²',
      finalSub:
          'Quitamos dos franjas iguales y devolvemos la esquina contada dos veces.',
      nextTab: 'conj',
      sideLabels: [
        {'text': 'a-b', 'cx': 35.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'b', 'cx': 175.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'a-b', 'cx': -28.0, 'cy': 35.0, 'axis': 'left'},
        {'text': 'b', 'cx': -22.0, 'cy': 175.0, 'axis': 'left'},
      ],
      blocks: [
        FormulaBlock(
          id: 'a2',
          label: 'a²',
          baseColor: Color(0xFF1D6C87),
          w: 140,
          h: 140,
          x: 0,
          y: 0,
          order: 0,
          termText: 'a²',
          sign: null,
          guide: 'Cuadrado a²: Partimos del cuadrado de lado a. Área = a².',
        ),
        FormulaBlock(
          id: 'ab1',
          label: '−ab',
          baseColor: Color(0xFF8A3030),
          w: 70,
          h: 140,
          x: 140,
          y: 0,
          order: 1,
          termText: 'ab',
          sign: '−',
          guide:
              'Franja derecha (−ab): Recortamos esta franja vertical. Área quitada = ab.',
        ),
        FormulaBlock(
          id: 'ab2',
          label: '−ab',
          baseColor: Color(0xFF8A3030),
          w: 140,
          h: 70,
          x: 0,
          y: 140,
          order: 2,
          termText: 'ab',
          sign: '−',
          guide:
              'Franja inferior (−ab): ¡Pero la esquina b² se restó dos veces!',
        ),
        FormulaBlock(
          id: 'b2r',
          label: '+b²',
          baseColor: Color(0xFF9A6B1A),
          w: 70,
          h: 70,
          x: 140,
          y: 140,
          order: 3,
          termText: 'b²',
          sign: '+',
          guide:
              'Esquina b² (devuelta): Se restó dos veces, la sumamos de vuelta.',
        ),
      ],
    ),
    'conj': FormulaConfig(
      key: 'conj',
      title: '(a+b)(a−b)',
      category: 'Cuadrados',
      eqTitle: 'Área = (a+b) × (a−b) =',
      size: 210,
      examTip:
          '💡 PNP TIP: "Diferencia de cuadrados = a²-b²". Los términos ab se cancelan. ¡Sin término medio!',
      initialGuide:
          'Rectángulo de base (a+b) y altura (a−b). Descubre la diferencia de cuadrados.',
      doneGuide:
          '¡Listo! Los rectángulos +ab y −ab se cancelan. El resultado es a² − b².',
      finalLabel: 'Los términos +ab y −ab se cancelan:',
      finalFormula: '(a+b)(a−b) = a² − b²',
      finalSub:
          '¡Los rectángulos ab se anulan entre sí! Solo quedan los cuadrados.',
      nextTab: 'cube_sum',
      sideLabels: [
        {'text': 'a', 'cx': 70.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'b', 'cx': 175.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'a-b', 'cx': -28.0, 'cy': 70.0, 'axis': 'left'},
        {'text': 'b', 'cx': -22.0, 'cy': 175.0, 'axis': 'left'},
      ],
      blocks: [
        FormulaBlock(
          id: 'a2',
          label: 'a²',
          baseColor: Color(0xFF1D6C87),
          w: 140,
          h: 140,
          x: 0,
          y: 0,
          order: 0,
          termText: 'a²',
          sign: null,
          guide: 'Área a²: El cuadrado en la esquina superior izquierda.',
        ),
        FormulaBlock(
          id: 'ab1',
          label: '+ab',
          baseColor: Color(0xFF6B5AA3),
          w: 70,
          h: 140,
          x: 140,
          y: 0,
          order: 1,
          termText: 'ab',
          sign: '+',
          guide: 'Franja +ab (derecha alta): Base b, altura a. Área = +ab.',
        ),
        FormulaBlock(
          id: 'ab2',
          label: '−ab',
          baseColor: Color(0xFF8A3030),
          w: 140,
          h: 70,
          x: 0,
          y: 140,
          order: 2,
          termText: 'ab',
          sign: '−',
          guide: 'Franja −ab (inferior): Base a, altura b. Área = −ab.',
        ),
        FormulaBlock(
          id: 'b2r',
          label: '−b²',
          baseColor: Color(0xFF4A4A4A),
          w: 70,
          h: 70,
          x: 140,
          y: 140,
          order: 3,
          termText: 'b²',
          sign: '−',
          guide:
              'Esquina −b²: Área = −b². Suma todo: a² + ab − ab − b² = a² − b².',
        ),
      ],
    ),
    'cube_sum': FormulaConfig(
      key: 'cube_sum',
      title: '(a+b)³',
      category: 'Cubos',
      eqTitle: 'Expansión del cubo de la suma:',
      size: 210,
      examTip:
          '💡 PNP TIP: "(a+b)³ tiene 4 términos: a³, 3a²b, 3ab², b³". Los coeficientes son 1-3-3-1.',
      initialGuide:
          'El cubo de la suma expande (a+b) tres veces. Toca cada término para descubrirlo.',
      doneGuide: '¡Listo! Memoriza el patrón: 1·a³ + 3·a²b + 3·ab² + 1·b³',
      finalLabel: 'Coeficientes del triángulo de Pascal (1,3,3,1):',
      finalFormula: '(a+b)³ = a³ + 3a²b + 3ab² + b³',
      finalSub:
          'Cada coeficiente corresponde a la fila 3 del triángulo de Pascal.',
      nextTab: 'cube_diff',
      sideLabels: [
        {'text': 'a³', 'cx': 30.0, 'cy': -22.0, 'axis': 'top'},
        {'text': '3a²b', 'cx': 100.0, 'cy': -22.0, 'axis': 'top'},
        {'text': '3ab²', 'cx': 165.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'b³', 'cx': 195.0, 'cy': -22.0, 'axis': 'top'},
      ],
      blocks: [
        FormulaBlock(
          id: 'a3',
          label: 'a³',
          baseColor: Color(0xFF1D6C87),
          w: 60,
          h: 210,
          x: 0,
          y: 0,
          order: 0,
          termText: 'a³',
          sign: null,
          guide:
              'Término a³: Proviene de a×a×a. Es el primer término con coeficiente 1.',
        ),
        FormulaBlock(
          id: '3a2b',
          label: '3a²b',
          baseColor: Color(0xFF2E7D6B),
          w: 75,
          h: 210,
          x: 62,
          y: 0,
          order: 1,
          termText: '3a²b',
          sign: '+',
          guide:
              'Término 3a²b: Hay 3 formas de elegir una b de los 3 factores. Coeficiente = 3.',
        ),
        FormulaBlock(
          id: '3ab2',
          label: '3ab²',
          baseColor: Color(0xFF6B5AA3),
          w: 55,
          h: 210,
          x: 139,
          y: 0,
          order: 2,
          termText: '3ab²',
          sign: '+',
          guide:
              'Término 3ab²: Hay 3 formas de elegir una a de los 3 factores. Coeficiente = 3.',
        ),
        FormulaBlock(
          id: 'b3',
          label: 'b³',
          baseColor: Color(0xFF9A6B1A),
          w: 16,
          h: 210,
          x: 194,
          y: 0,
          order: 3,
          termText: 'b³',
          sign: '+',
          guide:
              'Término b³: Proviene de b×b×b. Es el último término con coeficiente 1.',
        ),
      ],
    ),
    'cube_diff': FormulaConfig(
      key: 'cube_diff',
      title: '(a−b)³',
      category: 'Cubos',
      eqTitle: 'Expansión del cubo de la diferencia:',
      size: 210,
      examTip:
          '💡 PNP TIP: "(a-b)³ alterna signos: +a³, -3a²b, +3ab², -b³". El patrón es +−+−.',
      initialGuide:
          'El cubo de la diferencia. Los signos alternan: +, −, +, −.',
      doneGuide: '¡Listo! Nota el patrón de signos alternados: + − + −',
      finalLabel: 'Signos alternados (+ − + −):',
      finalFormula: '(a−b)³ = a³ − 3a²b + 3ab² − b³',
      finalSub:
          'Los signos alternos distinguen al cubo de la diferencia del cubo de la suma.',
      nextTab: 'sum_cubes',
      sideLabels: [
        {'text': 'a³', 'cx': 30.0, 'cy': -22.0, 'axis': 'top'},
        {'text': '-3a²b', 'cx': 100.0, 'cy': -22.0, 'axis': 'top'},
        {'text': '3ab²', 'cx': 165.0, 'cy': -22.0, 'axis': 'top'},
        {'text': '-b³', 'cx': 195.0, 'cy': -22.0, 'axis': 'top'},
      ],
      blocks: [
        FormulaBlock(
          id: 'a3',
          label: 'a³',
          baseColor: Color(0xFF1D6C87),
          w: 60,
          h: 210,
          x: 0,
          y: 0,
          order: 0,
          termText: 'a³',
          sign: null,
          guide: 'Término +a³: Igual que en el cubo de la suma. Positivo.',
        ),
        FormulaBlock(
          id: 'n3a2b',
          label: '−3a²b',
          baseColor: Color(0xFF8A3030),
          w: 75,
          h: 210,
          x: 62,
          y: 0,
          order: 1,
          termText: '3a²b',
          sign: '−',
          guide:
              'Término −3a²b: Coeficiente 3, pero negativo porque sustituimos +b por −b.',
        ),
        FormulaBlock(
          id: '3ab2',
          label: '+3ab²',
          baseColor: Color(0xFF2E7D6B),
          w: 55,
          h: 210,
          x: 139,
          y: 0,
          order: 2,
          termText: '3ab²',
          sign: '+',
          guide:
              'Término +3ab²: (−b)² = b², así el signo vuelve a ser positivo.',
        ),
        FormulaBlock(
          id: 'nb3',
          label: '−b³',
          baseColor: Color(0xFF5A3A6B),
          w: 16,
          h: 210,
          x: 194,
          y: 0,
          order: 3,
          termText: 'b³',
          sign: '−',
          guide: 'Término −b³: (−b)³ = −b³. El patrón + − + − se completa.',
        ),
      ],
    ),
    'sum_cubes': FormulaConfig(
      key: 'sum_cubes',
      title: 'a³+b³',
      category: 'Factorizaciones',
      eqTitle: 'Factorización de la suma de cubos:',
      size: 210,
      examTip:
          '💡 PNP TIP: "a³+b³ = (a+b)(a²-ab+b²)". El factor cuadrático tiene signo NEGATIVO en ab.',
      initialGuide:
          'Suma de cubos. Esta es una factorización, no una expansión. Descubre los factores.',
      doneGuide:
          '¡Listo! La suma de cubos factoriza en un binomio y un trinomio.',
      finalLabel: 'Factorización de suma de cubos:',
      finalFormula: 'a³ + b³ = (a+b)(a² − ab + b²)',
      finalSub: 'Truco: el trinomio tiene el producto ab con signo negativo.',
      nextTab: 'diff_cubes',
      sideLabels: [
        {'text': 'a+b', 'cx': 70.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'a²-ab', 'cx': 165.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'a³', 'cx': -22.0, 'cy': 60.0, 'axis': 'left'},
        {'text': 'b³', 'cx': -22.0, 'cy': 175.0, 'axis': 'left'},
      ],
      blocks: [
        FormulaBlock(
          id: 'apb',
          label: '(a+b)',
          baseColor: Color(0xFF1D6C87),
          w: 140,
          h: 210,
          x: 0,
          y: 0,
          order: 0,
          termText: '(a+b)',
          sign: null,
          guide:
              'Factor (a+b): El primer factor de la factorización. Binomio simple.',
        ),
        FormulaBlock(
          id: 'a2',
          label: 'a²',
          baseColor: Color(0xFF2E7D6B),
          w: 70,
          h: 70,
          x: 140,
          y: 0,
          order: 1,
          termText: 'a²',
          sign: '×',
          guide: 'Término a²: El cuadrado de a en el trinomio (a²−ab+b²).',
        ),
        FormulaBlock(
          id: 'nab',
          label: '−ab',
          baseColor: Color(0xFF8A3030),
          w: 70,
          h: 70,
          x: 140,
          y: 70,
          order: 2,
          termText: 'ab',
          sign: '−',
          guide:
              'Término −ab: El producto mixto con signo NEGATIVO. ¡Clave para distinguirlo!',
        ),
        FormulaBlock(
          id: 'b2',
          label: 'b²',
          baseColor: Color(0xFF9A6B1A),
          w: 70,
          h: 70,
          x: 140,
          y: 140,
          order: 3,
          termText: 'b²',
          sign: '+',
          guide: 'Término +b²: El cuadrado de b. ¡Factorización completa!',
        ),
      ],
    ),
    'diff_cubes': FormulaConfig(
      key: 'diff_cubes',
      title: 'a³−b³',
      category: 'Factorizaciones',
      eqTitle: 'Factorización de la diferencia de cubos:',
      size: 210,
      examTip:
          '💡 PNP TIP: "a³-b³ = (a-b)(a²+ab+b²)". El factor cuadrático tiene signo POSITIVO en ab.',
      initialGuide:
          'Diferencia de cubos. Similar a la suma, pero los signos cambian.',
      doneGuide:
          '¡Listo! La diferencia de cubos factoriza de forma simétrica a la suma.',
      finalLabel: 'Factorización de diferencia de cubos:',
      finalFormula: 'a³ − b³ = (a−b)(a² + ab + b²)',
      finalSub:
          'Truco: ahora el trinomio tiene el producto ab con signo POSITIVO.',
      nextTab: null,
      sideLabels: [
        {'text': 'a-b', 'cx': 70.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'a²+ab', 'cx': 165.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'a³', 'cx': -22.0, 'cy': 60.0, 'axis': 'left'},
        {'text': 'b³', 'cx': -22.0, 'cy': 175.0, 'axis': 'left'},
      ],
      blocks: [
        FormulaBlock(
          id: 'amb',
          label: '(a−b)',
          baseColor: Color(0xFF8A3030),
          w: 140,
          h: 210,
          x: 0,
          y: 0,
          order: 0,
          termText: '(a−b)',
          sign: null,
          guide: 'Factor (a−b): El primer factor. Binomio con signo negativo.',
        ),
        FormulaBlock(
          id: 'a2',
          label: 'a²',
          baseColor: Color(0xFF2E7D6B),
          w: 70,
          h: 70,
          x: 140,
          y: 0,
          order: 1,
          termText: 'a²',
          sign: '×',
          guide: 'Término a²: El cuadrado de a en el trinomio (a²+ab+b²).',
        ),
        FormulaBlock(
          id: 'pab',
          label: '+ab',
          baseColor: Color(0xFF6B5AA3),
          w: 70,
          h: 70,
          x: 140,
          y: 70,
          order: 2,
          termText: 'ab',
          sign: '+',
          guide:
              'Término +ab: El producto mixto con signo POSITIVO. ¡Diferencia del caso anterior!',
        ),
        FormulaBlock(
          id: 'b2',
          label: 'b²',
          baseColor: Color(0xFF9A6B1A),
          w: 70,
          h: 70,
          x: 140,
          y: 140,
          order: 3,
          termText: 'b²',
          sign: '+',
          guide:
              'Término +b²: Cuadrado de b. ¡Todos los signos del trinomio son positivos!',
        ),
      ],
    ),
  };

  // ── State ─────────────────────────────────────────────────────────────────
  int _activeTab = 0; // 0 = Lab, 1 = Quiz
  String _current = 'sum';
  final Set<String> _clickedBlocks = {};
  final Set<String> _unlockedTabs = {'sum'};
  int _stepOrder = 0;

  // Quiz state
  int _quizScore = 0;
  int _quizStreak = 0;
  int _quizTotal = 0;
  String? _quizSelectedAnswer;
  bool _quizAnswered = false;
  List<String> _quizOptions = [];
  String _quizCorrectAnswer = '';
  String _quizFormulaKey = '';
  late AnimationController _quizFeedbackAnim;

  late final AudioPlayer _audioPlayer;
  late final ConfettiController _confettiController;
  late final AnimationController _doneAnim;

  FormulaConfig get _f => _formulas[_current]!;
  bool get _isDone => _stepOrder == _f.blocks.length;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _doneAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _quizFeedbackAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _generateQuizQuestion();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _confettiController.dispose();
    _doneAnim.dispose();
    _quizFeedbackAnim.dispose();
    super.dispose();
  }

  // ── Interactions (Lab) ───────────────────────────────────────────────────
  void _switchFormula(String key) {
    if (!_unlockedTabs.contains(key)) return;
    setState(() {
      _current = key;
      _clickedBlocks.clear();
      _stepOrder = 0;
    });
    _doneAnim.reset();
  }

  void _onBlockClick(FormulaBlock b) {
    if (_clickedBlocks.contains(b.id) || b.order != _stepOrder) return;
    setState(() {
      _clickedBlocks.add(b.id);
      _stepOrder++;
    });

    if (_stepOrder == _f.blocks.length) {
      if (_f.nextTab != null) {
        setState(() => _unlockedTabs.add(_f.nextTab!));
      }
      _audioPlayer.play(AssetSource('audio/correct.mp3'));
      _confettiController.play();
      _doneAnim.forward();
    }
  }

  void _resetCurrent() {
    setState(() {
      _clickedBlocks.clear();
      _stepOrder = 0;
    });
    _doneAnim.reset();
  }

  // ── Quiz Logic ────────────────────────────────────────────────────────────
  void _generateQuizQuestion() {
    final keys = _formulas.keys.toList();
    final random = Random();
    _quizFormulaKey = keys[random.nextInt(keys.length)];
    final formula = _formulas[_quizFormulaKey]!;
    _quizCorrectAnswer = formula.finalFormula;

    final otherAnswers =
        keys
            .where((k) => k != _quizFormulaKey)
            .map((k) => _formulas[k]!.finalFormula)
            .toList()
          ..shuffle();

    _quizOptions = [_quizCorrectAnswer, ...otherAnswers.take(3)]..shuffle();
    _quizSelectedAnswer = null;
    _quizAnswered = false;
  }

  void _submitQuizAnswer(String answer) {
    if (_quizAnswered) return;
    _quizFeedbackAnim.forward(from: 0);
    final isCorrect = answer == _quizCorrectAnswer;
    setState(() {
      _quizSelectedAnswer = answer;
      _quizAnswered = true;
      _quizTotal++;
      if (isCorrect) {
        _quizStreak++;
        _quizScore += 10 + (_quizStreak * 2);
        _audioPlayer.play(AssetSource('audio/correct.mp3'));
      } else {
        _quizStreak = 0;
      }
    });
  }

  void _nextQuizQuestion() {
    setState(() {
      _generateQuizQuestion();
    });
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return Scaffold(
      backgroundColor: nt.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Productos Notables',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          // Global progress badge
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: nt.blueGoogle.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: nt.blueGoogle.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  '${_unlockedTabs.length}/${_formulas.length} 🔓',
                  style: TextStyle(
                    color: nt.blueGoogle,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: NeuralBackgroundWrapper(
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  // Mode toggle
                  _buildModeToggle(nt),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _activeTab == 0
                        ? _buildLabContent(nt)
                        : _buildQuizContent(nt),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 30,
                gravity: 0.3,
                colors: const [
                  Color(0xFF3B82F6),
                  Color(0xFF8B5CF6),
                  Color(0xFF10B981),
                  Color(0xFFF59E0B),
                  Color(0xFFEC4899),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeToggle(NeuralThemeData nt) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _activeTab = 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _activeTab == 0
                      ? nt.blueGoogle.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: _activeTab == 0
                      ? Border.all(color: nt.blueGoogle.withValues(alpha: 0.4))
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.science_rounded,
                      color: _activeTab == 0 ? nt.blueGoogle : Colors.white38,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Laboratorio',
                      style: TextStyle(
                        color: _activeTab == 0 ? nt.blueGoogle : Colors.white38,
                        fontWeight: _activeTab == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _activeTab = 1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _activeTab == 1
                      ? nt.pink.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: _activeTab == 1
                      ? Border.all(color: nt.pink.withValues(alpha: 0.4))
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.quiz_rounded,
                      color: _activeTab == 1 ? nt.pink : Colors.white38,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Quiz Rápido',
                      style: TextStyle(
                        color: _activeTab == 1 ? nt.pink : Colors.white38,
                        fontWeight: _activeTab == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                    if (_quizScore > 0) ...[
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: nt.pink.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '$_quizScore',
                          style: TextStyle(
                            color: nt.pink,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Lab Content ─────────────────────────────────────────────────────────
  Widget _buildLabContent(NeuralThemeData nt) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCategoryTabs(nt),
          const SizedBox(height: 12),
          _buildFormulaTabs(nt),
          const SizedBox(height: 14),
          _buildProgressBar(nt),
          const SizedBox(height: 14),
          _buildGuideBox(nt),
          const SizedBox(height: 20),
          _buildCanvas(),
          const SizedBox(height: 20),
          _buildFormulaBoard(nt),
          if (_isDone) ...[
            const SizedBox(height: 14),
            _buildFinalBox(nt),
            const SizedBox(height: 12),
            _buildExamTipBox(nt),
            const SizedBox(height: 12),
            if (_f.nextTab != null) _buildNextButton(nt),
          ],
          const SizedBox(height: 10),
          Center(
            child: TextButton.icon(
              onPressed: _resetCurrent,
              icon: const Icon(
                Icons.refresh_rounded,
                color: Colors.white54,
                size: 16,
              ),
              label: const Text(
                'Reiniciar esta fórmula',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(NeuralThemeData nt) {
    final categories = _formulas.values.map((f) => f.category).toSet().toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          final isActive = _f.category == cat;
          final color = cat == 'Cuadrados'
              ? nt.blueGoogle
              : cat == 'Cubos'
              ? nt.purple
              : nt.successGreen;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isActive
                    ? color.withValues(alpha: 0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isActive
                      ? color.withValues(alpha: 0.5)
                      : Colors.white12,
                ),
              ),
              child: Text(
                cat,
                style: TextStyle(
                  color: isActive ? color : Colors.white38,
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFormulaTabs(NeuralThemeData nt) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _formulas.keys.map((key) {
          final formula = _formulas[key]!;
          final isActive = _current == key;
          final isUnlocked = _unlockedTabs.contains(key);

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => _switchFormula(key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? nt.blueGoogle.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isActive
                        ? nt.blueGoogle
                        : (isUnlocked ? Colors.white24 : Colors.transparent),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isUnlocked)
                      const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.lock_rounded,
                          size: 11,
                          color: Colors.white30,
                        ),
                      ),
                    Text(
                      formula.title,
                      style: TextStyle(
                        color: isActive
                            ? nt.blueGoogle
                            : (isUnlocked ? Colors.white : Colors.white30),
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProgressBar(NeuralThemeData nt) {
    final pct = _f.blocks.isEmpty ? 0.0 : _stepOrder / _f.blocks.length;
    final fIdx = _formulas.keys.toList().indexOf(_current) + 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Fórmula $fIdx de ${_formulas.length}  ·  paso $_stepOrder/${_f.blocks.length}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.45),
                fontSize: 11,
              ),
            ),
            Text(
              '${(pct * 100).round()}%',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.45),
                fontSize: 11,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            height: 5,
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                return Stack(
                  children: [
                    Container(color: Colors.white10),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                      width: constraints.maxWidth * pct,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [nt.blueGoogle, nt.purple],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_f.blocks.length, (i) {
            final isDone = i < _stepOrder;
            final isActive = i == _stepOrder;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isActive ? 12 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: isDone
                    ? nt.blueGoogle
                    : (isActive
                          ? Colors.white60
                          : Colors.white.withValues(alpha: 0.15)),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildGuideBox(NeuralThemeData nt) {
    final String guideText;
    if (_isDone) {
      guideText = _f.doneGuide;
    } else if (_stepOrder == 0) {
      guideText = _f.initialGuide;
    } else {
      guideText = _f.blocks[_stepOrder - 1].guide;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _isDone
            ? nt.blueGoogle.withValues(alpha: 0.07)
            : Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border(
          left: BorderSide(
            color: _isDone ? nt.blueGoogle : nt.purple,
            width: 3.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _isDone
                ? Icons.emoji_events_rounded
                : Icons.lightbulb_outline_rounded,
            color: _isDone ? nt.blueGoogle : nt.purple,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              guideText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCanvas() {
    final size = _f.size;
    const pad = 44.0;
    const totalSize = 210.0 + pad * 2;

    return Center(
      child: SizedBox(
        width: totalSize,
        height: totalSize,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: pad,
              top: pad - 12,
              child: Container(
                width: size,
                height: 1,
                color: Colors.white.withValues(alpha: 0.12),
              ),
            ),
            Positioned(
              left: pad - 12,
              top: pad,
              child: Container(
                width: 1,
                height: size,
                color: Colors.white.withValues(alpha: 0.12),
              ),
            ),
            ..._f.sideLabels.map((lbl) {
              final isTop = lbl['axis'] == 'top';
              final cx = lbl['cx'] as double;
              final cy = lbl['cy'] as double;
              final px = pad + cx;
              final py = pad + cy;
              return Positioned(
                left: isTop ? px - 16 : py - 20,
                top: isTop ? py - 6 : px - 8,
                child: Text(
                  lbl['text'] as String,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }),
            ..._f.blocks.map((b) {
              final blockDone = _clickedBlocks.contains(b.id);
              final isNext = !blockDone && b.order == _stepOrder;
              final isPending = !blockDone && b.order > _stepOrder;
              final opacity = blockDone ? 0.5 : (isPending ? 0.15 : 1.0);

              return Positioned(
                left: pad + b.x,
                top: pad + b.y,
                width: b.w,
                height: b.h,
                child: GestureDetector(
                  onTap: () => _onBlockClick(b),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOut,
                    decoration: BoxDecoration(
                      color: b.baseColor.withValues(alpha: opacity),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isNext
                            ? Colors.white.withValues(alpha: 0.85)
                            : Colors.white.withValues(alpha: 0.07),
                        width: isNext ? 2.5 : 1.0,
                      ),
                      boxShadow: isNext
                          ? [
                              BoxShadow(
                                color: b.baseColor.withValues(alpha: 0.6),
                                blurRadius: 16,
                                spreadRadius: 3,
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            b.label,
                            style: TextStyle(
                              color: Colors.white.withValues(
                                alpha: blockDone
                                    ? 0.6
                                    : (isPending ? 0.2 : 1.0),
                              ),
                              fontWeight: FontWeight.bold,
                              fontSize: b.w < 50 ? 10 : (b.w < 80 ? 13 : 17),
                            ),
                          ),
                          if (blockDone)
                            const Icon(
                              Icons.check_rounded,
                              color: Colors.white54,
                              size: 13,
                            ),
                          if (isNext)
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                'toca aquí',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.65),
                                  fontSize: 8,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildFormulaBoard(NeuralThemeData nt) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _f.eqTitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.45),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 5,
            runSpacing: 7,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (_stepOrder == 0)
                Text(
                  'toca las secciones →',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.3),
                    fontSize: 13,
                  ),
                )
              else
                for (int i = 0; i < _stepOrder; i++) ...[
                  if (_f.blocks[i].sign != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        _f.blocks[i].sign!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  AnimatedScale(
                    scale: 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: _f.blocks[i].baseColor.withValues(alpha: 0.28),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _f.blocks[i].baseColor.withValues(alpha: 0.45),
                        ),
                      ),
                      child: Text(
                        _f.blocks[i].termText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinalBox(NeuralThemeData nt) {
    return AnimatedOpacity(
      opacity: _isDone ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              nt.blueGoogle.withValues(alpha: 0.12),
              nt.purple.withValues(alpha: 0.08),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: nt.blueGoogle.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  color: nt.blueGoogle,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  _f.finalLabel,
                  style: TextStyle(
                    color: nt.blueGoogle,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              _f.finalFormula,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _f.finalSub,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamTipBox(NeuralThemeData nt) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: nt.warningAmber.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: nt.warningAmber.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.school_rounded, color: nt.warningAmber, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _f.examTip,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(NeuralThemeData nt) {
    final nextTitle = _formulas[_f.nextTab!]!.title;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [nt.blueGoogle, nt.purple],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: nt.blueGoogle.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () => _switchFormula(_f.nextTab!),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              'Continuar con $nextTitle',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Quiz Content ─────────────────────────────────────────────────────────
  Widget _buildQuizContent(NeuralThemeData nt) {
    final formula = _formulas[_quizFormulaKey]!;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Score HUD
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SCORE: $_quizScore',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  if (_quizStreak > 0)
                    Row(
                      children: [
                        Icon(
                          Icons.local_fire_department_rounded,
                          color: nt.warningAmber,
                          size: 12,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          'Racha: $_quizStreak',
                          style: TextStyle(
                            color: nt.warningAmber,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              Text(
                '$_quizTotal preguntas respondidas',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Question card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  nt.purple.withValues(alpha: 0.15),
                  nt.blueGoogle.withValues(alpha: 0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: nt.purple.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Text(
                  '¿CUÁL ES LA FÓRMULA?',
                  style: TextStyle(
                    color: nt.cyan,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  formula.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    formula.category,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Options
          ..._quizOptions.map((option) {
            final isSelected = _quizSelectedAnswer == option;
            final isCorrect = option == _quizCorrectAnswer;

            Color borderColor = Colors.white.withValues(alpha: 0.1);
            Color bgColor = Colors.white.withValues(alpha: 0.03);
            Color textColor = Colors.white70;

            if (_quizAnswered) {
              if (isCorrect) {
                borderColor = Colors.greenAccent;
                bgColor = Colors.greenAccent.withValues(alpha: 0.09);
                textColor = Colors.greenAccent;
              } else if (isSelected) {
                borderColor = Colors.redAccent;
                bgColor = Colors.redAccent.withValues(alpha: 0.09);
                textColor = Colors.redAccent;
              }
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                onTap: _quizAnswered ? null : () => _submitQuizAnswer(option),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: borderColor, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          option,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (_quizAnswered && isCorrect)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.greenAccent,
                          size: 18,
                        ),
                      if (_quizAnswered && isSelected && !isCorrect)
                        const Icon(
                          Icons.cancel_rounded,
                          color: Colors.redAccent,
                          size: 18,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),

          if (_quizAnswered) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.school_rounded,
                        color: nt.warningAmber,
                        size: 15,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Tip de Examen',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    formula.examTip,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: _nextQuizQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: nt.pink,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Siguiente pregunta →',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

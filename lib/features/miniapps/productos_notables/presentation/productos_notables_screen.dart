import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';

class FormulaBlock {
  final String id;
  final String label;
  final Color baseColor;
  final double w, h, x, y;
  final int order;
  final String? sign;
  final String guide;
  final String termText;

  FormulaBlock({
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

  FormulaConfig({
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
  });
}

class ProductosNotablesScreen extends StatefulWidget {
  const ProductosNotablesScreen({super.key});

  @override
  State<ProductosNotablesScreen> createState() => _ProductosNotablesScreenState();
}

class _ProductosNotablesScreenState extends State<ProductosNotablesScreen> {
  final Map<String, FormulaConfig> _formulas = {
    'sum': FormulaConfig(
      key: 'sum',
      title: '(a + b)²',
      eqTitle: 'Área total = (a + b)² =',
      size: 210,
      initialGuide: 'Un cuadrado de lado (a+b) se divide en 4 secciones. Toca a² para comenzar.',
      doneGuide: '¡Listo! Sumando las 4 áreas encontramos la fórmula completa.',
      finalLabel: 'Simplificando (ab + ab = 2ab):',
      finalFormula: '(a + b)² = a² + 2ab + b²',
      finalSub: 'Los dos rectángulos iguales se combinan en 2ab.',
      nextTab: 'diff',
      sideLabels: [
        {'text': 'a', 'cx': 70.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'b', 'cx': 175.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'a', 'cx': -22.0, 'cy': 70.0, 'axis': 'left'},
        {'text': 'b', 'cx': -22.0, 'cy': 175.0, 'axis': 'left'},
      ],
      blocks: [
        FormulaBlock(id: 'a2', label: 'a²', baseColor: const Color(0xFF1D6C87), w: 140, h: 140, x: 0, y: 0, order: 0, termText: 'a²', guide: 'Cuadrado a²: Es el cuadrado de lado a. Área = a².', sign: null),
        FormulaBlock(id: 'ab1', label: 'ab', baseColor: const Color(0xFF6B5AA3), w: 70, h: 140, x: 140, y: 0, order: 1, termText: 'ab', guide: 'Rectángulo ab: Mide b de ancho y a de alto. Área = ab.', sign: '+'),
        FormulaBlock(id: 'ab2', label: 'ab', baseColor: const Color(0xFF6B5AA3), w: 140, h: 70, x: 0, y: 140, order: 2, termText: 'ab', guide: 'Rectángulo ab: Mide a de ancho y b de alto. ¡Igual al anterior!', sign: '+'),
        FormulaBlock(id: 'b2', label: 'b²', baseColor: const Color(0xFF9A6B1A), w: 70, h: 70, x: 140, y: 140, order: 3, termText: 'b²', guide: 'Cuadrado b²: La esquina final, lado b. Área = b².', sign: '+'),
      ],
    ),
    'diff': FormulaConfig(
      key: 'diff',
      title: '(a − b)²',
      eqTitle: 'Área del cuadrado (a − b)² =',
      size: 210,
      initialGuide: 'Ahora el cuadrado de lado (a−b). Toca a² para ver cómo se construye recortando.',
      doneGuide: '¡Listo! El cuadrado de lado (a−b) se obtiene quitando 2ab y devolviendo b².',
      finalLabel: 'Simplificando (−ab − ab + b² = −2ab + b²):',
      finalFormula: '(a − b)² = a² − 2ab + b²',
      finalSub: 'Quitamos dos franjas iguales y devolvemos la esquina restada dos veces.',
      nextTab: 'conj',
      sideLabels: [
        {'text': 'a-b', 'cx': 35.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'b', 'cx': 175.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'a-b', 'cx': -28.0, 'cy': 35.0, 'axis': 'left'},
        {'text': 'b', 'cx': -22.0, 'cy': 175.0, 'axis': 'left'},
      ],
      blocks: [
        FormulaBlock(id: 'a2', label: 'a²', baseColor: const Color(0xFF1D6C87), w: 140, h: 140, x: 0, y: 0, order: 0, termText: 'a²', guide: 'Cuadrado a²: Partimos del cuadrado de lado a. Área = a².', sign: null),
        FormulaBlock(id: 'ab1', label: '−ab', baseColor: const Color(0xFF8A3030), w: 70, h: 140, x: 140, y: 0, order: 1, termText: 'ab', guide: 'Franja derecha (−ab): Recortamos esta franja vertical.', sign: '−'),
        FormulaBlock(id: 'ab2', label: '−ab', baseColor: const Color(0xFF8A3030), w: 140, h: 70, x: 0, y: 140, order: 2, termText: 'ab', guide: 'Franja inferior (−ab): Recortamos esta franja. La esquina b² se restó dos veces.', sign: '−'),
        FormulaBlock(id: 'b2r', label: '+b²', baseColor: const Color(0xFF9A6B1A), w: 70, h: 70, x: 140, y: 140, order: 3, termText: 'b²', guide: 'Esquina b² (devuelta): La sumamos de vuelta para corregir.', sign: '+'),
      ],
    ),
    'conj': FormulaConfig(
      key: 'conj',
      title: '(a+b)(a−b)',
      eqTitle: 'Área = (a+b) × (a−b) =',
      size: 210,
      initialGuide: 'Rectángulo de base (a+b) y altura (a−b). Toca a² para descubrir.',
      doneGuide: '¡Listo! Los rectángulos +ab y −ab se cancelan.',
      finalLabel: 'Los términos +ab y −ab se cancelan:',
      finalFormula: '(a+b)(a−b) = a² − b²',
      finalSub: '¡Los rectángulos ab se anulan entre sí!',
      nextTab: null,
      sideLabels: [
        {'text': 'a', 'cx': 70.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'b', 'cx': 175.0, 'cy': -22.0, 'axis': 'top'},
        {'text': 'a-b', 'cx': -28.0, 'cy': 70.0, 'axis': 'left'},
        {'text': 'b', 'cx': -22.0, 'cy': 175.0, 'axis': 'left'},
      ],
      blocks: [
        FormulaBlock(id: 'a2', label: 'a²', baseColor: const Color(0xFF1D6C87), w: 140, h: 140, x: 0, y: 0, order: 0, termText: 'a²', guide: 'Área a²: Esquina superior izquierda. Área = a².', sign: null),
        FormulaBlock(id: 'ab1', label: '+ab', baseColor: const Color(0xFF6B5AA3), w: 70, h: 140, x: 140, y: 0, order: 1, termText: 'ab', guide: 'Franja +ab: Base b, altura a. Área = +ab.', sign: '+'),
        FormulaBlock(id: 'ab2', label: '−ab', baseColor: const Color(0xFF8A3030), w: 140, h: 70, x: 0, y: 140, order: 2, termText: 'ab', guide: 'Franja −ab: Base a, altura b. Área = −ab.', sign: '−'),
        FormulaBlock(id: 'b2r', label: '−b²', baseColor: const Color(0xFF4A4A4A), w: 70, h: 70, x: 140, y: 140, order: 3, termText: 'b²', guide: 'Esquina −b²: Base b, altura b. Área = −b².', sign: '−'),
      ],
    ),
  };

  String _current = 'sum';
  final Set<String> _clickedBlocks = {};
  final Set<String> _unlockedTabs = {'sum'};
  int _stepOrder = 0;

  FormulaConfig get _f => _formulas[_current]!;

  void _switchFormula(String key) {
    if (!_unlockedTabs.contains(key)) return;
    setState(() {
      _current = key;
      _clickedBlocks.clear();
      _stepOrder = 0;
    });
  }

  void _onBlockClick(FormulaBlock b) {
    if (_clickedBlocks.contains(b.id) || b.order != _stepOrder) return;
    setState(() {
      _clickedBlocks.add(b.id);
      _stepOrder++;
      if (_stepOrder == _f.blocks.length && _f.nextTab != null) {
        _unlockedTabs.add(_f.nextTab!);
      }
    });
  }

  void _resetCurrent() {
    setState(() {
      _clickedBlocks.clear();
      _stepOrder = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    final isDone = _stepOrder == _f.blocks.length;

    return Scaffold(
      backgroundColor: nt.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text('Productos Notables', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTabs(nt),
                const SizedBox(height: 24),
                _buildProgressBar(nt),
                const SizedBox(height: 16),
                _buildGuideBox(nt, isDone),
                const SizedBox(height: 32),
                _buildCanvas(nt),
                const SizedBox(height: 32),
                _buildFormulaBoard(nt),
                if (isDone) ...[
                  const SizedBox(height: 16),
                  _buildFinalBox(nt),
                  const SizedBox(height: 16),
                  if (_f.nextTab != null)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: nt.blueGoogle,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () => _switchFormula(_f.nextTab!),
                      child: Text(
                        'Continuar con ${_formulas[_f.nextTab!]!.title} →',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                ],
                const SizedBox(height: 16),
                TextButton.icon(
                  onPressed: _resetCurrent,
                  icon: const Icon(Icons.refresh, color: Colors.white70),
                  label: const Text('Reiniciar esta fórmula', style: TextStyle(color: Colors.white70)),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs(NeuralThemeData nt) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: _formulas.keys.map((key) {
        final formula = _formulas[key]!;
        final isActive = _current == key;
        final isUnlocked = _unlockedTabs.contains(key);

        return GestureDetector(
          onTap: () => _switchFormula(key),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isActive ? nt.blueGoogle.withValues(alpha: 0.2) : nt.surfaceCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isActive ? nt.blueGoogle : (isUnlocked ? Colors.white24 : Colors.transparent),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isUnlocked)
                  const Padding(
                    padding: EdgeInsets.only(right: 6.0),
                    child: Icon(Icons.lock_rounded, size: 14, color: Colors.white30),
                  ),
                Text(
                  formula.title,
                  style: TextStyle(
                    color: isActive ? nt.blueGoogle : (isUnlocked ? Colors.white : Colors.white30),
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProgressBar(NeuralThemeData nt) {
    final pct = _f.blocks.isEmpty ? 0.0 : _stepOrder / _f.blocks.length;
    final fIdx = _formulas.keys.toList().indexOf(_current) + 1;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Fórmula $fIdx de 3 · paso $_stepOrder/${_f.blocks.length}', style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
            Text('${(pct * 100).round()}%', style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              width: MediaQuery.of(context).size.width * pct,
              decoration: BoxDecoration(
                color: nt.blueGoogle,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGuideBox(NeuralThemeData nt, bool isDone) {
    String guideText = _stepOrder == 0 ? _f.initialGuide : (_stepOrder <= _f.blocks.length ? _f.blocks[_stepOrder - 1].guide : '');
    if (isDone) guideText = _f.doneGuide;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDone ? nt.blueGoogle.withValues(alpha: 0.1) : nt.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: isDone ? nt.blueGoogle : nt.purple, width: 4)),
      ),
      child: Text(
        guideText,
        style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
      ),
    );
  }

  Widget _buildCanvas(NeuralThemeData nt) {
    final size = _f.size;
    const pad = 44.0;
    return Center(
      child: SizedBox(
        width: size + pad * 2,
        height: size + pad * 2,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Guidelines
            Positioned(left: pad, top: pad - 12, child: Container(width: size, height: 1, color: Colors.white24)),
            Positioned(left: pad - 12, top: pad, child: Container(width: 1, height: size, color: Colors.white24)),

            // Side Labels
            ..._f.sideLabels.map((lbl) {
              final isTop = lbl['axis'] == 'top';
              final px = pad + (lbl['cx'] as double);
              final py = pad + (lbl['cy'] as double);
              return Positioned(
                left: isTop ? px - 15 : py - 20,
                top: isTop ? py - 10 : px - 10,
                child: Text(
                  lbl['text'] as String,
                  style: const TextStyle(color: Colors.white54, fontSize: 12, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              );
            }),

            // Blocks
            ..._f.blocks.map((b) {
              final isDone = _clickedBlocks.contains(b.id);
              final isNext = !isDone && b.order == _stepOrder;
              final isPend = !isDone && b.order > _stepOrder;
              final opacity = isDone ? 0.6 : (isPend ? 0.2 : 1.0);

              return Positioned(
                left: pad + b.x,
                top: pad + b.y,
                width: b.w,
                height: b.h,
                child: GestureDetector(
                  onTap: () => _onBlockClick(b),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: b.baseColor.withValues(alpha: opacity),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isNext ? Colors.white.withValues(alpha: 0.8) : Colors.white.withValues(alpha: 0.1),
                        width: isNext ? 2.5 : 1.0,
                      ),
                      boxShadow: isNext ? [
                        BoxShadow(color: b.baseColor.withValues(alpha: 0.5), blurRadius: 12, spreadRadius: 2)
                      ] : [],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            b.label,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: isDone ? 0.8 : (isPend ? 0.3 : 1.0)),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          if (isDone) const Icon(Icons.check, color: Colors.white70, size: 16),
                          if (isNext) const Padding(padding: EdgeInsets.only(top: 4), child: Text('toca aquí', style: TextStyle(color: Colors.white70, fontSize: 10))),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: nt.surfaceCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_f.eqTitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 14)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (_stepOrder == 0)
                Text('toca las secciones →', style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 14)),
              for (int i = 0; i < _stepOrder; i++) ...[
                if (_f.blocks[i].sign != null)
                  Text(_f.blocks[i].sign!, style: const TextStyle(color: Colors.white70, fontSize: 20)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _f.blocks[i].baseColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _f.blocks[i].termText,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                )
              ]
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFinalBox(NeuralThemeData nt) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: nt.surfaceCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: nt.blueGoogle.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(color: nt.blueGoogle.withValues(alpha: 0.1), blurRadius: 20)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_f.finalLabel, style: TextStyle(color: nt.blueGoogle, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(_f.finalFormula, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(_f.finalSub, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14)),
        ],
      ),
    );
  }
}

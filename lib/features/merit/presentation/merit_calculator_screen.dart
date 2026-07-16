import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';

enum MeritBonus {
  none,
  militaryActive, // +20% SM Acuartelado / Licenciado FFAA
  exCadet, // +10% Ex cadete inst. pública militar
  militaryReserve, // +2pts SM No Acuartelado / Suboficial EESTP
}

class MeritCalculatorScreen extends StatefulWidget {
  const MeritCalculatorScreen({super.key});

  @override
  State<MeritCalculatorScreen> createState() => _MeritCalculatorScreenState();
}

class _MeritCalculatorScreenState extends State<MeritCalculatorScreen> {
  double _notaFisica = 11.0;
  double _notaAcademica = 11.0;
  double _notaEntrevista = 11.0;
  MeritBonus _bonus = MeritBonus.none;

  // Fórmula oficial: [(Fís×2) + (Acad×3) + (Ent×2)] / 7
  double get _promedio =>
      (_notaFisica * 2 + _notaAcademica * 3 + _notaEntrevista * 2) / 7;

  double get _notaFinal {
    double base = _promedio;
    if (base < 11.0) return base; // sin bonificación si no aprueba
    double result;
    switch (_bonus) {
      case MeritBonus.militaryActive:
        result = base * 1.20;
      case MeritBonus.exCadet:
        result = base * 1.10;
      case MeritBonus.militaryReserve:
        result = base + 2.0;
      case MeritBonus.none:
        result = base;
    }
    return result.clamp(0.0, 20.0);
  }

  bool get _isApproved => _promedio >= 11.0;

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
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Cuadro de Mérito',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Outfit',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Calculadora de Nota',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Fórmula oficial ponderada · EO-PNP 2026',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                // Fórmula visual
                _FormulaCard(),
                const SizedBox(height: 20),
                // Sliders
                _ScoreSlider(
                  label: 'Aptitud Física',
                  icon: Icons.directions_run_rounded,
                  color: const Color(0xFFF59E0B),
                  coef: '×2',
                  value: _notaFisica,
                  onChanged: (v) => setState(() => _notaFisica = v),
                ),
                const SizedBox(height: 14),
                _ScoreSlider(
                  label: 'Aptitud Académica',
                  icon: Icons.menu_book_rounded,
                  color: const Color(0xFF0EA5E9),
                  coef: '×3',
                  value: _notaAcademica,
                  onChanged: (v) => setState(() => _notaAcademica = v),
                ),
                const SizedBox(height: 14),
                _ScoreSlider(
                  label: 'Entrevista Personal',
                  icon: Icons.record_voice_over_rounded,
                  color: const Color(0xFF8B5CF6),
                  coef: '×2',
                  value: _notaEntrevista,
                  onChanged: (v) => setState(() => _notaEntrevista = v),
                ),
                const SizedBox(height: 20),
                // Bonificaciones
                _BonusSelector(
                  selected: _bonus,
                  enabled: _isApproved,
                  onChanged: (b) => setState(() => _bonus = b),
                ),
                const SizedBox(height: 24),
                // Resultado
                _MeritResult(
                  promedio: _promedio,
                  notaFinal: _notaFinal,
                  isApproved: _isApproved,
                  bonus: _bonus,
                ),
                const SizedBox(height: 20),
                // Criterios de desempate
                _TiebreakerInfo(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormulaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Column(
            children: [
              Text(
                '(Física×2) + (Académica×3) + (Entrevista×2)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontFamily: 'Outfit',
                  fontSize: 13,
                ),
              ),
              const Divider(color: Colors.white12, height: 14),
              const Text(
                '7',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Mínimo aprobatorio por fase: 11.00',
                style: TextStyle(
                  color: Colors.orange.withValues(alpha: 0.8),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreSlider extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final String coef;
  final double value;
  final ValueChanged<double> onChanged;

  const _ScoreSlider({
    required this.label,
    required this.icon,
    required this.color,
    required this.coef,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.08), Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withValues(alpha: 0.15),
                    ),
                    child: Icon(icon, color: color, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      coef,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    value.toStringAsFixed(1),
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: value >= 11 ? color : const Color(0xFFEF4444),
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: color,
                  inactiveTrackColor: color.withValues(alpha: 0.15),
                  thumbColor: color,
                  overlayColor: color.withValues(alpha: 0.2),
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 8,
                  ),
                  trackHeight: 4,
                ),
                child: Slider(
                  value: value,
                  min: 0,
                  max: 20,
                  divisions: 200,
                  onChanged: onChanged,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '00',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.3),
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    '11 (mín)',
                    style: TextStyle(
                      color: Colors.orange.withValues(alpha: 0.7),
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    '20',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.3),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BonusSelector extends StatelessWidget {
  final MeritBonus selected;
  final bool enabled;
  final ValueChanged<MeritBonus> onChanged;

  const _BonusSelector({
    required this.selected,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bonuses = [
      (MeritBonus.none, 'Sin bonificación', ''),
      (MeritBonus.militaryActive, 'SM Acuartelado / Licenciado FFAA', '+20%'),
      (MeritBonus.exCadet, 'Ex Cadete Inst. Pública Militar', '+10%'),
      (
        MeritBonus.militaryReserve,
        'SM No Acuartelado / Suboficial EESTP',
        '+2 pts',
      ),
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.military_tech_rounded,
                    color: Color(0xFFF59E0B),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Bonificación',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  if (!enabled)
                    Text(
                      'Requiere promedio ≥ 11',
                      style: TextStyle(
                        color: Colors.orange.withValues(alpha: 0.7),
                        fontSize: 11,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              ...bonuses.map((b) {
                final isSelected = selected == b.$1;
                return Opacity(
                  opacity: enabled || b.$1 == MeritBonus.none ? 1.0 : 0.4,
                  child: GestureDetector(
                    onTap: enabled ? () => onChanged(b.$1) : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFF59E0B).withValues(alpha: 0.15)
                            : Colors.white.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFF59E0B).withValues(alpha: 0.5)
                              : Colors.white.withValues(alpha: 0.06),
                        ),
                      ),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? const Color(0xFFF59E0B)
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFF59E0B)
                                    : Colors.white38,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    size: 12,
                                    color: Colors.black,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              b.$2,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white60,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          if (b.$3.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFF59E0B,
                                ).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                b.$3,
                                style: const TextStyle(
                                  color: Color(0xFFF59E0B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeritResult extends StatelessWidget {
  final double promedio;
  final double notaFinal;
  final bool isApproved;
  final MeritBonus bonus;

  const _MeritResult({
    required this.promedio,
    required this.notaFinal,
    required this.isApproved,
    required this.bonus,
  });

  @override
  Widget build(BuildContext context) {
    final color = isApproved
        ? const Color(0xFF22C55E)
        : const Color(0xFFEF4444);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                isApproved ? 'INGRESA AL CUADRO' : 'NO APRUEBA',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                notaFinal.toStringAsFixed(2),
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: color,
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -2,
                ),
              ),
              Text(
                'Nota Final Ponderada / 20',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
              if (bonus != MeritBonus.none && isApproved) ...[
                const SizedBox(height: 12),
                Text(
                  'Promedio base: ${promedio.toStringAsFixed(2)} → con bonificación: ${notaFinal.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TiebreakerInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      'Mayor nota en Examen de Conocimientos',
      'Mayor nota en Aptitud Física',
      'Mayor nota en Entrevista Personal',
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.balance_rounded,
                    color: Color(0xFF8B5CF6),
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Criterios de Desempate',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...items.asMap().entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                        ),
                        child: Center(
                          child: Text(
                            '${e.key + 1}',
                            style: const TextStyle(
                              color: Color(0xFF8B5CF6),
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          e.value,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

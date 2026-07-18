import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/features/fitness/domain/fitness_tables.dart';

class FitnessCalculatorScreen extends StatefulWidget {
  const FitnessCalculatorScreen({super.key});

  @override
  State<FitnessCalculatorScreen> createState() =>
      _FitnessCalculatorScreenState();
}

class _FitnessCalculatorScreenState extends State<FitnessCalculatorScreen> {
  FitnessGender _gender = FitnessGender.male;

  // Controladores de texto
  final _sprint = TextEditingController(text: '14.8');
  final _mins1000 = TextEditingController(text: '3');
  final _secs1000 = TextEditingController(text: '51');
  final _strength = TextEditingController(text: '7');
  final _swim = TextEditingController(text: '31');
  bool _nsn = false;

  int get _score100m {
    final v = double.tryParse(_sprint.text) ?? 99;
    return FitnessTables.getScore(
      test: FitnessTest.sprint100m,
      gender: _gender,
      value: v,
    );
  }

  int get _score1000m {
    final m = int.tryParse(_mins1000.text) ?? 99;
    final s = int.tryParse(_secs1000.text) ?? 99;
    return FitnessTables.getScore(
      test: FitnessTest.run1000m,
      gender: _gender,
      value: (m * 60 + s).toDouble(),
    );
  }

  int get _scoreStrength {
    final v = int.tryParse(_strength.text) ?? 0;
    return FitnessTables.getScore(
      test: FitnessTest.strength,
      gender: _gender,
      value: v.toDouble(),
    );
  }

  int get _scoreSwim {
    if (_nsn) return -1;
    final v = double.tryParse(_swim.text) ?? 99;
    return FitnessTables.getScore(
      test: FitnessTest.swim25m,
      gender: _gender,
      value: v,
    );
  }

  double get _average {
    final scores = [_score100m, _score1000m, _scoreStrength, _scoreSwim];
    if (scores.contains(-1)) return 0;
    return scores.reduce((a, b) => a + b) / 4;
  }

  bool get _isEliminated {
    if (_scoreSwim == -1) return true;
    return _score100m < 11 ||
        _score1000m < 11 ||
        _scoreStrength < 11 ||
        _scoreSwim < 11;
  }

  @override
  void dispose() {
    _sprint.dispose();
    _mins1000.dispose();
    _secs1000.dispose();
    _strength.dispose();
    _swim.dispose();
    super.dispose();
  }

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
          'Aptitud Física',
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
                // Header
                const Text(
                  'Simulador Físico',
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
                  'Tablas oficiales Anexo 05/06 · EO-PNP 2026',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),
                // Gender selector
                _GenderSelector(
                  gender: _gender,
                  onChanged: (g) => setState(() {
                    _gender = g;
                    _sprint.text = g == FitnessGender.male ? '14.8' : '17.8';
                    _mins1000.text = g == FitnessGender.male ? '3' : '4';
                    _secs1000.text = g == FitnessGender.male ? '51' : '30';
                    _strength.text = g == FitnessGender.male ? '7' : '36';
                    _swim.text = g == FitnessGender.male ? '31' : '36';
                  }),
                ),
                const SizedBox(height: 20),
                // Pruebas
                _TestCard(
                  icon: Icons.directions_run_rounded,
                  color: const Color(0xFF0EA5E9),
                  title: '100 metros planos',
                  unit: 'segundos',
                  score: _score100m,
                  child: _DecimalInput(
                    controller: _sprint,
                    hint: '14.8',
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(height: 14),
                _TestCard(
                  icon: Icons.timer_rounded,
                  color: const Color(0xFF8B5CF6),
                  title: '1000 metros planos',
                  unit: 'min\' seg"',
                  score: _score1000m,
                  child: Row(
                    children: [
                      Expanded(
                        child: _IntInput(
                          controller: _mins1000,
                          hint: '3',
                          label: 'min',
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          ':',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _IntInput(
                          controller: _secs1000,
                          hint: '51',
                          label: 'seg',
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _TestCard(
                  icon: _gender == FitnessGender.male
                      ? Icons.fitness_center_rounded
                      : Icons.sports_gymnastics_rounded,
                  color: const Color(0xFFF59E0B),
                  title: _gender == FitnessGender.male
                      ? 'Flexión de Brazos (Barras)'
                      : 'Flexión Abdominal (1 min)',
                  unit: 'repeticiones',
                  score: _scoreStrength,
                  child: _IntInput(
                    controller: _strength,
                    hint: _gender == FitnessGender.male ? '7' : '36',
                    label: 'reps',
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(height: 14),
                _SwimCard(
                  controller: _swim,
                  gender: _gender,
                  nsn: _nsn,
                  score: _scoreSwim,
                  onNsnChanged: (v) => setState(() => _nsn = v),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 24),
                // Resultado Final
                _FinalResult(
                  average: _average,
                  isEliminated: _isEliminated,
                  scores: [_score100m, _score1000m, _scoreStrength, _scoreSwim],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Widgets internos ───────────────────────────────────────────────────────

class _GenderSelector extends StatelessWidget {
  final FitnessGender gender;
  final ValueChanged<FitnessGender> onChanged;

  const _GenderSelector({required this.gender, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              _GenderOption(
                label: '♂ Varón',
                selected: gender == FitnessGender.male,
                onTap: () => onChanged(FitnessGender.male),
              ),
              const SizedBox(width: 6),
              _GenderOption(
                label: '♀ Dama',
                selected: gender == FitnessGender.female,
                onTap: () => onChanged(FitnessGender.female),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _GenderOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF0EA5E9).withValues(alpha: 0.25)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: selected
                ? Border.all(
                    color: const Color(0xFF0EA5E9).withValues(alpha: 0.5),
                  )
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Outfit',
              color: selected ? const Color(0xFF38BDF8) : Colors.white60,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class _TestCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String unit;
  final int score;
  final Widget child;

  const _TestCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.unit,
    required this.score,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isElim = score < 11;
    final scoreColor = score < 11
        ? const Color(0xFFEF4444)
        : score >= 16
        ? const Color(0xFF22C55E)
        : const Color(0xFF0EA5E9);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isElim
                  ? const Color(0xFFEF4444).withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.08),
            ),
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.08), Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withValues(alpha: 0.15),
                    ),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$score',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: scoreColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        isElim ? 'ELIMINADO' : (score >= 11 ? 'APTO' : ''),
                        style: TextStyle(
                          color: scoreColor,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              child,
              const SizedBox(height: 6),
              Text(
                'Unidad: $unit  ·  Mínimo aprobatorio: 11',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.35),
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

class _SwimCard extends StatelessWidget {
  final TextEditingController controller;
  final FitnessGender gender;
  final bool nsn;
  final int score;
  final ValueChanged<bool> onNsnChanged;
  final ValueChanged<String> onChanged;

  const _SwimCard({
    required this.controller,
    required this.gender,
    required this.nsn,
    required this.score,
    required this.onNsnChanged,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF06B6D4);
    final isElim = nsn || score < 11;
    final scoreColor = isElim
        ? const Color(0xFFEF4444)
        : const Color(0xFF0EA5E9);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isElim
                  ? const Color(0xFFEF4444).withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.08),
            ),
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.08), Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withValues(alpha: 0.15),
                    ),
                    child: const Icon(
                      Icons.pool_rounded,
                      color: color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Natación 25m (estilo libre)',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        nsn ? 'NSN' : '$score',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: scoreColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        isElim ? 'ELIMINADO' : 'APTO',
                        style: TextStyle(
                          color: scoreColor,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              if (!nsn)
                _DecimalInput(
                  controller: controller,
                  hint: gender == FitnessGender.male ? '31' : '36',
                  onChanged: onChanged,
                ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => onNsnChanged(!nsn),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: nsn
                            ? const Color(0xFFEF4444).withValues(alpha: 0.3)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: nsn
                              ? const Color(0xFFEF4444)
                              : Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      child: nsn
                          ? const Icon(
                              Icons.close,
                              color: Color(0xFFEF4444),
                              size: 14,
                            )
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Me sujeté de la canaleta / caminé / no salté del pódium (NSN)',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Unidad: segundos  ·  Mínimo aprobatorio: 11',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.35),
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

class _FinalResult extends StatelessWidget {
  final double average;
  final bool isEliminated;
  final List<int> scores;

  const _FinalResult({
    required this.average,
    required this.isEliminated,
    required this.scores,
  });

  @override
  Widget build(BuildContext context) {
    final color = isEliminated
        ? const Color(0xFFEF4444)
        : const Color(0xFF22C55E);

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
              Icon(
                isEliminated ? Icons.cancel_rounded : Icons.verified_rounded,
                color: color,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                isEliminated ? 'ELIMINADO' : 'APTO',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: color,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isEliminated
                    ? 'Una o más pruebas están por debajo del mínimo (11)'
                    : 'Promedio: ${average.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 13,
                ),
              ),
              if (!isEliminated) ...[
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ScoreBadge('100m', scores[0]),
                    _ScoreBadge('1000m', scores[1]),
                    _ScoreBadge(
                      scores.length > 2 ? 'Fuerza' : 'Fuerza',
                      scores[2],
                    ),
                    _ScoreBadge('Natación', scores[3]),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  final String label;
  final int score;

  const _ScoreBadge(this.label, this.score);

  @override
  Widget build(BuildContext context) {
    final color = score < 11
        ? const Color(0xFFEF4444)
        : score >= 16
        ? const Color(0xFF22C55E)
        : const Color(0xFF0EA5E9);
    return Column(
      children: [
        Text(
          '$score',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class _DecimalInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  const _DecimalInput({
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
      onChanged: onChanged,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontFamily: 'Outfit',
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF0EA5E9)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}

class _IntInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  final ValueChanged<String> onChanged;

  const _IntInput({
    required this.controller,
    required this.hint,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: onChanged,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontFamily: 'Outfit',
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.5),
          fontSize: 12,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF0EA5E9)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}

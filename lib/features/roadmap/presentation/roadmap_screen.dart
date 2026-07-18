import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoadmapPhase {
  final int number;
  final String title;
  final String dates;
  final String? voucher;
  final String? code;
  final IconData icon;
  final Color color;
  final String? note;

  const RoadmapPhase({
    required this.number,
    required this.title,
    required this.dates,
    this.voucher,
    this.code,
    required this.icon,
    required this.color,
    this.note,
  });
}

const _phases = [
  RoadmapPhase(
    number: 1,
    title: 'Preinscripción en línea (SIPROAD)',
    dates: '',
    icon: Icons.computer_rounded,
    color: Color(0xFF0EA5E9),
  ),
  RoadmapPhase(
    number: 2,
    title: 'Evaluación de Talla y Peso',
    dates: '',
    voucher: 'S/. 39.00',
    code: 'Cód. 08509 · Banco de la Nación',
    icon: Icons.straighten_rounded,
    color: Color(0xFF8B5CF6),
    note: 'Varones: mín. 1.67m  ·  Damas: mín. 1.63m',
  ),
  RoadmapPhase(
    number: 3,
    title: 'Documentaria (Inscripción)',
    dates: '',
    icon: Icons.folder_rounded,
    color: Color(0xFF06B6D4),
  ),
  RoadmapPhase(
    number: 4,
    title: 'Examen de Aptitud Médica',
    dates: '',
    voucher: 'S/. 231.20',
    code: 'Cód. 08511 · Banco de la Nación',
    icon: Icons.health_and_safety_rounded,
    color: Color(0xFF22C55E),
  ),
  RoadmapPhase(
    number: 5,
    title: 'Examen de Aptitud Física',
    dates: '',
    voucher: 'S/. 173.20',
    code: 'Cód. 08509 · Banco de la Nación',
    icon: Icons.directions_run_rounded,
    color: Color(0xFFF59E0B),
  ),
  RoadmapPhase(
    number: 6,
    title: 'Examen Psicométrico',
    dates: '',
    icon: Icons.psychology_rounded,
    color: Color(0xFFA78BFA),
  ),
  RoadmapPhase(
    number: 7,
    title: 'Aptitud Académica y Conocimientos',
    dates: '',
    voucher: 'S/. 137.40',
    code: 'Cód. 08509 · Banco de la Nación',
    icon: Icons.menu_book_rounded,
    color: Color(0xFF0EA5E9),
  ),
  RoadmapPhase(
    number: 8,
    title: 'Control y Confianza (Polígrafo)',
    dates: '',
    voucher: 'S/. 170.60',
    code: 'Cód. 08510 · Banco de la Nación',
    icon: Icons.monitor_heart_rounded,
    color: Color(0xFFEF4444),
  ),
  RoadmapPhase(
    number: 9,
    title: 'Entrevista Personal',
    dates: '',
    icon: Icons.record_voice_over_rounded,
    color: Color(0xFF8B5CF6),
    note: 'Llega 30 min antes · Terno o sastre formal',
  ),
  RoadmapPhase(
    number: 10,
    title: 'Examen Toxicológico',
    dates: '',
    voucher: 'S/. 248.80',
    code: 'Cód. 08120 · Banco de la Nación',
    icon: Icons.biotech_rounded,
    color: Color(0xFF06B6D4),
  ),
  RoadmapPhase(
    number: 11,
    title: 'Publicación del Cuadro de Mérito',
    dates: '',
    icon: Icons.emoji_events_rounded,
    color: Color(0xFFF59E0B),
  ),
  RoadmapPhase(
    number: 12,
    title: 'Pago e Internamiento',
    dates: '',
    voucher: 'Obligación económica',
    icon: Icons.school_rounded,
    color: Color(0xFF22C55E),
  ),
];

// Estado: 0 = pendiente, 1 = superado, 2 = no pasó
class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  List<int> _states = List.filled(12, 0);

  @override
  void initState() {
    super.initState();
    _loadStates();
  }

  Future<void> _loadStates() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('roadmap_states');
    if (saved != null && saved.length == 12) {
      setState(() {
        _states = saved.map((s) => int.tryParse(s) ?? 0).toList();
      });
    }
  }

  Future<void> _saveStates() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'roadmap_states',
      _states.map((s) => '$s').toList(),
    );
  }

  bool _canToggle(int index) {
    // No puede marcar superado si la fase anterior fue "no pasó"
    if (index == 0) return true;
    return _states[index - 1] != 2;
  }

  void _toggle(int index) {
    if (!_canToggle(index)) return;
    setState(() {
      _states[index] = (_states[index] + 1) % 3;
      // Si esta fase pasa a "no pasó" (2), resetear las siguientes
      if (_states[index] == 2) {
        for (int i = index + 1; i < _states.length; i++) {
          _states[i] = 0;
        }
      }
    });
    _saveStates();
  }

  int get _completedCount => _states.where((s) => s == 1).length;
  bool get _anyFailed => _states.contains(2);

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
          'Hoja de Ruta',
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
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 850),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Proceso de Admisión',
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
                      'EO-PNP 2026 · 12 fases secuenciales',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Progress
                    _ProgressHeader(
                      completed: _completedCount,
                      total: 12,
                      anyFailed: _anyFailed,
                    ),
                    const SizedBox(height: 8),
                    // Alert de traje formal
                    const _AlertBanner(
                      icon: Icons.info_outline_rounded,
                      color: Color(0xFF38BDF8),
                      text: 'No hay proceso de admisión en curso.',
                    ),
                    const SizedBox(height: 20),
                    // Timeline
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _phases.length,
                      separatorBuilder: (_, __) =>
                          const _TimelineConnector(active: false),
                      itemBuilder: (context, i) {
                        return _PhaseCard(
                          phase: _phases[i],
                          state: _states[i],
                          blocked: !_canToggle(i) && _states[i] == 0,
                          onTap: () => _toggle(i),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  final int completed;
  final int total;
  final bool anyFailed;

  const _ProgressHeader({
    required this.completed,
    required this.total,
    required this.anyFailed,
  });

  @override
  Widget build(BuildContext context) {
    final percent = completed / total;
    final color = anyFailed
        ? const Color(0xFFEF4444)
        : completed == total
        ? const Color(0xFF22C55E)
        : const Color(0xFF0EA5E9);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    anyFailed
                        ? 'Proceso Interrumpido'
                        : '$completed de $total fases superadas',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${(percent * 100).round()}%',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: color,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: percent,
                  backgroundColor: color.withValues(alpha: 0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AlertBanner extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _AlertBanner({
    required this.icon,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: color.withValues(alpha: 0.9),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineConnector extends StatelessWidget {
  final bool active;

  const _TimelineConnector({required this.active});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 19),
        Container(
          width: 2,
          height: 16,
          color: Colors.white.withValues(alpha: active ? 0.4 : 0.1),
        ),
      ],
    );
  }
}

class _PhaseCard extends StatelessWidget {
  final RoadmapPhase phase;
  final int state; // 0 = pendiente, 1 = superado, 2 = no pasó
  final bool blocked;
  final VoidCallback onTap;

  const _PhaseCard({
    required this.phase,
    required this.state,
    required this.blocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final stateColor = state == 1
        ? const Color(0xFF22C55E)
        : state == 2
        ? const Color(0xFFEF4444)
        : blocked
        ? Colors.white24
        : phase.color;

    final bgColor = state == 1
        ? const Color(0xFF22C55E)
        : state == 2
        ? const Color(0xFFEF4444)
        : phase.color;

    return GestureDetector(
      onTap: blocked ? null : onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: blocked ? 0.02 : 0.04),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: stateColor.withValues(alpha: blocked ? 0.1 : 0.25),
              ),
              gradient: LinearGradient(
                colors: [
                  bgColor.withValues(alpha: blocked ? 0.03 : 0.08),
                  Colors.transparent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Estado circular
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: bgColor.withValues(alpha: blocked ? 0.05 : 0.15),
                    border: Border.all(
                      color: stateColor.withValues(alpha: blocked ? 0.1 : 0.4),
                    ),
                  ),
                  child: state == 1
                      ? const Icon(
                          Icons.check_rounded,
                          color: Color(0xFF22C55E),
                          size: 20,
                        )
                      : state == 2
                      ? const Icon(
                          Icons.close_rounded,
                          color: Color(0xFFEF4444),
                          size: 20,
                        )
                      : Icon(
                          phase.icon,
                          color: blocked ? Colors.white24 : phase.color,
                          size: 18,
                        ),
                ),
                const SizedBox(width: 14),
                // Contenido
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: stateColor.withValues(
                                alpha: blocked ? 0.1 : 0.2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${phase.number}',
                                style: TextStyle(
                                  color: blocked ? Colors.white24 : stateColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              phase.title,
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                color: blocked ? Colors.white30 : Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (phase.dates.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              size: 11,
                              color: Colors.white.withValues(alpha: 0.35),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              phase.dates,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.45),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (phase.voucher != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.receipt_long_rounded,
                              size: 11,
                              color: Color(0xFFF59E0B),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${phase.voucher}  ${phase.code ?? ''}',
                                style: const TextStyle(
                                  color: Color(0xFFF59E0B),
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (phase.note != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          phase.note!,
                          style: TextStyle(
                            color: const Color(
                              0xFF38BDF8,
                            ).withValues(alpha: 0.8),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (!blocked)
                  Icon(
                    state == 0
                        ? Icons.radio_button_unchecked_rounded
                        : state == 1
                        ? Icons.check_circle_rounded
                        : Icons.cancel_rounded,
                    color: stateColor.withValues(alpha: 0.6),
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

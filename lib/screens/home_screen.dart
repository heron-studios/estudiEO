import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/services/local_storage_service.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/screens/alipio_selector_screen.dart';
import 'package:learn/widgets/animated_grid_bg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showProfileSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B).withValues(alpha: 0.9),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Futuro Cadete',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('EstudiEO PNP',
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 14)),
                  const SizedBox(height: 24),
                  _SheetItem(
                    icon: Icons.analytics_rounded,
                    color: const Color(0xFFFBBF24),
                    label: 'Progreso y Estadísticas',
                    onTap: () {
                      Navigator.pop(ctx);
                      Navigator.pushNamed(context, '/dashboard');
                    },
                  ),
                  _SheetItem(
                    icon: Icons.settings_rounded,
                    color: Colors.white54,
                    label: 'Ajustes',
                    onTap: () {
                      Navigator.pop(ctx);
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: AnimatedGridBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                // ── HEADER ──
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'EstudiEO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Bienvenido, postulante',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showProfileSheet(context),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.1),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                        ),
                        child: const Icon(Icons.person, color: Colors.white70, size: 22),
                      ),
                    ),
                  ],
                ),

                // ── CARDS — vertically centered in remaining space ──
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Simulacro de Examen
                          _GlassCard(
                            onTap: () => Navigator.pushNamed(context, '/exam'),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                              child: Row(
                                children: [
                                  _IconBubble(icon: Icons.timer_rounded, color: Colors.redAccent),
                                  const SizedBox(width: 14),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Simulacro de Examen',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        SizedBox(height: 2),
                                        Text('100 preguntas • 3 horas',
                                            style: TextStyle(color: Colors.white60, fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right, color: Colors.white30, size: 20),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Row: Estudiar + Repasar
                          SizedBox(
                            height: 120,
                            child: Row(
                              children: [
                                Expanded(
                                  child: _GlassTile(
                                    icon: Icons.auto_stories_rounded,
                                    color: Colors.blueAccent,
                                    title: 'Estudiar',
                                    subtitle: 'Por asignatura',
                                    onTap: () => Navigator.pushNamed(context, '/gallery'),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Consumer<SrsProvider>(
                                    builder: (context, srs, _) {
                                      final count = srs.getReviewQueue().length;
                                      return _GlassTile(
                                        icon: Icons.history_edu_rounded,
                                        color: Colors.greenAccent,
                                        title: 'Repasar',
                                        subtitle: count > 0 ? '$count pendientes' : 'Al día ✓',
                                        badge: count > 0 ? '$count' : null,
                                        onTap: () => Navigator.pushNamed(context, '/srs-review'),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Tarjetas
                          SizedBox(
                            height: 120,
                            child: Row(
                              children: [
                                Expanded(
                                  child: _GlassTile(
                                    icon: Icons.style_rounded,
                                    color: Colors.purpleAccent,
                                    title: 'Tarjetas',
                                    subtitle: 'Memoria',
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const AlipioSelectorScreen()),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────
//  Bottom sheet item
// ─────────────────────────────────────
class _SheetItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _SheetItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 16),
              Text(label,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              const Spacer(),
              const Icon(Icons.chevron_right, color: Colors.white24, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────
//  Glass tile (for grid cards)
// ─────────────────────────────────────
class _GlassTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String? badge;
  final VoidCallback onTap;

  const _GlassTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1E293B).withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white.withValues(alpha: 0.12), width: 1),
            borderRadius: BorderRadius.circular(22),
          ),
          padding: const EdgeInsets.all(14),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _IconBubble(icon: icon, color: color),
                  const Spacer(),
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(
                          color: Colors.white60, fontSize: 12)),
                ],
              ),
              if (badge != null)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(badge!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────
//  Glass card (full-width)
// ─────────────────────────────────────
class _GlassCard extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _GlassCard({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1E293B).withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white.withValues(alpha: 0.12), width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────
//  Icon bubble
// ─────────────────────────────────────
class _IconBubble extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _IconBubble({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/models/learning_level.dart';
import 'package:learn/providers/learning_provider.dart';
import 'package:go_router/go_router.dart';

/// Pantalla 3 del Modo Aprendizaje Guiado — Fase Victoria (Level Up).
///
/// Muestra una animación de celebración cuando el usuario completa 10/10
/// aciertos. Permite pasar al siguiente nivel o regresar si ya alcanzó
/// la maestría completa (4 niveles completados).
class LearningLevelUpScreen extends StatefulWidget {
  final String topicId;
  final Dificultad nivel;
  final Duration elapsed;

  const LearningLevelUpScreen({
    super.key,
    required this.topicId,
    required this.nivel,
    required this.elapsed,
  });

  @override
  State<LearningLevelUpScreen> createState() => _LearningLevelUpScreenState();
}

class _LearningLevelUpScreenState extends State<LearningLevelUpScreen>
    with TickerProviderStateMixin {
  late AnimationController _trophyController;
  late AnimationController _particleController;
  late AnimationController _textController;
  late Animation<double> _trophyScale;
  late Animation<double> _trophyRotation;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;

  final List<_ParticleData> _particles = [];

  @override
  void initState() {
    super.initState();

    // Generar partículas decorativas
    _particles.addAll(List.generate(20, (i) => _ParticleData.random(i)));

    _trophyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _trophyScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _trophyController, curve: Curves.elasticOut),
    );

    _trophyRotation = Tween<double>(begin: -0.1, end: 0.0).animate(
      CurvedAnimation(parent: _trophyController, curve: Curves.easeOut),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );

    // Secuencia de animaciones
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _trophyController.forward();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _textController.forward();
    });
  }

  @override
  void dispose() {
    _trophyController.dispose();
    _particleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _goToNextLevel(BuildContext context) {
    final nextNivel = widget.nivel.next!;
    context.read<LearningProvider>().clearCurrentSession();
    context.replace('/learning-theory', extra: {
        'topicId': widget.topicId,
        'nivel': nextNivel,
      },
    );
  }

  void _goHome(BuildContext context) {
    context.read<LearningProvider>().clearCurrentSession();
    Navigator.popUntil(context, ModalRoute.withName('/topics'));
  }

  @override
  Widget build(BuildContext context) {
    final isMastery = widget.nivel.next == null;
    final nextNivel = widget.nivel.next;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1E),
      body: Stack(
        children: [
          // ─── Partículas animadas de fondo ──────────────────────────────
          AnimatedBuilder(
            animation: _particleController,
            builder: (context, child) {
              return CustomPaint(
                painter: _ParticlePainter(
                  particles: _particles,
                  progress: _particleController.value,
                  color: widget.nivel.color,
                ),
                size: MediaQuery.of(context).size,
              );
            },
          ),

          // ─── Gradiente de fondo ────────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.5,
                colors: [
                  widget.nivel.color.withValues(alpha: 0.15),
                  const Color(0xFF0A0F1E),
                ],
              ),
            ),
          ),

          // ─── Contenido principal ───────────────────────────────────────
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Trofeo animado
                      ScaleTransition(
                        scale: _trophyScale,
                        child: RotationTransition(
                          turns: _trophyRotation,
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  widget.nivel.color.withValues(alpha: 0.3),
                                  widget.nivel.bgColor,
                                ],
                              ),
                              border: Border.all(
                                color: widget.nivel.color.withValues(alpha: 0.6),
                                width: 2.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: widget.nivel.color
                                      .withValues(alpha: 0.35),
                                  blurRadius: 40,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                isMastery ? '🌟' : '🏆',
                                style: const TextStyle(fontSize: 60),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Textos animados
                      FadeTransition(
                        opacity: _textOpacity,
                        child: SlideTransition(
                          position: _textSlide,
                          child: Column(
                            children: [
                              // Etiqueta de nivel completado
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 7),
                                decoration: BoxDecoration(
                                  color: widget.nivel.color
                                      .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: widget.nivel.color
                                        .withValues(alpha: 0.4),
                                  ),
                                ),
                                child: Text(
                                  '${widget.nivel.emoji} Nivel ${widget.nivel.displayName} Completado',
                                  style: TextStyle(
                                    color: widget.nivel.color,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 18),

                              Text(
                                isMastery
                                    ? '¡Maestría\nAlcanzada!'
                                    : '¡Nivel\nSuperado!',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900,
                                  height: 1.1,
                                  letterSpacing: -0.5,
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                isMastery
                                    ? '¡Dominas este tema en todos los niveles!\nEres un experto. 🎓'
                                    : '10/10 respuestas correctas.\n¡Sigue así, campeón!',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 15,
                                  height: 1.6,
                                ),
                              ),

                              const SizedBox(height: 28),

                              // Stats
                              _StatRow(elapsed: widget.elapsed),

                              const SizedBox(height: 36),

                              // Botón principal
                              if (!isMastery && nextNivel != null)
                                _ActionButton(
                                  label:
                                      'Pasar a Nivel ${nextNivel.displayName} ${nextNivel.emoji}',
                                  color: widget.nivel.color,
                                  icon: Icons.arrow_forward_rounded,
                                  onTap: () => _goToNextLevel(context),
                                )
                              else
                                _ActionButton(
                                  label: '¡Maestría alcanzada! Volver 🌟',
                                  color: const Color(0xFFFBBF24),
                                  icon: Icons.star_rounded,
                                  onTap: () => _goHome(context),
                                ),

                              const SizedBox(height: 12),

                              TextButton(
                                onPressed: () => _goHome(context),
                                child: const Text(
                                  'Volver a los temas',
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 14,
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
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Widgets internos
// ─────────────────────────────────────────────────────────────────────────────

class _StatRow extends StatelessWidget {
  final Duration elapsed;

  const _StatRow({required this.elapsed});

  String _fmt(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const _StatItem(label: 'Aciertos', value: '10/10', icon: '✅'),
          Container(
              width: 1, height: 36, color: const Color(0xFF1F2937)),
          const _StatItem(label: 'Puntuación', value: '100%', icon: '🎯'),
          Container(
              width: 1, height: 36, color: const Color(0xFF1F2937)),
          _StatItem(label: 'Tiempo', value: _fmt(elapsed), icon: '⏱'),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final String icon;

  const _StatItem(
      {required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white38, fontSize: 11),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withValues(alpha: 0.75)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(icon, color: Colors.white, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Partículas decorativas ────────────────────────────────────────────────

class _ParticleData {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double phase;

  const _ParticleData({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.phase,
  });

  factory _ParticleData.random(int seed) {
    final r = seed * 1.618033988749;
    return _ParticleData(
      x: (r % 1.0),
      y: ((r * 2.718) % 1.0),
      size: 2.0 + (seed % 5) * 1.5,
      speed: 0.3 + (seed % 4) * 0.15,
      phase: (seed % 7) * 0.15,
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_ParticleData> particles;
  final double progress;
  final Color color;

  const _ParticlePainter({
    required this.particles,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withValues(alpha: 0.45);
    for (final p in particles) {
      final t = (progress * p.speed + p.phase) % 1.0;
      final x = p.x * size.width;
      final y = p.y * size.height - t * size.height * 0.8;
      final opacity = (1.0 - t).clamp(0.0, 1.0);
      canvas.drawCircle(
        Offset(x, y),
        p.size,
        paint..color = color.withValues(alpha: opacity * 0.4),
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

import 'dart:math' as math;
import 'package:flutter/material.dart';

class _Particle {
  double x;
  double y;
  double vx;
  double vy;
  final double r;
  final double a;
  final Color color;

  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.r,
    required this.a,
    required this.color,
  });
}

class ParticleCanvas extends StatefulWidget {
  final ValueNotifier<Offset> mouseNotifier;
  const ParticleCanvas({super.key, required this.mouseNotifier});

  @override
  State<ParticleCanvas> createState() => _ParticleCanvasState();
}

class _ParticleCanvasState extends State<ParticleCanvas>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  Size _lastSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateParticles(Size size, Offset mousePos) {
    if (_particles.isEmpty || _lastSize != size) {
      _lastSize = size;
      final random = math.Random();
      _particles.clear();
      final colors = [
        const Color(0xFF8AB4F8),
        const Color(0xFFC084FC),
        const Color(0xFFF9A8D4),
      ];
      for (int i = 0; i < 90; i++) {
        _particles.add(
          _Particle(
            x: random.nextDouble() * size.width,
            y: random.nextDouble() * size.height,
            vx: (random.nextDouble() - 0.5) * 0.25,
            vy: (random.nextDouble() - 0.5) * 0.25,
            r: random.nextDouble() * 1.4 + 0.3,
            a: random.nextDouble(),
            color: colors[random.nextInt(3)],
          ),
        );
      }
      return;
    }

    for (var p in _particles) {
      p.x += p.vx;
      p.y += p.vy;

      if (p.x < 0) p.x = size.width;
      if (p.x > size.width) p.x = 0;
      if (p.y < 0) p.y = size.height;
      if (p.y > size.height) p.y = 0;

      if (mousePos.dx != -999 && mousePos.dy != -999) {
        final dx = p.x - mousePos.dx;
        final dy = p.y - mousePos.dy;
        final distSq = dx * dx + dy * dy;
        if (distSq < 6400) {
          final dist = math.sqrt(distSq);
          if (dist > 0) {
            p.x += (dx / dist) * 0.6;
            p.y += (dy / dist) * 0.6;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            _updateParticles(size, widget.mouseNotifier.value);
            return CustomPaint(
              size: size,
              painter: _ParticlePainter(particles: _particles),
            );
          },
        );
      },
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  const _ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Connections
    final linePaint = Paint()..strokeWidth = 0.5;
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final dx = particles[i].x - particles[j].x;
        final dy = particles[i].y - particles[j].y;
        final d2 = dx * dx + dy * dy;
        if (d2 < 8100) {
          final d = math.sqrt(d2);
          final opacity = 0.12 * (1.0 - d / 90.0);
          linePaint.color = const Color(0xFF8AB4F8).withValues(alpha: opacity);
          canvas.drawLine(
            Offset(particles[i].x, particles[i].y),
            Offset(particles[j].x, particles[j].y),
            linePaint,
          );
        }
      }
    }

    // 2. Dots
    final particlePaint = Paint()..style = PaintingStyle.fill;
    for (var p in particles) {
      particlePaint.color = p.color.withValues(alpha: p.a * 0.7);
      canvas.drawCircle(Offset(p.x, p.y), p.r, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

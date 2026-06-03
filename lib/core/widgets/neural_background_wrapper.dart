import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:learn/core/config/neural_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  NeuralBackgroundWrapper v3 — Fondo Neural con partículas y redes flotantes
//
//  Mejoras vs v2:
//  • Agrega la capa interactiva de partículas y conexiones (redes neuronales flotantes)
//    del login, integrada dinámicamente con las variables del NeuralTheme.
//  • Aísla las partículas en un RepaintBoundary y mantiene el child desacoplado.
// ─────────────────────────────────────────────────────────────────────────────
class NeuralBackgroundWrapper extends StatefulWidget {
  final Widget child;

  const NeuralBackgroundWrapper({super.key, required this.child});

  @override
  State<NeuralBackgroundWrapper> createState() =>
      _NeuralBackgroundWrapperState();
}

class _NeuralBackgroundWrapperState extends State<NeuralBackgroundWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _breathe;
  late final ValueNotifier<Offset> _mouseNotifier;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(reverse: true);

    _breathe = Tween<double>(begin: 0.88, end: 1.12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _mouseNotifier = ValueNotifier<Offset>(const Offset(-999, -999));
  }

  @override
  void dispose() {
    _controller.dispose();
    _mouseNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return MouseRegion(
      onHover: (e) => _mouseNotifier.value = e.localPosition,
      onExit: (_) => _mouseNotifier.value = const Offset(-999, -999),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Fondo base sólido — nunca se reconstruye
          ColoredBox(color: nt.background),

          // 2. Capa de blobs animados aislada en su propio layer
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _breathe,
              builder: (_, __) {
                final s = _breathe.value;
                return _BlobLayer(scale: s, nt: nt);
              },
            ),
          ),

          // El BackdropFilter ha sido eliminado para mejorar drásticamente el rendimiento en la web.
          // En su lugar, el desenfoque se aplica directamente con MaskFilter en el CustomPainter de los Blobs.

          // 4. Capa de redes neuronales flotantes (partículas y conexiones crisp, por encima del blur)
          Positioned.fill(
            child: RepaintBoundary(
              child: _ParticleCanvas(
                mouseNotifier: _mouseNotifier,
                blueGoogle: nt.blueGoogle,
                purple: nt.purple,
                pink: nt.pink,
              ),
            ),
          ),

          // 5. Capa de velo sutil — estática, sin rebuild
          const ColoredBox(color: Color(0x0D000000)), // 5% black

          // 6. Contenido de la pantalla — completamente desacoplado de la animación
          widget.child,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  _BlobLayer — CustomPainter puro (sin BoxDecoration ni Container)
// ─────────────────────────────────────────────────────────────────────────────
class _BlobLayer extends StatelessWidget {
  final double scale;
  final NeuralThemeData nt;

  const _BlobLayer({required this.scale, required this.nt});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BlobPainter(scale: scale, nt: nt),
      child: const SizedBox.expand(),
    );
  }
}

class _BlobPainter extends CustomPainter {
  final double scale;
  final NeuralThemeData nt;

  const _BlobPainter({required this.scale, required this.nt});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final s = scale;

    // Blob azul — esquina superior izquierda
    _drawBlob(
      canvas,
      center: Offset(-50 * s + w * 0.05, -80 * s + h * 0.05),
      radius: 175 * s,
      color: nt.blueGoogle.withValues(alpha: nt.blobBlueOpacity),
    );

    // Blob morado — centro derecha
    _drawBlob(
      canvas,
      center: Offset(w + 100 * s - w * 0.15, 250 * s + h * 0.2),
      radius: 200 * s,
      color: nt.purple.withValues(alpha: nt.blobPurpleOpacity),
    );

    // Blob rosa — esquina inferior izquierda
    _drawBlob(
      canvas,
      center: Offset(100 * s + w * 0.1, h + 100 * s - h * 0.1),
      radius: 190 * s,
      color: nt.pink.withValues(alpha: nt.blobPinkOpacity),
    );
  }

  void _drawBlob(
    Canvas canvas, {
    required Offset center,
    required double radius,
    required Color color,
  }) {
    // Aplicamos el blur nativamente en el pincel. Esto elimina la necesidad
    // de un BackdropFilter costoso sobre toda la pantalla.
    const blurSigma = kIsWeb ? 30.0 : 80.0;
    final paint = Paint()
      ..color = color
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, blurSigma);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(_BlobPainter old) =>
      old.scale != scale || old.nt != nt;
}

// ─────────────────────────────────────────────────────────────────────────────
//  _ParticleCanvas — Canvas de partículas interactivas flotantes
// ─────────────────────────────────────────────────────────────────────────────
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

class _ParticleCanvas extends StatefulWidget {
  final ValueNotifier<Offset> mouseNotifier;
  final Color blueGoogle;
  final Color purple;
  final Color pink;

  const _ParticleCanvas({
    required this.mouseNotifier,
    required this.blueGoogle,
    required this.purple,
    required this.pink,
  });

  @override
  State<_ParticleCanvas> createState() => _ParticleCanvasState();
}

class _ParticleCanvasState extends State<_ParticleCanvas> with SingleTickerProviderStateMixin {
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
        widget.blueGoogle,
        widget.purple,
        widget.pink,
      ];
      const particleCount = kIsWeb ? 25 : 60; // Menos partículas en web para evitar lag
      for (int i = 0; i < particleCount; i++) {
        _particles.add(_Particle(
          x: random.nextDouble() * size.width,
          y: random.nextDouble() * size.height,
          vx: (random.nextDouble() - 0.5) * 0.25,
          vy: (random.nextDouble() - 0.5) * 0.25,
          r: random.nextDouble() * 1.4 + 0.3,
          a: random.nextDouble(),
          color: colors[random.nextInt(3)],
        ));
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
        final dist = math.sqrt(dx * dx + dy * dy);
        if (dist < 80) {
          p.x += (dx / dist) * 0.6;
          p.y += (dy / dist) * 0.6;
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
              painter: _ParticlePainter(particles: _particles, lineColor: widget.blueGoogle),
            );
          },
        );
      },
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final Color lineColor;
  const _ParticlePainter({required this.particles, required this.lineColor});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Connections
    final linePaint = Paint()..strokeWidth = 0.5;
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final dx = particles[i].x - particles[j].x;
        final dy = particles[i].y - particles[j].y;
        final d = math.sqrt(dx * dx + dy * dy);
        if (d < 95) {
          final opacity = 0.12 * (1.0 - d / 95.0);
          linePaint.color = lineColor.withValues(alpha: opacity);
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

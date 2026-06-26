import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:learn/core/config/neural_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  NeuralBackgroundWrapper v4.1 — Plasma Fluido + Morphing Orgánico
// ─────────────────────────────────────────────────────────────────────────────

/// Suavizado hermético — más suave que easeInOut estándar
double _smoothstep(double t) => t * t * (3 - 2 * t);

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
  late final ValueNotifier<Offset> _mouseNotifier;
  late final bool _isMobile;

  @override
  void initState() {
    super.initState();
    _isMobile = !kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS);
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );
    
    // Solo animar si no es mobile (por performance extremo)
    if (!_isMobile) {
      _controller.repeat();
    }

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

    // Si es móvil, mostramos un fondo estático más ligero
    if (_isMobile) {
      return Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: nt.background),
          RepaintBoundary(
            child: _PlasmaBackground(t: 0.1, nt: nt),
          ),
          RepaintBoundary(
            child: _MorphBlobLayer(t: 0.2, nt: nt),
          ),
          const ColoredBox(color: Color(0x0A000000)),
          widget.child,
        ],
      );
    }

    return MouseRegion(
      onHover: (e) => _mouseNotifier.value = e.localPosition,
      onExit: (_) => _mouseNotifier.value = const Offset(-999, -999),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Fondo base — nunca se reconstruye
          ColoredBox(color: nt.background),

          // 2. Plasma de fondo: gradiente animado entre los tres colores del tema
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) => _PlasmaBackground(
                t: _controller.value,
                nt: nt,
              ),
            ),
          ),

          // 3. Blobs con morphing orgánico — cada uno en su propio RepaintBoundary
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) => _MorphBlobLayer(t: _controller.value, nt: nt),
            ),
          ),

          // 4. Burbujas de plasma con tentáculos luminosos
          Positioned.fill(
            child: RepaintBoundary(
              child: _PlasmaCanvas(
                mouseNotifier: _mouseNotifier,
                controller: _controller,
                blueGoogle: nt.blueGoogle,
                purple: nt.purple,
                pink: nt.pink,
              ),
            ),
          ),

          // 5. Velo sutil — estático
          const ColoredBox(color: Color(0x0A000000)),

          // 6. Contenido — completamente aislado de las animaciones
          widget.child,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  _PlasmaBackground — Gradiente radial animado de fondo
//  Dos puntos de luz que orbitan lentamente, mezclando colores del tema
// ─────────────────────────────────────────────────────────────────────────────
class _PlasmaBackground extends StatelessWidget {
  final double t;
  final NeuralThemeData nt;

  const _PlasmaBackground({required this.t, required this.nt});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PlasmaBackgroundPainter(t: t, nt: nt),
      child: const SizedBox.expand(),
    );
  }
}

class _PlasmaBackgroundPainter extends CustomPainter {
  final double t;
  final NeuralThemeData nt;

  const _PlasmaBackgroundPainter({required this.t, required this.nt});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final a1 = t * math.pi * 2 * (60 / 45);
    final cx1 = w * (0.5 + 0.35 * math.cos(a1));
    final cy1 = h * (0.5 + 0.28 * math.sin(a1 * 0.7));

    final a2 = t * math.pi * 2 * (60 / 55) + math.pi;
    final cx2 = w * (0.5 + 0.30 * math.cos(a2 * 1.3));
    final cy2 = h * (0.5 + 0.35 * math.sin(a2));

    // Web-safe subtle opacities
    final pulse1 = 0.5 + 0.5 * math.sin(t * math.pi * 2 * 3);
    final r1 = w * (0.55 + 0.12 * pulse1);
    final paint1 = Paint()
      ..shader = RadialGradient(
        colors: [
          nt.blueGoogle.withValues(alpha: 0.10 + 0.05 * pulse1),
          nt.purple.withValues(alpha: 0.05 + 0.02 * pulse1),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(cx1, cy1), radius: r1));
    canvas.drawCircle(Offset(cx1, cy1), r1, paint1);

    final pulse2 = 0.5 + 0.5 * math.sin(t * math.pi * 2 * 2.3 + math.pi);
    final r2 = w * (0.50 + 0.14 * pulse2);
    final paint2 = Paint()
      ..shader = RadialGradient(
        colors: [
          nt.pink.withValues(alpha: 0.08 + 0.04 * pulse2),
          nt.purple.withValues(alpha: 0.04 + 0.02 * pulse2),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(cx2, cy2), radius: r2));
    canvas.drawCircle(Offset(cx2, cy2), r2, paint2);
  }

  @override
  bool shouldRepaint(_PlasmaBackgroundPainter old) => old.t != t || old.nt != nt;
}

// ─────────────────────────────────────────────────────────────────────────────
//  _MorphBlobLayer — Blobs ameboides con morphing real de control points
//
//  Cada blob tiene N puntos de control en ángulos uniformes. El radio de
//  cada punto oscila con una frecuencia y fase únicas → forma orgánica.
//  Los puntos se conectan con cúbicas de Bézier → contorno ultra-suave.
// ─────────────────────────────────────────────────────────────────────────────
class _MorphBlobLayer extends StatelessWidget {
  final double t;
  final NeuralThemeData nt;

  const _MorphBlobLayer({required this.t, required this.nt});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MorphBlobPainter(t: t, nt: nt),
      child: const SizedBox.expand(),
    );
  }
}

class _MorphBlobPainter extends CustomPainter {
  final double t;
  final NeuralThemeData nt;

  const _MorphBlobPainter({required this.t, required this.nt});

  /// Genera los N puntos de control para un blob ameboide.
  /// [cx, cy] — centro del blob
  /// [baseR] — radio base
  /// [seed] — semilla de variación para que cada blob sea único
  /// [morphSpeed] — velocidad de morphing relativa (0.5 = muy lento, 2.0 = medio)
  List<Offset> _buildBlobPoints({
    required double cx,
    required double cy,
    required double baseR,
    required int seed,
    required double morphSpeed,
    int n = 8,
  }) {
    final points = <Offset>[];
    for (int i = 0; i < n; i++) {
      final angle = (i / n) * math.pi * 2;

      // Cada punto tiene su propia frecuencia y fase basadas en su índice + seed
      final freq1 = 1.0 + (seed + i * 17) % 5 * 0.3; // entre 1.0 y 2.2
      final freq2 = 0.7 + (seed + i * 31) % 4 * 0.4; // entre 0.7 y 2.3
      final phase1 = (seed * 0.4 + i * 1.3) % (math.pi * 2);
      final phase2 = (seed * 0.7 + i * 2.1) % (math.pi * 2);

      // Variación radial: suma de dos oscilaciones → movimiento no-periódico
      final variation =
          0.18 * math.sin(t * math.pi * 2 * freq1 * morphSpeed + phase1) +
          0.10 * math.sin(t * math.pi * 2 * freq2 * morphSpeed * 1.3 + phase2);

      final r = baseR * (1.0 + variation);
      points.add(Offset(
        cx + r * math.cos(angle),
        cy + r * math.sin(angle),
      ));
    }
    return points;
  }

  /// Construye un Path suavizado con cúbicas de Bézier a partir de N puntos.
  /// Usa el algoritmo de tangentes Catmull-Rom para puntos de control automáticos.
  Path _buildSmoothPath(List<Offset> pts) {
    final n = pts.length;
    final path = Path();

    // Punto de arranque — mitad entre pts[n-1] y pts[0]
    final start = Offset(
      (pts[n - 1].dx + pts[0].dx) / 2,
      (pts[n - 1].dy + pts[0].dy) / 2,
    );
    path.moveTo(start.dx, start.dy);

    for (int i = 0; i < n; i++) {
      final p0 = pts[i];
      final p1 = pts[(i + 1) % n];
      final mid = Offset((p0.dx + p1.dx) / 2, (p0.dy + p1.dy) / 2);
      path.quadraticBezierTo(p0.dx, p0.dy, mid.dx, mid.dy);
    }

    path.close();
    return path;
  }

  void _drawMorphBlob(
    Canvas canvas, {
    required double cx,
    required double cy,
    required double baseR,
    required Color color,
    required int seed,
    required double morphSpeed,
  }) {
    final pts = _buildBlobPoints(
      cx: cx,
      cy: cy,
      baseR: baseR,
      seed: seed,
      morphSpeed: morphSpeed,
    );
    final path = _buildSmoothPath(pts);

    // Web-safe single layer with RadialGradient to simulate blur without MaskFilter failure
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withValues(alpha: 0.35), 
          color.withValues(alpha: 0.15),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(path.getBounds());
      
    canvas.drawPath(path, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // ── Blob azul ──
    final blueOrbitX = math.sin(t * math.pi * 2 * (60 / 38)) * w * 0.06;
    final blueOrbitY = math.cos(t * math.pi * 2 * (60 / 44)) * h * 0.05;
    _drawMorphBlob(
      canvas,
      cx: w * 0.18 + blueOrbitX,
      cy: h * 0.18 + blueOrbitY,
      baseR: w * 0.30,
      color: nt.blueGoogle,
      seed: 7,
      morphSpeed: 0.6,
    );

    // ── Blob morado ──
    final purpleOrbitX = math.cos(t * math.pi * 2 * (60 / 50)) * w * 0.08;
    final purpleOrbitY = math.sin(t * math.pi * 2 * (60 / 35)) * h * 0.07;
    _drawMorphBlob(
      canvas,
      cx: w * 0.78 + purpleOrbitX,
      cy: h * 0.42 + purpleOrbitY,
      baseR: w * 0.32,
      color: nt.purple,
      seed: 13,
      morphSpeed: 0.75,
    );

    // ── Blob rosa ──
    final pinkOrbitX = math.sin(t * math.pi * 2 * (60 / 42) + 1.0) * w * 0.07;
    final pinkOrbitY = math.cos(t * math.pi * 2 * (60 / 48) + 2.1) * h * 0.06;
    _drawMorphBlob(
      canvas,
      cx: w * 0.22 + pinkOrbitX,
      cy: h * 0.80 + pinkOrbitY,
      baseR: w * 0.29,
      color: nt.pink,
      seed: 23,
      morphSpeed: 0.55,
    );
  }

  @override
  bool shouldRepaint(_MorphBlobPainter old) => old.t != t || old.nt != nt;
}

// ─────────────────────────────────────────────────────────────────────────────
//  _Bubble — Burbuja de plasma (reemplaza _Particle)
//  Más grande que las partículas originales, con propiedades de glow y speed
// ─────────────────────────────────────────────────────────────────────────────
class _Bubble {
  double x;
  double y;
  double vx;
  double vy;
  final double r;        // radio visual
  double a;             // opacidad actual (se anima)
  final double aTarget; // opacidad objetivo
  final Color color;
  final double glowFactor; // intensidad del glow (0.5 – 1.0)
  double phase;          // fase personal para pulsación

  _Bubble({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.r,
    required this.a,
    required this.aTarget,
    required this.color,
    required this.glowFactor,
    required this.phase,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
//  _PlasmaCanvas — Burbujas con glow + tentáculos de luz curvilíneos
// ─────────────────────────────────────────────────────────────────────────────
class _PlasmaCanvas extends StatefulWidget {
  final ValueNotifier<Offset> mouseNotifier;
  final AnimationController controller;
  final Color blueGoogle;
  final Color purple;
  final Color pink;

  const _PlasmaCanvas({
    required this.mouseNotifier,
    required this.controller,
    required this.blueGoogle,
    required this.purple,
    required this.pink,
  });

  @override
  State<_PlasmaCanvas> createState() => _PlasmaCanvasState();
}

class _PlasmaCanvasState extends State<_PlasmaCanvas>
    with SingleTickerProviderStateMixin {
  late AnimationController _ticker;
  final List<_Bubble> _bubbles = [];
  Size _lastSize = Size.zero;

  // Velocidad de movimiento — lento y meditativo
  static const double _speedScale = kIsWeb ? 0.18 : 0.22;

  // Cantidad de burbujas — más en mobile porque el renderer es más eficiente
  static const int _bubbleCount = kIsWeb ? 28 : 55;



  @override
  void initState() {
    super.initState();
    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..repeat();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _initBubbles(Size size) {
    final rng = math.Random(42); // seed fijo → misma distribución inicial siempre
    final colors = [widget.blueGoogle, widget.purple, widget.pink];
    _bubbles.clear();
    for (int i = 0; i < _bubbleCount; i++) {
      final color = colors[i % 3];
      _bubbles.add(_Bubble(
        x: rng.nextDouble() * size.width,
        y: rng.nextDouble() * size.height,
        vx: (rng.nextDouble() - 0.5) * _speedScale,
        vy: (rng.nextDouble() - 0.5) * _speedScale,
        r: rng.nextDouble() * 2.8 + 1.2, // 1.2 – 4.0 px
        a: rng.nextDouble() * 0.6 + 0.2,
        aTarget: rng.nextDouble() * 0.6 + 0.3,
        color: color,
        glowFactor: rng.nextDouble() * 0.5 + 0.5,
        phase: rng.nextDouble() * math.pi * 2,
      ));
    }
  }

  void _tick(Size size, Offset mouse) {
    if (_bubbles.isEmpty || _lastSize != size) {
      _lastSize = size;
      _initBubbles(size);
      return;
    }

    const dt = 1.0; // normalizado a 1 frame

    for (var b in _bubbles) {
      // Movimiento base
      b.x += b.vx * dt;
      b.y += b.vy * dt;

      // Wrap suave en los bordes
      if (b.x < -20) b.x = size.width + 20;
      if (b.x > size.width + 20) b.x = -20;
      if (b.y < -20) b.y = size.height + 20;
      if (b.y > size.height + 20) b.y = -20;

      // Pulsación de opacidad individual — muy lenta
      b.phase += 0.008;
      b.a = b.aTarget * (0.65 + 0.35 * math.sin(b.phase));

      // Repulsión suave del mouse
      if (mouse.dx != -999) {
        final dx = b.x - mouse.dx;
        final dy = b.y - mouse.dy;
        final distSq = dx * dx + dy * dy;
        if (distSq < 90 * 90 && distSq > 0.001) {
          final dist = math.sqrt(distSq);
          final force = (1.0 - dist / 90.0) * 0.4; // fuerza inversa a distancia
          b.x += (dx / dist) * force;
          b.y += (dy / dist) * force;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = Size(constraints.maxWidth, constraints.maxHeight);
      return AnimatedBuilder(
        animation: _ticker,
        builder: (_, __) {
          _tick(size, widget.mouseNotifier.value);
          return CustomPaint(
            size: size,
            painter: _BubblePainter(
              bubbles: _bubbles,
              blueGoogle: widget.blueGoogle,
              purple: widget.purple,
              pink: widget.pink,
              globalT: widget.controller.value,
            ),
          );
        },
      );
    });
  }
}

class _BubblePainter extends CustomPainter {
  final List<_Bubble> bubbles;
  final Color blueGoogle;
  final Color purple;
  final Color pink;
  final double globalT;

  const _BubblePainter({
    required this.bubbles,
    required this.blueGoogle,
    required this.purple,
    required this.pink,
    required this.globalT,
  });

  static const double _connectDist = kIsWeb ? 110.0 : 130.0;

  @override
  void paint(Canvas canvas, Size size) {
    _drawTentacles(canvas);
    _drawBubbles(canvas);
  }

  /// Tentáculos de luz — curvas de Bézier cuadráticas con ancho variable
  void _drawTentacles(Canvas canvas) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < bubbles.length; i++) {
      for (int j = i + 1; j < bubbles.length; j++) {
        final bi = bubbles[i];
        final bj = bubbles[j];
        final dx = bi.x - bj.x;
        final dy = bi.y - bj.y;
        final d = math.sqrt(dx * dx + dy * dy);

        if (d >= _connectDist) continue;

        final proximity = 1.0 - d / _connectDist; // 0.0 lejos → 1.0 cerca
        final smoothProx = _smoothstep(proximity);

        // Opacidad — depende de la distancia y la opacidad de ambas burbujas
        final opacity = smoothProx * 0.18 * (bi.a + bj.a) * 0.5;
        if (opacity < 0.005) continue;

        // Color interpolado entre los dos colores
        final col = Color.lerp(bi.color, bj.color, 0.5)!;

        // Ancho del tentáculo — más grueso cuando más cerca
        final strokeW = kIsWeb
            ? smoothProx * 0.8
            : smoothProx * 1.2;

        paint
          ..color = col.withValues(alpha: opacity)
          ..strokeWidth = strokeW;

        // Punto de control de la curva — ligeramente desplazado perpendicularmente
        // para dar un aspecto orgánico (no línea recta)
        final mx = (bi.x + bj.x) / 2;
        final my = (bi.y + bj.y) / 2;
        // Perpendicular escalada — oscila con el tiempo para que viva
        final perpX = -dy / d;
        final perpY = dx / d;
        final bend = math.sin(globalT * math.pi * 2 * 2 + bi.phase) * d * 0.08;
        final cpx = mx + perpX * bend;
        final cpy = my + perpY * bend;

        final path = Path()
          ..moveTo(bi.x, bi.y)
          ..quadraticBezierTo(cpx, cpy, bj.x, bj.y);

        canvas.drawPath(path, paint);
      }
    }
  }

  /// Burbujas con glow en capas: halo exterior → cuerpo → reflejo especular
  void _drawBubbles(Canvas canvas) {
    for (var b in bubbles) {
      final center = Offset(b.x, b.y);
      final a = b.a;
      final gf = b.glowFactor;

      // Halo exterior — muy difuso
      final haloPaint = Paint()
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          kIsWeb ? b.r * 3.5 : b.r * 5.0,
        )
        ..color = b.color.withValues(alpha: a * 0.35 * gf);
      canvas.drawCircle(center, b.r * 2.2, haloPaint);

      // Cuerpo principal — semi-translúcido
      final bodyPaint = Paint()
        ..color = b.color.withValues(alpha: a * 0.70)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, b.r, bodyPaint);

      // Reflejo especular — pequeño punto blanco en la esquina superior
      // (da la ilusión de esfera de cristal / plasma)
      if (!kIsWeb || b.r > 1.8) {
        final specPaint = Paint()
          ..color = Colors.white.withValues(alpha: a * 0.50)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(
          Offset(b.x - b.r * 0.28, b.y - b.r * 0.28),
          b.r * 0.32,
          specPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}

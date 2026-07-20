import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learn/core/services/bible_service.dart';

// ─── Splash premium con partículas, orbe y fases animadas ────────────────────

class ProfessionalSplash extends StatefulWidget {
  const ProfessionalSplash({super.key});

  @override
  State<ProfessionalSplash> createState() => _ProfessionalSplashState();
}

class _ProfessionalSplashState extends State<ProfessionalSplash>
    with TickerProviderStateMixin {
  // Controladores
  late final AnimationController _orbCtrl;
  late final AnimationController _particleCtrl;
  late final AnimationController _entranceCtrl;
  late final AnimationController _shimmerCtrl;
  late final AnimationController _progressCtrl;
  late final AnimationController _pulseCtrl;

  // Animaciones
  late final Animation<double> _orbScale;
  late final Animation<double> _logoOpacity;
  late final Animation<Offset> _logoSlide;
  late final Animation<double> _taglineOpacity;
  late final Animation<double> _progressValue;
  late final Animation<double> _shimmer;
  late final Animation<double> _pulseAnim;

  // Partículas
  final List<_Particle> _particles = [];
  final _random = math.Random();

  // Frases tácticas rotatorias
  final _phrases = const [
    'Inicializando módulos de entrenamiento...',
    'Cargando Arena Policial...',
    'Sincronizando base de conocimientos...',
    'Activando Tutor ARIA...',
    '¡Listo para conquistar tu vacante!',
  ];
  int _phraseIndex = 0;

  @override
  void initState() {
    super.initState();

    // Generar partículas
    for (int i = 0; i < 30; i++) {
      _particles.add(_Particle.random(_random));
    }

    // Orbe de fondo (loop infinito)
    _orbCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    // Partículas
    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // Shimmer del nombre
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Pulso del orbe
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Entrada (una sola vez)
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    // Barra de progreso (completa en ~3.5s)
    _progressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..forward();

    _logoOpacity = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );
    _taglineOpacity = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    );
    _progressValue = CurvedAnimation(
      parent: _progressCtrl,
      curve: Curves.easeInOut,
    );
    _orbScale = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
    _shimmer = CurvedAnimation(parent: _shimmerCtrl, curve: Curves.linear);
    _pulseAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );

    // Rotación de frases
    _rotatePhrases();
  }

  void _rotatePhrases() {
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      if (_phraseIndex < _phrases.length - 1) {
        setState(() => _phraseIndex++);
        _rotatePhrases();
      }
    });
  }

  @override
  void dispose() {
    _orbCtrl.dispose();
    _particleCtrl.dispose();
    _entranceCtrl.dispose();
    _shimmerCtrl.dispose();
    _progressCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060B18),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Fondo de orbes animados (RepaintBoundary aislado)
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: Listenable.merge([_orbCtrl, _pulseCtrl]),
              builder: (_, __) => CustomPaint(
                painter: _SplashBgPainter(
                  time: _orbCtrl.value,
                  pulse: _pulseAnim.value,
                ),
              ),
            ),
          ),

          // ── Partículas flotantes
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _particleCtrl,
              builder: (_, __) => CustomPaint(
                painter: _ParticlePainter(
                  particles: _particles,
                  progress: _particleCtrl.value,
                ),
              ),
            ),
          ),

          // ── Contenido principal centrado
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Orbe central flotante con logo
                  _buildOrbeLogo(),

                  const SizedBox(height: 40),

                  // Nombre EDUPOL con shimmer
                  _buildBrandName(),

                  const SizedBox(height: 8),

                  // Tagline
                  FadeTransition(
                    opacity: _taglineOpacity,
                    child: Text(
                      'EL SIMULADOR DEFINITIVO · PNP & FFAA',
                      style: TextStyle(
                        color: const Color(0xFF60A5FA).withValues(alpha: 0.8),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 56),

                  // Barra de progreso + frase táctica
                  _buildProgressSection(),

                  const SizedBox(height: 48),

                  // Versículo bíblico
                  _buildVerseSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Orbe central ──────────────────────────────────────────────────────────────
  Widget _buildOrbeLogo() {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: Listenable.merge([_orbScale, _pulseAnim]),
        builder: (_, child) => Transform.scale(
          scale: _orbScale.value,
          child: child,
        ),
        child: SlideTransition(
          position: _logoSlide,
          child: FadeTransition(
            opacity: _logoOpacity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Halo exterior difuso
                AnimatedBuilder(
                  animation: _pulseAnim,
                  builder: (_, __) => Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3B82F6).withValues(
                            alpha: 0.2 * _pulseAnim.value,
                          ),
                          blurRadius: 80,
                          spreadRadius: 20,
                        ),
                        BoxShadow(
                          color: const Color(0xFF7C3AED).withValues(
                            alpha: 0.15 * _pulseAnim.value,
                          ),
                          blurRadius: 100,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),

                // Anillo exterior giratorio
                AnimatedBuilder(
                  animation: _orbCtrl,
                  builder: (_, child) => Transform.rotate(
                    angle: _orbCtrl.value * 2 * math.pi,
                    child: child,
                  ),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                // Anillo interior (sentido contrario)
                AnimatedBuilder(
                  animation: _orbCtrl,
                  builder: (_, child) => Transform.rotate(
                    angle: -_orbCtrl.value * 2 * math.pi * 0.7,
                    child: child,
                  ),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFA78BFA).withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                  ),
                ),

                // Núcleo del orbe — BackdropFilter solo en no-web (CanvasKit puede fallar)
                ClipOval(
                  child: kIsWeb
                      ? Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const RadialGradient(
                              colors: [Color(0xFF1E3A5F), Color(0xFF0A1628)],
                              center: Alignment(-0.3, -0.3),
                            ),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.military_tech_rounded,
                            color: Colors.white,
                            size: 52,
                          ),
                        )
                      : BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const RadialGradient(
                                colors: [Color(0xFF1E3A5F), Color(0xFF0A1628)],
                                center: Alignment(-0.3, -0.3),
                              ),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.15),
                                width: 1.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.military_tech_rounded,
                              color: Colors.white,
                              size: 52,
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

  // ── Nombre con shimmer ────────────────────────────────────────────────────────
  Widget _buildBrandName() {
    return FadeTransition(
      opacity: _logoOpacity,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _shimmer,
          builder: (_, child) {
            return ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: const [
                  Color(0xFF60A5FA),
                  Color(0xFFE0F2FE),
                  Color(0xFFA78BFA),
                  Color(0xFF60A5FA),
                ],
                stops: [
                  0.0,
                  _shimmer.value - 0.1,
                  _shimmer.value + 0.1,
                  1.0,
                ].map((s) => s.clamp(0.0, 1.0)).toList(),
              ).createShader(bounds),
              child: child,
            );
          },
          child: const Text(
            'EDUPOL',
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 8,
            ),
          ),
        ),
      ),
    );
  }

  // ── Barra de progreso + frases ────────────────────────────────────────────────
  Widget _buildProgressSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: [
          // Barra de progreso con glow
          AnimatedBuilder(
            animation: _progressValue,
            builder: (_, __) => Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withValues(alpha: 0.07),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      width: (_progressValue.value) *
                          (MediaQuery.of(context).size.width - 96),
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF7C3AED)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF3B82F6).withValues(
                              alpha: 0.5,
                            ),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${(_progressValue.value * 100).toInt()}%',
                    style: TextStyle(
                      color: const Color(0xFF60A5FA).withValues(alpha: 0.7),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Frase táctica rotatoria
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: Text(
              _phrases[_phraseIndex],
              key: ValueKey(_phraseIndex),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.55),
                fontSize: 13,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // ── Versículo bíblico ─────────────────────────────────────────────────────────
  Widget _buildVerseSection() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1800),
      curve: Curves.easeOut,
      builder: (context, value, child) =>
          Opacity(opacity: value, child: child),
      child: FutureBuilder<String?>(
        future: BibleService.getDailyVerse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData ||
              snapshot.data == null) {
            return const SizedBox(height: 60);
          }
          // No BackdropFilter on web — causes CanvasKit render issues
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: _verseCard(snapshot.data!),
          );
        },
      ),
    );
  }

  Widget _verseCard(String verse) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF60A5FA), Color(0xFFA78BFA)],
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              verse,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 13,
                fontStyle: FontStyle.italic,
                height: 1.55,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Pintor del fondo de orbes ────────────────────────────────────────────────

class _SplashBgPainter extends CustomPainter {
  final double time;
  final double pulse;
  const _SplashBgPainter({required this.time, required this.pulse});

  @override
  void paint(Canvas canvas, Size size) {
    // Fondo base oscuro
    final bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF060B18), Color(0xFF0A1628), Color(0xFF080E1E)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);

    // Orbes
    _drawOrb(canvas, size, 0.5, 0.35, 0.0, const Color(0xFF3B82F6), 0.65);
    _drawOrb(canvas, size, 0.15, 0.7, 0.3, const Color(0xFF7C3AED), 0.45);
    _drawOrb(canvas, size, 0.85, 0.65, 0.6, const Color(0xFF06B6D4), 0.4);

    // Malla sutil
    final grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.018)
      ..strokeWidth = 0.5;
    const step = 48.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  void _drawOrb(
    Canvas canvas,
    Size size,
    double nx,
    double ny,
    double phase,
    Color color,
    double sizeFactor,
  ) {
    final p = math.sin((time + phase) * 2 * math.pi) * 0.5 + 0.5;
    final radius = (size.shortestSide * sizeFactor) * (0.85 + pulse * 0.15);
    final opacity = 0.06 + p * 0.05;

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color.withValues(alpha: opacity), color.withValues(alpha: 0)],
      ).createShader(
        Rect.fromCircle(
          center: Offset(nx * size.width, ny * size.height),
          radius: radius,
        ),
      );

    if (kIsWeb) {
      paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);
    }
    canvas.drawCircle(
      Offset(nx * size.width, ny * size.height),
      radius,
      paint,
    );
  }

  @override
  bool shouldRepaint(_SplashBgPainter old) =>
      old.time != time || old.pulse != pulse;
}

// ─── Pintor de partículas ─────────────────────────────────────────────────────

class _Particle {
  final double x;
  final double y;
  final double speed;
  final double size;
  final double opacity;
  final Color color;

  const _Particle({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.opacity,
    required this.color,
  });

  factory _Particle.random(math.Random rng) {
    final colors = [
      const Color(0xFF60A5FA),
      const Color(0xFFA78BFA),
      const Color(0xFF34D399),
      const Color(0xFFF472B6),
    ];
    return _Particle(
      x: rng.nextDouble(),
      y: rng.nextDouble(),
      speed: 0.1 + rng.nextDouble() * 0.4,
      size: 1.0 + rng.nextDouble() * 2.5,
      opacity: 0.15 + rng.nextDouble() * 0.35,
      color: colors[rng.nextInt(colors.length)],
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;

  const _ParticlePainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final y = (p.y - progress * p.speed) % 1.0;
      final paint = Paint()
        ..color = p.color.withValues(alpha: p.opacity)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(p.x * size.width, y * size.height),
        p.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.progress != progress;
}

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/services/auth_service.dart';
import 'package:learn/config/app_config.dart';
import 'package:learn/config/neural_design_system.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  bool _isCheckingAuth = false;

  // Single controller for orbs floats
  late AnimationController _orbController;
  late Animation<double> _orbAnimation;

  // Controller for particles connection network tick
  late ValueNotifier<Offset> _mouseNotifier;

  // Controller for bento cards shimmers
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    
    // 60-second repeating loop for drift frequencies calculation
    _orbController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();
    
    _orbAnimation = CurvedAnimation(
      parent: _orbController,
      curve: Curves.linear,
    );

    _mouseNotifier = ValueNotifier<Offset>(const Offset(-999, -999));

    // 4-second repeating loop for bento shimmer sweep
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _shimmerAnimation = CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _orbController.dispose();
    _mouseNotifier.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  void _handleGoogleSignIn() async {
    final authService = context.read<AuthService>();
    final userCred = await authService.signInWithGoogle();

    if (userCred != null) {
      setState(() => _isCheckingAuth = true);
      await authService.checkAndSetAuthorization();
      if (mounted) {
        setState(() => _isCheckingAuth = false);
      }
    } else {
      if (authService.error != null && mounted) {
        _showErrorSnackBar(authService.error!);
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message, style: const TextStyle(fontSize: 13))),
          ],
        ),
        backgroundColor: NeuralDesignSystem.pink.withValues(alpha: 0.9),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _contactSupport() async {
    final Uri url = Uri.parse(
      'https://wa.me/${AppConfig.whatsappNumber}?text=${Uri.encodeComponent("Hola, solicito soporte o información sobre la suscripción de EstudiEO")}',
    );
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (_) {
      _showErrorSnackBar('No se pudo abrir el enlace de soporte.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1000;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: MouseRegion(
        onHover: (e) => _mouseNotifier.value = e.localPosition,
        onExit: (_) => _mouseNotifier.value = const Offset(-999, -999),
        child: Stack(
          children: [
            // Layer 1: Particles Canvas (z-index: 0)
            Positioned.fill(
              child: RepaintBoundary(
                child: _ParticleCanvas(mouseNotifier: _mouseNotifier),
              ),
            ),

            // Layer 2: Floating Orbs (z-index: 1)
            Positioned.fill(
              child: _FloatingOrbs(orbAnimation: _orbAnimation),
            ),

            // Layer 3: Main Content (z-index: 2)
            SafeArea(
              child: Column(
                children: [
                  _buildNavbar(),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 52),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1000),
                          child: isDesktop
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: _buildHeroSection(true),
                                    ),
                                    const SizedBox(width: 48),
                                    Expanded(
                                      flex: 6,
                                      child: _buildRightSideContent(true),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    _buildHeroSection(false),
                                    const SizedBox(height: 52),
                                    _buildRightSideContent(false),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      decoration: const BoxDecoration(
        color: Color(0xB30A0A0F), // rgba(10,10,15,0.7)
        border: Border(
          bottom: BorderSide(
            color: Colors.white10,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF4285F4), Color(0xFF9C27B0), Color(0xFFE91E63)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'E',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'EstudiEO',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFE8EAED),
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          _SupportButton(onTap: _contactSupport),
        ],
      ),
    );
  }

  Widget _buildHeroSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFF8AB4F8).withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF8AB4F8).withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF4285F4), Color(0xFF9C27B0)],
                  ),
                ),
              ),
              const SizedBox(width: 7),
              const Text(
                'SISTEMA DE PREPARACIÓN PNP',
                style: TextStyle(
                  color: Color(0xFF8AB4F8),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        // Title H1
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF8AB4F8), Color(0xFFC084FC), Color(0xFFF472B6)],
            stops: [0.0, 0.45, 0.85],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            isDesktop ? 'Entrenamiento\nAcadémico\nInteligente' : 'Entrenamiento Académico Inteligente',
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 1.22,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Description
        Text(
          'Domina todo el temario con inteligencia activa, repasos espaciados (SRS) y simulacros tipo examen de admisión PNP.',
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF9AA0A6),
            fontSize: 14,
            height: 1.65,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 28),
        // Google Button
        _ScaleButton(
          onTap: _isCheckingAuth ? null : _handleGoogleSignIn,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x4D000000),
                  blurRadius: 6,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: _isCheckingAuth
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF202124)),
                    ),
                  )
                : const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomPaint(
                        size: Size(18, 18),
                        painter: GoogleLogoPainter(),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Iniciar con Google',
                        style: TextStyle(
                          color: Color(0xFF202124),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightSideContent(bool isDesktop) {
    return Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'CARACTERÍSTICAS DEL SISTEMA',
            style: TextStyle(
              color: Color(0xFF5F6368),
              fontSize: 10,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 14),
        // Grid Bento Box
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isDesktop ? 2 : 1,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: isDesktop ? 1.05 : 1.7,
          ),
          children: [
            _BentoCard(
              title: 'Misión Diaria',
              description: 'Resuelve preguntas personalizadas cada día para mantener tu racha.',
              tag: 'Activo',
              icon: Icons.bolt_rounded,
              glowColor: const Color(0xFF4285F4).withValues(alpha: 0.12),
              iconColor: const Color(0xFF8AB4F8),
              iconBgColor: const Color(0x2E4285F4),
              shimmerPhase: 0.0,
              shimmerAnimation: _shimmerAnimation,
            ),
            _BentoCard(
              title: 'Temario PNP',
              description: 'Miles de preguntas oficiales del prospecto PNP vigente.',
              tag: 'Oficial',
              icon: Icons.menu_book_rounded,
              glowColor: const Color(0xFF9C27B0).withValues(alpha: 0.12),
              iconColor: const Color(0xFFC084FC),
              iconBgColor: const Color(0x2E9C27B0),
              shimmerPhase: 0.25, // 1s delay (1s / 4s = 0.25)
              shimmerAnimation: _shimmerAnimation,
            ),
            _BentoCard(
              title: 'Simulacros Reales',
              description: 'Exámenes completos contrarreloj con el formato exacto de admisión.',
              tag: 'Cronometrado',
              icon: Icons.play_circle_outline_rounded,
              glowColor: const Color(0xFF00A884).withValues(alpha: 0.12),
              iconColor: const Color(0xFF34D399),
              iconBgColor: const Color(0x2E00A884),
              shimmerPhase: 0.5, // 2s delay (2s / 4s = 0.5)
              shimmerAnimation: _shimmerAnimation,
            ),
            _BentoCard(
              title: 'Aprendizaje Guiado',
              description: 'Rutas de estudio adaptativas con seguimiento de progreso.',
              tag: 'Adaptativo',
              icon: Icons.alt_route_rounded,
              glowColor: const Color(0xFFF472B6).withValues(alpha: 0.12),
              iconColor: const Color(0xFFF9A8D4),
              iconBgColor: const Color(0x2EF472B6),
              shimmerPhase: 0.125, // 0.5s delay (0.5s / 4s = 0.125)
              shimmerAnimation: _shimmerAnimation,
            ),
          ],
        ),
      ],
    );
  }
}

// ── FLOATING ORBS ──
class _FloatingOrbs extends StatelessWidget {
  final Animation<double> orbAnimation;
  const _FloatingOrbs({required this.orbAnimation});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    
    return AnimatedBuilder(
      animation: orbAnimation,
      builder: (context, _) {
        final double val = orbAnimation.value;
        final double t = val * 2 * math.pi;

        // Orb 1: Blue, top: -80, left: -60 (period: 8s)
        final double t1 = t * (60.0 / 8.0);
        final double dx1 = 12.0 * math.sin(t1);
        final double dy1 = -18.0 * math.cos(t1);
        final double scale1 = 1.0 + 0.05 * math.sin(t1);

        // Orb 2: Purple, bottom: 20, right: 80 (period: 11s, reverse)
        final double t2 = -t * (60.0 / 11.0);
        final double dx2 = 12.0 * math.sin(t2);
        final double dy2 = -18.0 * math.cos(t2);
        final double scale2 = 1.0 + 0.05 * math.sin(t2);

        // Orb 3: Pink, top: 40%, left: 45% (period: 9s, offset 2s phase)
        final double t3 = (t - (2.0 / 60.0) * 2 * math.pi) * (60.0 / 9.0);
        final double dx3 = 12.0 * math.sin(t3);
        final double dy3 = -18.0 * math.cos(t3);
        final double scale3 = 1.0 + 0.05 * math.sin(t3);

        return Stack(
          children: [
            Positioned(
              top: -80 + dy1,
              left: -60 + dx1,
              child: Transform.scale(
                scale: scale1,
                child: const _Orb(
                  size: 280,
                  color: Color(0xFF4285F4),
                  opacity: 0.07,
                ),
              ),
            ),
            Positioned(
              bottom: 20 + dy2,
              right: 80 + dx2,
              child: Transform.scale(
                scale: scale2,
                child: const _Orb(
                  size: 200,
                  color: Color(0xFF9C27B0),
                  opacity: 0.08,
                ),
              ),
            ),
            Positioned(
              top: (screenSize.height * 0.4) + dy3,
              left: (screenSize.width * 0.45) + dx3,
              child: Transform.scale(
                scale: scale3,
                child: const _Orb(
                  size: 160,
                  color: Color(0xFFF472B6),
                  opacity: 0.06,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Orb extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;
  const _Orb({
    required this.size,
    required this.color,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: opacity),
            color.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 0.7],
        ),
      ),
    );
  }
}

// ── PARTICLE CANVAS ──
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
  const _ParticleCanvas({required this.mouseNotifier});

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
        const Color(0xFF8AB4F8),
        const Color(0xFFC084FC),
        const Color(0xFFF9A8D4),
      ];
      for (int i = 0; i < 90; i++) {
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
        final d = math.sqrt(dx * dx + dy * dy);
        if (d < 90) {
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

// ── BENTO CARD ──
class _BentoCard extends StatefulWidget {
  final String title;
  final String description;
  final String tag;
  final IconData icon;
  final Color glowColor;
  final Color iconColor;
  final Color iconBgColor;
  final double shimmerPhase;
  final Animation<double> shimmerAnimation;

  const _BentoCard({
    required this.title,
    required this.description,
    required this.tag,
    required this.icon,
    required this.glowColor,
    required this.iconColor,
    required this.iconBgColor,
    required this.shimmerPhase,
    required this.shimmerAnimation,
  });

  @override
  State<_BentoCard> createState() => _BentoCardState();
}

class _BentoCardState extends State<_BentoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(0.0, _isHovered ? -2.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: _isHovered ? 0.07 : 0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: _isHovered ? 0.15 : 0.08),
            width: 1.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Radial Glow on hover
              if (_isHovered)
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          widget.glowColor,
                          Colors.transparent,
                        ],
                        center: const Alignment(-0.6, -0.4),
                        radius: 0.8,
                      ),
                    ),
                  ),
                ),
              
              // Shimmer overlay
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: widget.shimmerAnimation,
                  builder: (context, _) {
                    final double t = widget.shimmerAnimation.value;
                    final double localT = (t - widget.shimmerPhase) % 1.0;
                    double sweepPos;
                    if (localT < 0.5) {
                      sweepPos = -1.0 + (localT / 0.5) * 2.2;
                    } else {
                      sweepPos = 1.2 - ((localT - 0.5) / 0.5) * 2.2;
                    }
                    
                    return FractionallySizedBox(
                      widthFactor: 0.6,
                      alignment: Alignment(sweepPos, 0.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white10,
                              Colors.transparent,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: widget.iconBgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        widget.icon,
                        color: widget.iconColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Color(0xFFE8EAED),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          widget.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF9AA0A6),
                            fontSize: 12,
                            height: 1.55,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.07),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.tag,
                        style: const TextStyle(
                          color: Color(0xFF9AA0A6),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
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
    );
  }
}

// ── SUPPORT BUTTON ──
class _SupportButton extends StatefulWidget {
  final VoidCallback onTap;
  const _SupportButton({required this.onTap});

  @override
  State<_SupportButton> createState() => _SupportButtonState();
}

class _SupportButtonState extends State<_SupportButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.headset_mic_rounded,
              size: 16,
              color: _isHovered ? const Color(0xFFE8EAED) : const Color(0xFF9AA0A6),
            ),
            const SizedBox(width: 6),
            Text(
              'Soporte',
              style: TextStyle(
                fontSize: 13,
                color: _isHovered ? const Color(0xFFE8EAED) : const Color(0xFF9AA0A6),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── SCALE BUTTON ──
class _ScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  const _ScaleButton({required this.child, this.onTap});

  @override
  State<_ScaleButton> createState() => _ScaleButtonState();
}

class _ScaleButtonState extends State<_ScaleButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.97),
      onTapUp: (_) {
        setState(() => _scale = 1.0);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

// ── GOOGLE LOGO PAINTER ──
class GoogleLogoPainter extends CustomPainter {
  const GoogleLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double sx = size.width / 24.0;
    final double sy = size.height / 24.0;

    // Red path
    final Paint redPaint = Paint()..color = const Color(0xFFEA4335)..style = PaintingStyle.fill;
    final Path redPath = Path()
      ..moveTo(12.0 * sx, 5.38 * sy)
      ..cubicTo(13.62 * sx, 5.38 * sy, 15.06 * sx, 5.94 * sy, 16.21 * sx, 7.02 * sy)
      ..lineTo(19.36 * sx, 3.87 * sy)
      ..cubicTo(17.45 * sx, 2.09 * sy, 14.97 * sx, 1.0 * sy, 12.0 * sx, 1.0 * sy)
      ..cubicTo(7.7 * sx, 1.0 * sy, 3.99 * sx, 3.47 * sy, 2.18 * sx, 7.07 * sy)
      ..lineTo(5.84 * sx, 9.91 * sy)
      ..cubicTo(6.71 * sx, 7.31 * sy, 9.14 * sx, 5.38 * sy, 12.0 * sx, 5.38 * sy)
      ..close();
    canvas.drawPath(redPath, redPaint);

    // Yellow path
    final Paint yellowPaint = Paint()..color = const Color(0xFFFBBC05)..style = PaintingStyle.fill;
    final Path yellowPath = Path()
      ..moveTo(5.84 * sx, 14.09 * sy)
      ..cubicTo(5.62 * sx, 13.43 * sy, 5.49 * sx, 12.73 * sy, 5.49 * sx, 12.0 * sy)
      ..cubicTo(5.49 * sx, 11.27 * sy, 5.62 * sx, 10.57 * sy, 5.84 * sx, 9.91 * sy)
      ..lineTo(2.18 * sx, 7.07 * sy)
      ..cubicTo(1.43 * sx, 8.55 * sy, 1.0 * sx, 10.22 * sy, 1.0 * sx, 12.0 * sy)
      ..cubicTo(1.0 * sx, 13.78 * sy, 1.43 * sx, 15.45 * sy, 2.18 * sx, 16.93 * sy)
      ..lineTo(5.84 * sx, 14.09 * sy)
      ..close();
    canvas.drawPath(yellowPath, yellowPaint);

    // Green path
    final Paint greenPaint = Paint()..color = const Color(0xFF34A853)..style = PaintingStyle.fill;
    final Path greenPath = Path()
      ..moveTo(12.0 * sx, 23.0 * sy)
      ..cubicTo(14.97 * sx, 23.0 * sy, 17.46 * sx, 22.02 * sy, 19.28 * sx, 20.34 * sy)
      ..lineTo(15.71 * sx, 17.57 * sy)
      ..cubicTo(14.73 * sx, 18.23 * sy, 13.48 * sx, 18.63 * sy, 12.0 * sx, 18.63 * sy)
      ..cubicTo(9.14 * sx, 18.63 * sy, 6.71 * sx, 16.7 * sy, 5.84 * sx, 14.09 * sy)
      ..lineTo(2.18 * sx, 16.93 * sy)
      ..cubicTo(3.99 * sx, 20.53 * sy, 7.7 * sx, 23.0 * sy, 12.0 * sx, 23.0 * sy)
      ..close();
    canvas.drawPath(greenPath, greenPaint);

    // Blue path
    final Paint bluePaint = Paint()..color = const Color(0xFF4285F4)..style = PaintingStyle.fill;
    final Path bluePath = Path()
      ..moveTo(22.56 * sx, 12.25 * sy)
      ..cubicTo(22.56 * sx, 11.47 * sy, 22.49 * sx, 10.72 * sy, 22.36 * sx, 10.0 * sy)
      ..lineTo(12.0 * sx, 10.0 * sy)
      ..lineTo(12.0 * sx, 14.26 * sy)
      ..lineTo(17.92 * sx, 14.26 * sy)
      ..cubicTo(17.66 * sx, 15.63 * sy, 16.88 * sx, 16.79 * sy, 15.71 * sx, 17.57 * sy)
      ..lineTo(19.28 * sx, 20.34 * sy)
      ..cubicTo(21.36 * sx, 18.42 * sy, 22.56 * sx, 15.6 * sy, 22.56 * sx, 12.25 * sy)
      ..close();
    canvas.drawPath(bluePath, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

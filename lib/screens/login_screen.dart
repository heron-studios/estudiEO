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

  // Background Aurora Blobs Animation
  late AnimationController _auroraController;
  late Animation<double> _auroraAnimation;

  // Pulse animation for chip dot
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _auroraController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat(reverse: true);
    
    _auroraAnimation = CurvedAnimation(
      parent: _auroraController,
      curve: Curves.easeInOut,
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _auroraController.dispose();
    _pulseController.dispose();
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
      'https://wa.me/${AppConfig.whatsappNumber}?text=${Uri.encodeComponent("Hola, solicito soporte o información sobre la suscripción de PsicoLearn")}',
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
      backgroundColor: const Color(0xFF060A14),
      body: Stack(
        children: [
          // ── AURORA NEURAL BACKGROUND ──
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _auroraAnimation,
              builder: (context, _) {
                final val = _auroraAnimation.value;
                return Stack(
                  children: [
                    // Blob 1: Blue (Top Left)
                    Positioned(
                      top: -100 + (30 * math.sin(val * math.pi * 2)),
                      left: -100 + (30 * math.cos(val * math.pi * 2)),
                      child: Transform.scale(
                        scale: 1.0 + (0.05 * math.sin(val * math.pi * 2)),
                        child: const _AuroraBlob(
                          width: 500,
                          height: 400,
                          color: Color(0xFF4285F4),
                          opacity: 0.22,
                        ),
                      ),
                    ),
                    // Blob 2: Purple (Top Right)
                    Positioned(
                      top: 50 - (20 * math.cos(val * math.pi * 2)),
                      right: -50 + (30 * math.sin(val * math.pi * 2)),
                      child: Transform.scale(
                        scale: 1.0 - (0.03 * math.cos(val * math.pi * 2)),
                        child: const _AuroraBlob(
                          width: 400,
                          height: 500,
                          color: Color(0xFF8A2BE2),
                          opacity: 0.18,
                        ),
                      ),
                    ),
                    // Blob 3: Red (Bottom Left/Center)
                    Positioned(
                      bottom: -50 + (25 * math.sin(val * math.pi * 2)),
                      left: screenWidth * 0.2 + (20 * math.cos(val * math.pi * 2)),
                      child: Transform.scale(
                        scale: 1.0 + (0.04 * math.sin(val * math.pi * 2)),
                        child: const _AuroraBlob(
                          width: 350,
                          height: 300,
                          color: Color(0xFFEA4335),
                          opacity: 0.12,
                        ),
                      ),
                    ),
                    // Blob 4: Green (Bottom Right)
                    Positioned(
                      bottom: 50 - (30 * math.sin(val * math.pi * 2)),
                      right: screenWidth * 0.15 - (20 * math.cos(val * math.pi * 2)),
                      child: Transform.scale(
                        scale: 1.0 - (0.05 * math.cos(val * math.pi * 2)),
                        child: const _AuroraBlob(
                          width: 300,
                          height: 350,
                          color: Color(0xFF34A853),
                          opacity: 0.14,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // ── NEURAL GRID OVERLAY ──
          const Positioned.fill(
            child: CustomPaint(
              painter: _GridPainter(),
            ),
          ),

          // ── MAIN CONTENT ──
          SafeArea(
            child: Column(
              children: [
                // Navbar
                _buildNavbar(),
                
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: isDesktop
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(child: _buildHeroSection(true)),
                                  const SizedBox(width: 60),
                                  Expanded(child: _buildRightSideContent(true)),
                                ],
                              )
                            : Column(
                                children: [
                                  _buildHeroSection(false),
                                  const SizedBox(height: 60),
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
    );
  }

  Widget _buildNavbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
      decoration: const BoxDecoration(
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
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4285F4), Color(0xFF9B59B6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  '🧠',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'PsicoLearn',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFE8EAED),
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: _contactSupport,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.12),
                ),
              ),
              child: const Text(
                'Soporte',
                style: TextStyle(
                  color: Color(0xFF9AA0A6),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // Chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF4285F4).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF4285F4).withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _pulseAnimation.value,
                    child: Transform.scale(
                      scale: _pulseAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF4285F4), Color(0xFF34A853)],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 7),
              const Text(
                'SISTEMA DE PREPARACIÓN PNP',
                style: TextStyle(
                  color: Color(0xFF8AB4F8),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        // Title H1
        Column(
          crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF4285F4), Color(0xFF8AB4F8), Color(0xFFC58AF9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Text(
                'Entrenamiento',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 44,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: -1.0,
                  height: 1.15,
                ),
              ),
            ),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFFEA4335), Color(0xFFFBBC04), Color(0xFF34A853), Color(0xFF4285F4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Text(
                'Psicológico',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 44,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: -1.0,
                  height: 1.15,
                ),
              ),
            ),
            const Text(
              'Inteligente',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 44,
                fontWeight: FontWeight.w500,
                color: Color(0xFFE8EAED),
                letterSpacing: -1.0,
                height: 1.15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Subtitle
        Text(
          'Desarrolla el perfil psicológico y capacidad cognitiva requeridos para tu ingreso a la PNP con retroalimentación en tiempo real y simulación de exámenes.',
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF9AA0A6),
            fontSize: 15,
            height: 1.7,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 36),
        // CTA Group
        _buildCtaGroup(),
        const SizedBox(height: 36),
        // Stats bar
        _buildStatsBar(),
      ],
    );
  }

  Widget _buildCtaGroup() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4285F4).withValues(alpha: 0.25),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: _isCheckingAuth ? null : _handleGoogleSignIn,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4285F4),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              elevation: 0,
            ),
            child: _isCheckingAuth
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'G',
                          style: TextStyle(
                            color: Color(0xFF4285F4),
                            fontFamily: 'Outfit',
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Iniciar con Google',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(width: 14),
        OutlinedButton(
          onPressed: () {
            // Ver demo logic (could just reload/verify or trigger whatsapp demo info)
            _contactSupport();
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFBDC1C6),
            side: const BorderSide(color: Colors.white24),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
          child: const Text('Ver demo'),
        ),
      ],
    );
  }

  Widget _buildStatsBar() {
    return Container(
      padding: const EdgeInsets.only(top: 28),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white12,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          _statItem('50+', 'Preguntas diarias'),
          const SizedBox(width: 28),
          _statItem('98%', 'Tasa de aprobación'),
          const SizedBox(width: 28),
          _statItem('12k', 'Postulantes activos'),
        ],
      ),
    );
  }

  Widget _statItem(String number, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFE8EAED), Color(0xFF9AA0A6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            number,
            style: const TextStyle(
              fontFamily: 'Outfit',
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF5F6368),
            fontSize: 11,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }

  Widget _buildRightSideContent(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDesktop) ...[
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'CARACTERÍSTICAS DEL SISTEMA',
              style: TextStyle(
                color: Color(0xFF5F6368),
                fontSize: 10,
                fontWeight: FontWeight.w500,
                letterSpacing: 2.0,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
        // Grid Bento Box
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isDesktop ? 2 : 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: isDesktop ? 1.3 : 2.0,
          ),
          children: const [
            _BentoCard(
              title: 'Misión Diaria',
              description: 'Resuelve 50 preguntas personalizadas cada día para mantener tu racha.',
              icon: '⚡',
              glowColor: Color(0x264285F4),
              lineColor: Color(0xFF4285F4),
              textColor: Color(0xFF8AB4F8),
              iconColor: Color(0xFF8AB4F8),
              iconBgColor: Color(0x264285F4),
            ),
            _BentoCard(
              title: 'Psicotécnico',
              description: 'Ejercicios interactivos de figuras y razonamiento espacial.',
              icon: '🧩',
              glowColor: Color(0x2E8A2BE2),
              lineColor: Color(0xFF9B59B6),
              textColor: Color(0xFFC58AF9),
              iconColor: Color(0xFFC58AF9),
              iconBgColor: Color(0x269B59B6),
            ),
            _BentoCard(
              title: 'Simulacros Reales',
              description: 'Exámenes completos contrarreloj con la estructura exacta PNP.',
              icon: '🎯',
              glowColor: Color(0x2634A853),
              lineColor: Color(0xFF34A853),
              textColor: Color(0xFF81C995),
              iconColor: Color(0xFF81C995),
              iconBgColor: Color(0x2634A853),
            ),
            _BentoCard(
              title: 'La Escuelita',
              description: 'Retroalimentación y repaso enfocado únicamente en tus errores.',
              icon: '🎓',
              glowColor: Color(0x1FEA4335),
              lineColor: Color(0xFFEA4335),
              textColor: Color(0xFFF28B82),
              iconColor: Color(0xFFF28B82),
              iconBgColor: Color(0x1FEA4335),
            ),
          ],
        ),
      ],
    );
  }
}

class _AuroraBlob extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double opacity;
  const _AuroraBlob({
    required this.width,
    required this.height,
    required this.color,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
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

class _GridPainter extends CustomPainter {
  const _GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4285F4).withValues(alpha: 0.04)
      ..strokeWidth = 1.0;

    const spacing = 40.0;
    
    // Draw vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BentoCard extends StatefulWidget {
  final String title;
  final String description;
  final String icon;
  final Color glowColor;
  final Color lineColor;
  final Color textColor;
  final Color iconColor;
  final Color iconBgColor;

  const _BentoCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.glowColor,
    required this.lineColor,
    required this.textColor,
    required this.iconColor,
    required this.iconBgColor,
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
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: _isHovered ? 0.05 : 0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? Colors.white.withValues(alpha: 0.15)
                : Colors.white.withValues(alpha: 0.08),
            width: 1.0,
          ),
        ),
        child: Stack(
          children: [
            // Hover Glow Effect
            if (_isHovered)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: RadialGradient(
                      colors: [
                        widget.glowColor,
                        Colors.transparent,
                      ],
                      center: const Alignment(-0.6, -0.6),
                      radius: 1.0,
                    ),
                  ),
                ),
              ),
            // Card Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: widget.iconBgColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: widget.lineColor.withValues(alpha: 0.25),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.icon,
                    style: TextStyle(
                      fontSize: 18,
                      color: widget.iconColor,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Color(0xFFE8EAED),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        color: Color(0xFF5F6368),
                        fontSize: 12,
                        height: 1.55,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Bottom Accent Line
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 1.5,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isHovered ? 1.0 : 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        widget.lineColor,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

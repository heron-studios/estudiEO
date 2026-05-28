import 'dart:ui';
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

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  bool _isCheckingAuth = false;

  // Background Aurora Blobs Animation
  late AnimationController _auroraController;
  late Animation<double> _auroraAnimation;

  @override
  void initState() {
    super.initState();
    _auroraController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(reverse: true);
    
    _auroraAnimation = CurvedAnimation(
      parent: _auroraController,
      curve: Curves.easeInOutSine,
    );
  }

  @override
  void dispose() {
    _auroraController.dispose();
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
      'https://wa.me/${AppConfig.whatsappNumber}?text=${Uri.encodeComponent("Hola, solicito soporte o información sobre la suscripción Premium de EstudiEO")}',
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
      backgroundColor: NeuralDesignSystem.background,
      body: Stack(
        children: [
          // ── AURORA BACKGROUND BLOCKS ──
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _auroraAnimation,
              builder: (context, _) {
                final val = _auroraAnimation.value;
                return Stack(
                  children: [
                    // Blob 1: Cyan/Azul (Superior Izquierda)
                    Positioned(
                      top: -150 + (val * 80),
                      left: -150 + (val * 120),
                      child: _AuroraBlob(
                        size: isDesktop ? 600 : 400,
                        color: const Color(0xFF4285F4),
                        opacity: 0.15,
                      ),
                    ),
                    // Blob 2: Morado (Centro Derecha)
                    Positioned(
                      top: 100 - (val * 60),
                      right: -100 - (val * 80),
                      child: _AuroraBlob(
                        size: isDesktop ? 700 : 450,
                        color: const Color(0xFF9B72CB),
                        opacity: 0.18,
                      ),
                    ),
                    // Blob 3: Rosa/Azul (Inferior Izquierda)
                    Positioned(
                      bottom: -200 + (val * 100),
                      left: 50 - (val * 50),
                      child: _AuroraBlob(
                        size: isDesktop ? 550 : 350,
                        color: const Color(0xFFD96570),
                        opacity: 0.12,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // ── MAIN CONTENT ──
          SafeArea(
            child: Column(
              children: [
                // Floating Navbar
                _buildNavbar(),
                
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                                  const SizedBox(height: 48),
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
      margin: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1F20).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: NeuralDesignSystem.neuralGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'EstudiEO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: _contactSupport,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFC4C7C5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.support_agent_rounded, size: 18),
                    SizedBox(width: 8),
                    Text('Soporte', style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1F20).withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.security_rounded, color: Color(0xFF4285F4), size: 16),
              SizedBox(width: 8),
              Text(
                'SISTEMA DE PREPARACIÓN PNP',
                style: TextStyle(
                  color: Color(0xFFC4C7C5),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Title H1
        ShaderMask(
          shaderCallback: (bounds) => NeuralDesignSystem.neuralGradient.createShader(bounds),
          child: Text(
            'Entrenamiento Académico Inteligente',
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: isDesktop ? 48 : 32,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.0,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 18),
        // Subtitle
        Text(
          'Domina todo el temario de conocimientos con inteligencia activa, repasos espaciados (SRS) y simulacros tipo examen de admisión PNP.',
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFC4C7C5),
            fontSize: 16,
            height: 1.6,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 36),
        // CTA Button
        _buildGoogleSignInButton(),
      ],
    );
  }

  Widget _buildGoogleSignInButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4285F4).withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isCheckingAuth ? null : _handleGoogleSignIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF131314),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
        ),
        child: _isCheckingAuth
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF131314)),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
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
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'INICIAR CON GOOGLE',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildRightSideContent(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDesktop) ...[
          const Text(
            'CARACTERÍSTICAS DEL SISTEMA',
            style: TextStyle(
              color: Color(0xFF9B72CB),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 24),
        ],
        // Grid Bento Box
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isDesktop ? 2 : 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isDesktop ? 1.3 : 2.0,
          ),
          children: const [
            _BentoCard(
              title: 'Misión Diaria',
              description: 'Resuelve preguntas personalizadas cada día para mantener tu racha.',
              icon: Icons.bolt_rounded,
              gradientColors: [Color(0xFF00E5FF), Color(0xFF4285F4)],
            ),
            _BentoCard(
              title: 'Temario PNP',
              description: 'Miles de preguntas oficiales actualizadas del prospecto PNP vigente.',
              icon: Icons.collections_bookmark_rounded,
              gradientColors: [Color(0xFF9B72CB), Color(0xFFD96570)],
            ),
            _BentoCard(
              title: 'Simulacros Reales',
              description: 'Exámenes completos contrarreloj con el formato exacto de admisión.',
              icon: Icons.timer_rounded,
              gradientColors: [Color(0xFF4285F4), Color(0xFF9B72CB)],
            ),
            _BentoCard(
              title: 'Tutor Alipio IA',
              description: 'Explicaciones detalladas y nemotécnias automáticas impulsadas por IA.',
              icon: Icons.auto_awesome_rounded,
              gradientColors: [Color(0xFFD96570), Color(0xFF00E5FF)],
            ),
          ],
        ),
      ],
    );
  }
}

class _AuroraBlob extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;
  const _AuroraBlob({required this.size, required this.color, required this.opacity});

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
        ),
      ),
    );
  }
}

class _BentoCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradientColors;

  const _BentoCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradientColors,
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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1F20).withValues(alpha: _isHovered ? 0.6 : 0.4),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? widget.gradientColors.first.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.08),
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.gradientColors.first.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: widget.gradientColors.first.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.icon,
                color: widget.gradientColors.first,
                size: 24,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.description,
                  style: const TextStyle(
                    color: Color(0xFFC4C7C5),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

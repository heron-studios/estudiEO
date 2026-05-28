import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/services/auth_service.dart';
import 'package:learn/config/neural_design_system.dart';
import 'package:learn/config/app_config.dart';

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
//  Painter: Neural Mesh Background (animated blobs)
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _NeuralMeshPainter extends CustomPainter {
  final double t;
  _NeuralMeshPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Blob 1 â€“ Blue
    _drawBlob(
      canvas,
      w * (0.1 + 0.08 * math.sin(t * math.pi * 2)),
      h * (0.15 + 0.06 * math.cos(t * math.pi * 2 * 0.8)),
      w * 0.55,
      const Color(0xFF4285F4),
      0.16,
    );

    // Blob 2 â€“ Purple
    _drawBlob(
      canvas,
      w * (0.85 - 0.07 * math.cos(t * math.pi * 2 * 1.1)),
      h * (0.2 + 0.08 * math.sin(t * math.pi * 2 * 0.7)),
      w * 0.50,
      const Color(0xFF9B72CB),
      0.15,
    );

    // Blob 3 â€“ Pink
    _drawBlob(
      canvas,
      w * (0.5 + 0.1 * math.sin(t * math.pi * 2 * 0.6)),
      h * (0.55 + 0.07 * math.cos(t * math.pi * 2 * 0.9)),
      w * 0.45,
      const Color(0xFFD96570),
      0.13,
    );

    // Blob 4 â€“ Cyan
    _drawBlob(
      canvas,
      w * (0.75 + 0.06 * math.sin(t * math.pi * 2 * 1.3)),
      h * (0.75 + 0.05 * math.cos(t * math.pi * 2 * 0.5)),
      w * 0.38,
      const Color(0xFF22D3EE),
      0.12,
    );

    // Blob 5 â€“ Blue accent (small, bottom-left)
    _drawBlob(
      canvas,
      w * (0.15 - 0.05 * math.cos(t * math.pi * 2 * 0.75)),
      h * (0.82 + 0.06 * math.sin(t * math.pi * 2 * 1.1)),
      w * 0.35,
      const Color(0xFF4285F4),
      0.10,
    );
  }

  void _drawBlob(
    Canvas canvas,
    double cx,
    double cy,
    double radius,
    Color color,
    double opacity,
  ) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withValues(alpha: opacity),
          color.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: radius))
      ..blendMode = BlendMode.screen;
    canvas.drawCircle(Offset(cx, cy), radius, paint);
  }

  @override
  bool shouldRepaint(_NeuralMeshPainter old) => old.t != t;
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
//  Main LoginScreen Widget
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool _isCheckingAuth = false;

  // Neural mesh animation
  late AnimationController _meshCtrl;
  // Hero sparkle pulse
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;
  // Card entrance
  late AnimationController _entranceCtrl;
  late Animation<double> _entranceAnim;

  @override
  void initState() {
    super.initState();
    _meshCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _entranceAnim = CurvedAnimation(
      parent: _entranceCtrl,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _meshCtrl.dispose();
    _pulseCtrl.dispose();
    _entranceCtrl.dispose();
    super.dispose();
  }

  // â”€â”€ Auth â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  void _handleGoogleSignIn() async {
    final authService = context.read<AuthService>();
    final userCred = await authService.signInWithGoogle();
    if (userCred != null) {
      setState(() => _isCheckingAuth = true);
      await authService.checkAndSetAuthorization();
      if (mounted) setState(() => _isCheckingAuth = false);
    } else if (authService.error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authService.error!),
          backgroundColor: NeuralDesignSystem.pink,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _launchUrl(
    String urlStr, {
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    final uri = Uri.parse(urlStr);
    try {
      await launchUrl(uri, mode: mode);
    } catch (_) {}
  }

  Future<void> _launchWhatsApp(String text) async {
    await _launchUrl(
      'https://wa.me/${AppConfig.whatsappNumber}?text=${Uri.encodeComponent(text)}',
    );
  }

  Future<void> _launchPsicoLearn() async =>
      _launchUrl('https://pnp-edu.github.io/PsicoLearn/');

  // â”€â”€ Build â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final sw = MediaQuery.of(context).size.width;
    final isWide = sw > 820;

    return Scaffold(
      backgroundColor: NeuralDesignSystem.background,
      body: Stack(
        children: [
          // â‘  Animated Neural Mesh Background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _meshCtrl,
              builder: (_, __) =>
                  CustomPaint(painter: _NeuralMeshPainter(_meshCtrl.value)),
            ),
          ),

          // â‘¡ Global glass tint layer
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(color: Colors.transparent),
            ),
          ),

          // â‘¢ Main scrollable content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildNavbar(),
                  _buildHero(isWide),
                  const SizedBox(height: 48),
                  _buildCards(isWide, authService),
                  const SizedBox(height: 72),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€â”€ Navbar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildNavbar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 900),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.10),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo pill
                  ShaderMask(
                    shaderCallback: (b) =>
                        NeuralDesignSystem.neuralGradient.createShader(b),
                    child: const Text(
                      'estudiEO',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  // Nav links
                  Row(
                    children: [
                      _navLink('Inicio'),
                      const SizedBox(width: 24),
                      _navLink('Planes'),
                      const SizedBox(width: 24),
                      _navLink('Contacto'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navLink(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 13,
        color: Colors.white.withValues(alpha: 0.65),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
    );
  }

  // â”€â”€â”€ Hero â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildHero(bool isWide) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 56, 24, 0),
      child: Column(
        children: [
          // Volumetric Sparkle Icon
          ScaleTransition(scale: _pulseAnim, child: _buildVolumetricIcon()),
          const SizedBox(height: 40),

          // Hero Title
          ScaleTransition(
            scale: _entranceAnim,
            child: ShaderMask(
              shaderCallback: (b) =>
                  NeuralDesignSystem.neuralGradient.createShader(b),
              child: Text(
                'estudiEO & psicoLearn',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: isWide ? 64 : 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -2.0,
                  height: 1.05,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Hero Subtitle
          Text(
            'Tu preparaciÃ³n integral para ingresar a la Escuela PNP.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: isWide ? 19 : 16,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.70),
              height: 1.55,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Domina el conocimiento. Supera los tests psicomÃ©tricos. Asegura tu vacante.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: isWide ? 15 : 13,
              color: Colors.white.withValues(alpha: 0.45),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVolumetricIcon() {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow rings
          for (int i = 0; i < 3; i++)
            Container(
              width: 120.0 - i * 18,
              height: 120.0 - i * 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: [
                    const Color(0xFF4285F4),
                    const Color(0xFF9B72CB),
                    const Color(0xFFD96570),
                  ][i].withValues(alpha: 0.18 - i * 0.04),
                  width: 1,
                ),
              ),
            ),
          // Inner glass orb
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF9B72CB).withValues(alpha: 0.35),
                  const Color(0xFF4285F4).withValues(alpha: 0.20),
                  Colors.transparent,
                ],
                stops: const [0, 0.6, 1],
                center: const Alignment(-0.3, -0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4285F4).withValues(alpha: 0.30),
                  blurRadius: 40,
                  spreadRadius: 6,
                ),
                BoxShadow(
                  color: const Color(0xFF9B72CB).withValues(alpha: 0.25),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Center(
                  child: ShaderMask(
                    shaderCallback: (b) => NeuralDesignSystem.neuralGradient
                        .createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
                    child: const Icon(
                      Icons.auto_awesome,
                      size: 38,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€â”€ Cards â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildCards(bool isWide, AuthService authService) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 48 : 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: isWide
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _EstudieoCard(
                          authService: authService,
                          isCheckingAuth: _isCheckingAuth,
                          onGoogleSignIn: _handleGoogleSignIn,
                          onBuyWhatsapp: () => _launchWhatsApp(
                            'Hola! Quiero comprar el acceso completo a EstudiEO (conocimientos)',
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _PsicoLearnCard(
                          onGoToPsico: _launchPsicoLearn,
                          onBuyWhatsapp: () => _launchWhatsApp(
                            'Hola! Quiero comprar el acceso completo a PsicoLearn (psicomÃ©trico)',
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    _EstudieoCard(
                      authService: authService,
                      isCheckingAuth: _isCheckingAuth,
                      onGoogleSignIn: _handleGoogleSignIn,
                      onBuyWhatsapp: () => _launchWhatsApp(
                        'Hola! Quiero comprar el acceso completo a EstudiEO (conocimientos)',
                      ),
                    ),
                    const SizedBox(height: 24),
                    _PsicoLearnCard(
                      onGoToPsico: _launchPsicoLearn,
                      onBuyWhatsapp: () => _launchWhatsApp(
                        'Hola! Quiero comprar el acceso completo a PsicoLearn (psicomÃ©trico)',
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // â”€â”€â”€ Footer â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
      child: Column(
        children: [
          // Separator line with gradient
          Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: NeuralDesignSystem.neuralGradient,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (b) =>
                        NeuralDesignSystem.neuralGradient.createShader(b),
                    child: const Text(
                      'pnp-edu',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Â© 2026 Â· Todos los derechos reservados',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.35),
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 20,
                children: [
                  _footerIcon(
                    Icons.mail_outline_rounded,
                    'mailto:soporte@estudieo.pe',
                  ),
                  _footerIcon(
                    Icons.chat_rounded,
                    'https://wa.me/${AppConfig.whatsappNumber}',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerIcon(IconData icon, String url) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        ),
        child: Icon(
          icon,
          color: Colors.white.withValues(alpha: 0.55),
          size: 18,
        ),
      ),
    );
  }
}

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
//  EstudieoCard â€“ "Vaina de Vidrio" Azul
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
class _EstudieoCard extends StatefulWidget {
  final AuthService authService;
  final bool isCheckingAuth;
  final VoidCallback onGoogleSignIn;
  final VoidCallback onBuyWhatsapp;

  const _EstudieoCard({
    required this.authService,
    required this.isCheckingAuth,
    required this.onGoogleSignIn,
    required this.onBuyWhatsapp,
  });

  @override
  State<_EstudieoCard> createState() => _EstudieoCardState();
}

class _EstudieoCardState extends State<_EstudieoCard> {
  bool _hoverGoogle = false;
  bool _hoverBuy = false;

  static const _features = [
    (
      'Banco de preguntas oficiales PNP',
      'Miles de preguntas reales actualizadas del prospecto vigente.',
    ),
    (
      'Repaso guiado por Alipio IA',
      'NemotÃ©cnias y explicaciones generadas por inteligencia artificial.',
    ),
    (
      'Simulacros cronometrados',
      'Practica con el formato exacto: 100 preguntas, 3 horas.',
    ),
    (
      'Algoritmo SRS inteligente',
      'Estudia eficientemente: el sistema decide quÃ© revisar primero.',
    ),
    (
      'EstadÃ­sticas de progreso real',
      'Dashboard detallado para medir tu avance hacia la vacante.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4285F4).withValues(alpha: 0.08),
            const Color(0xFF9B72CB).withValues(alpha: 0.06),
            Colors.white.withValues(alpha: 0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color(0xFF4285F4).withValues(alpha: 0.25),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4285F4).withValues(alpha: 0.10),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _cardHeader(
                  icon: Icons.school_rounded,
                  iconColor: const Color(0xFF4285F4),
                  title: 'estudiEO',
                  subtitle: 'MÃ³dulo de Conocimientos Â· S/30',
                  subtitleColor: const Color(0xFF93C5FD),
                ),
                const SizedBox(height: 22),
                Text(
                  'Domina todo el prospecto acadÃ©mico con Inteligencia Activa, repasos espaciados y simulacros oficiales de 100 preguntas.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.65),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(color: Colors.white10, height: 1),
                const SizedBox(height: 22),
                ...(_features.map(
                  (f) => _featurePod(f.$1, f.$2, const Color(0xFF4285F4)),
                )),
                const SizedBox(height: 28),
                if (widget.authService.isLoading || widget.isCheckingAuth)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: CircularProgressIndicator(
                        color: Color(0xFF4285F4),
                        strokeWidth: 2,
                      ),
                    ),
                  )
                else ...[
                  _portalButton(
                    label: 'Ingresar con Google',
                    icon: Icons.g_mobiledata_rounded,
                    colors: [const Color(0xFF2563EB), const Color(0xFF7C3AED)],
                    glowColor: const Color(0xFF4285F4),
                    isHovered: _hoverGoogle,
                    onHover: (v) => setState(() => _hoverGoogle = v),
                    onTap: widget.onGoogleSignIn,
                    iconBgWhite: true,
                  ),
                  const SizedBox(height: 14),
                  _buyLink(
                    label: 'Comprar Acceso Premium',
                    isHovered: _hoverBuy,
                    onHover: (v) => setState(() => _hoverBuy = v),
                    onTap: widget.onBuyWhatsapp,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
//  PsicoLearnCard â€“ "Vaina de Vidrio" Morada
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
class _PsicoLearnCard extends StatefulWidget {
  final VoidCallback onGoToPsico;
  final VoidCallback onBuyWhatsapp;

  const _PsicoLearnCard({
    required this.onGoToPsico,
    required this.onBuyWhatsapp,
  });

  @override
  State<_PsicoLearnCard> createState() => _PsicoLearnCardState();
}

class _PsicoLearnCardState extends State<_PsicoLearnCard> {
  bool _hoverGo = false;
  bool _hoverBuy = false;

  static const _features = [
    (
      'Test de personalidad calificados',
      'Evaluaciones psicomÃ©tricas reales con puntuaciÃ³n y feedback detallado.',
    ),
    (
      'Aptitud cognitiva y lÃ³gica',
      'Simulacros de razonamiento abstracto y verbal de precisiÃ³n clÃ­nica.',
    ),
    (
      'Simulador de Entrevista Personal',
      'GuÃ­as y preguntas tipo para superar la fase oral sin nervios.',
    ),
    (
      'EvaluaciÃ³n de conducta adaptativa',
      'Comprende y practica los criterios de selecciÃ³n psicolÃ³gica PNP.',
    ),
    (
      'Acceso permanente de por vida',
      'Un solo pago. Sin mensualidades. Actualizaciones incluidas.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF9B72CB).withValues(alpha: 0.08),
            const Color(0xFFD96570).withValues(alpha: 0.05),
            Colors.white.withValues(alpha: 0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color(0xFF9B72CB).withValues(alpha: 0.25),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9B72CB).withValues(alpha: 0.10),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _cardHeader(
                  icon: Icons.psychology_rounded,
                  iconColor: const Color(0xFF9B72CB),
                  title: 'psicoLearn',
                  subtitle: 'MÃ³dulo PsicomÃ©trico y MÃ©dico Â· S/30',
                  subtitleColor: const Color(0xFFC084FC),
                ),
                const SizedBox(height: 22),
                Text(
                  'Supera las pruebas psicomÃ©tricas, los test de personalidad y prepÃ¡rate de forma profesional para tu entrevista personal.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.65),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(color: Colors.white10, height: 1),
                const SizedBox(height: 22),
                ...(_features.map(
                  (f) => _featurePod(f.$1, f.$2, const Color(0xFF9B72CB)),
                )),
                const SizedBox(height: 28),
                _portalButton(
                  label: 'Ir a PsicoLearn',
                  icon: Icons.open_in_new_rounded,
                  colors: [const Color(0xFF7C3AED), const Color(0xFFC084FC)],
                  glowColor: const Color(0xFF9B72CB),
                  isHovered: _hoverGo,
                  onHover: (v) => setState(() => _hoverGo = v),
                  onTap: widget.onGoToPsico,
                  iconBgWhite: false,
                ),
                const SizedBox(height: 14),
                _buyLink(
                  label: 'Comprar Acceso Premium',
                  isHovered: _hoverBuy,
                  onHover: (v) => setState(() => _hoverBuy = v),
                  onTap: widget.onBuyWhatsapp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
//  Shared helper widgets
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
Widget _cardHeader({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String subtitle,
  required Color subtitleColor,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: iconColor.withValues(alpha: 0.20)),
        ),
        child: Icon(icon, color: iconColor, size: 28),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: subtitleColor,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _featurePod(String title, String description, Color accentColor) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_rounded, color: accentColor, size: 12),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.50),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _portalButton({
  required String label,
  required IconData icon,
  required List<Color> colors,
  required Color glowColor,
  required bool isHovered,
  required ValueChanged<bool> onHover,
  required VoidCallback onTap,
  bool iconBgWhite = false,
}) {
  return MouseRegion(
    onEnter: (_) => onHover(true),
    onExit: (_) => onHover(false),
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 54,
        transform: isHovered
            ? Matrix4.diagonal3Values(1.025, 1.025, 1.0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: glowColor.withValues(alpha: isHovered ? 0.55 : 0.30),
              blurRadius: isHovered ? 28 : 16,
              spreadRadius: isHovered ? 2 : 0,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconBgWhite)
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.black87, size: 18),
              )
            else
              Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buyLink({
  required String label,
  required bool isHovered,
  required ValueChanged<bool> onHover,
  required VoidCallback onTap,
}) {
  return MouseRegion(
    onEnter: (_) => onHover(true),
    onExit: (_) => onHover(false),
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.message_rounded, color: Color(0xFF4ADE80), size: 16),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4ADE80),
                  letterSpacing: 0.2,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 1.5,
                width: isHovered ? 180 : 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF4ADE80),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    if (isHovered)
                      const BoxShadow(
                        color: Color(0xFF4ADE80),
                        blurRadius: 6,
                        spreadRadius: 0,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

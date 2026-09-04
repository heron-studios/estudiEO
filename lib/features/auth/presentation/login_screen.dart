import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/core/config/app_config.dart';
import 'package:learn/core/config/neural_design_system.dart';
import 'package:learn/core/widgets/particles_canvas.dart';
import 'package:learn/core/widgets/floating_orbs.dart';
import 'package:learn/features/auth/presentation/widgets/shader_horizontal_gallery.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool _isCheckingAuth = false;

  // Single controller for orbs floats
  late AnimationController _orbController;
  late Animation<double> _orbAnimation;

  // Controller for particles connection network tick
  late ValueNotifier<Offset> _mouseNotifier;

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
  }

  @override
  void dispose() {
    _orbController.dispose();
    _mouseNotifier.dispose();
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
            Expanded(
              child: Text(message, style: const TextStyle(fontSize: 13)),
            ),
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
      'https://wa.me/${AppConfig.whatsappNumber}?text=${Uri.encodeComponent("Hola, solicito soporte o información sobre la suscripción de EDUPOL")}',
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
                child: ParticleCanvas(mouseNotifier: _mouseNotifier),
              ),
            ),

            // Layer 2: Floating Orbs (z-index: 1)
            Positioned.fill(
              child: RepaintBoundary(
                child: FloatingOrbs(orbAnimation: _orbAnimation),
              ),
            ),

            // Layer 3: Main Content (z-index: 2)
            RepaintBoundary(
              child: SafeArea(
                child: Column(
                  children: [
                    if (isDesktop) _buildNavbar(),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 52,
                                ),
                                alignment: Alignment.center,
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 1100,
                                  ),
                                  child: isDesktop
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: _buildHeroSection(true),
                                            ),
                                            const SizedBox(width: 48),
                                            Expanded(
                                              flex: 6,
                                              child: _buildRightSideContent(
                                                true,
                                              ),
                                            ),
                                          ],
                                        )
                                      : _buildHeroSection(false),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
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
        border: Border(bottom: BorderSide(color: Colors.white10, width: 1.0)),
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
                    colors: [
                      Color(0xFF4285F4),
                      Color(0xFF9C27B0),
                      Color(0xFFE91E63),
                    ],
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
                'EDUPOL',
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
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
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
            isDesktop
                ? 'Entrenamiento\nAcadémico\nInteligente'
                : 'Entrenamiento Académico Inteligente',
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
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF202124),
                      ),
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
        const SizedBox(height: 16),
        // Demo Button removed for freemium model.
      ],
    );
  }

  Future<void> _downloadAndroidApk() async {
    final url = Uri.parse(AppConfig.androidApkDownloadUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _downloadWindows() async {
    const urlStr = AppConfig.windowsDownloadUrl;
    if (urlStr != null && urlStr.isNotEmpty) {
      final url = Uri.parse(urlStr);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
        return;
      }
    }
    _showPlatformInfoDialog(
      platform: 'Windows (PC)',
      icon: Icons.desktop_windows_rounded,
      accentColor: const Color(0xFF0078D7),
      message:
          'El paquete instalador oficial para Windows (.exe) se encuentra en su fase final de compilación. Mientras tanto, puedes usar la versión Web completa en tu navegador o descargar el APK en tu celular Android.',
    );
  }

  Future<void> _downloadMac() async {
    const urlStr = AppConfig.macDownloadUrl;
    if (urlStr != null && urlStr.isNotEmpty) {
      final url = Uri.parse(urlStr);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
        return;
      }
    }
    _showPlatformInfoDialog(
      platform: 'macOS (Mac)',
      icon: Icons.laptop_mac_rounded,
      accentColor: const Color(0xFFA1A1AA),
      message:
          'El instalador para Mac (.dmg universal para procesadores Apple Silicon M1/M2/M3/M4 e Intel) estará disponible muy pronto. Actualmente puedes usar EDUPOL Web directamente en tu Mac o el APK oficial para Android.',
    );
  }



  void _showPlatformInfoDialog({
    required String platform,
    required IconData icon,
    required Color accentColor,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Cerrar',
      barrierColor: Colors.black.withValues(alpha: 0.7),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (ctx, anim1, anim2) {
        return Center(
          child: Container(
            width: 440,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: accentColor.withValues(alpha: 0.45),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.25),
                  blurRadius: 35,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.8),
                  blurRadius: 45,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: accentColor.withValues(alpha: 0.35)),
                    ),
                    child: Icon(icon, color: accentColor, size: 36),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    platform,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text(
                          'Entendido',
                          style: TextStyle(color: Colors.white60),
                        ),
                      ),
                      if (actionLabel != null && onAction != null) ...[
                        const SizedBox(width: 8),
                        FilledButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            onAction();
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: accentColor,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(actionLabel),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRightSideContent(bool isDesktop) {
    final items = [
      ShaderGalleryItem(
        id: 'apk',
        title: 'Android Móvil',
        format: '.APK Directa Oficial',
        badge: 'OFICIAL · RECOMENDADO',
        badgeColor: const Color(0xFF34D399),
        image: 'assets/images/promo_1.jpg',
        accentColor: const Color(0xFF10B981),
        icon: Icons.android_rounded,
        description:
            'Simulacros reales y preparación táctica en tu celular con bancos de preguntas actualizados.',
        specs: const [
          'Instalación directa sin intermediarios',
          'Modo de estudio táctico sin conexión',
          'Alineado al Prospecto Oficial PNP 2026',
        ],
        buttonLabel: 'Descargar APK Directa',
        onDownload: _downloadAndroidApk,
      ),
      ShaderGalleryItem(
        id: 'win',
        title: 'Windows PC',
        format: '.EXE Instalador',
        badge: '64-BIT DESKTOP',
        badgeColor: const Color(0xFF38BDF8),
        image: 'assets/images/promo_2.jpg',
        accentColor: const Color(0xFF0078D7),
        icon: Icons.desktop_windows_rounded,
        description:
            'Aceleración por GPU DirectX y modo examen a pantalla completa para máxima concentración.',
        specs: const [
          'Aceleración de gráficos DirectX nativa',
          'Atajos de teclado tácticos para examen',
          'Rendimiento ultra veloz y sin lag',
        ],
        buttonLabel: 'Descargar .EXE',
        onDownload: _downloadWindows,
      ),
      ShaderGalleryItem(
        id: 'mac',
        title: 'macOS Mac',
        format: '.DMG Universal',
        badge: 'APPLE SILICON & INTEL',
        badgeColor: const Color(0xFFE4E4E7),
        image: 'assets/images/promo_3.jpg',
        accentColor: const Color(0xFFA1A1AA),
        icon: Icons.laptop_mac_rounded,
        description:
            'Optimizado nativamente para chips Apple Silicon (M1/M2/M3/M4) e Intel con fluidez a 120Hz.',
        specs: const [
          'Fluidez nativa en pantallas Retina Display',
          'Bajo consumo de batería en MacBook',
          'Compatible con macOS Sequoia y anteriores',
        ],
        buttonLabel: 'Descargar .DMG',
        onDownload: _downloadMac,
      ),
    ];

    return ShaderHorizontalGallery(
      items: items,
      isDesktop: isDesktop,
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
              color: _isHovered
                  ? const Color(0xFFE8EAED)
                  : const Color(0xFF9AA0A6),
            ),
            const SizedBox(width: 6),
            Text(
              'Soporte',
              style: TextStyle(
                fontSize: 13,
                color: _isHovered
                    ? const Color(0xFFE8EAED)
                    : const Color(0xFF9AA0A6),
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
    final Paint redPaint = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.fill;
    final Path redPath = Path()
      ..moveTo(12.0 * sx, 5.38 * sy)
      ..cubicTo(
        13.62 * sx,
        5.38 * sy,
        15.06 * sx,
        5.94 * sy,
        16.21 * sx,
        7.02 * sy,
      )
      ..lineTo(19.36 * sx, 3.87 * sy)
      ..cubicTo(
        17.45 * sx,
        2.09 * sy,
        14.97 * sx,
        1.0 * sy,
        12.0 * sx,
        1.0 * sy,
      )
      ..cubicTo(7.7 * sx, 1.0 * sy, 3.99 * sx, 3.47 * sy, 2.18 * sx, 7.07 * sy)
      ..lineTo(5.84 * sx, 9.91 * sy)
      ..cubicTo(
        6.71 * sx,
        7.31 * sy,
        9.14 * sx,
        5.38 * sy,
        12.0 * sx,
        5.38 * sy,
      )
      ..close();
    canvas.drawPath(redPath, redPaint);

    // Yellow path
    final Paint yellowPaint = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.fill;
    final Path yellowPath = Path()
      ..moveTo(5.84 * sx, 14.09 * sy)
      ..cubicTo(
        5.62 * sx,
        13.43 * sy,
        5.49 * sx,
        12.73 * sy,
        5.49 * sx,
        12.0 * sy,
      )
      ..cubicTo(
        5.49 * sx,
        11.27 * sy,
        5.62 * sx,
        10.57 * sy,
        5.84 * sx,
        9.91 * sy,
      )
      ..lineTo(2.18 * sx, 7.07 * sy)
      ..cubicTo(1.43 * sx, 8.55 * sy, 1.0 * sx, 10.22 * sy, 1.0 * sx, 12.0 * sy)
      ..cubicTo(
        1.0 * sx,
        13.78 * sy,
        1.43 * sx,
        15.45 * sy,
        2.18 * sx,
        16.93 * sy,
      )
      ..lineTo(5.84 * sx, 14.09 * sy)
      ..close();
    canvas.drawPath(yellowPath, yellowPaint);

    // Green path
    final Paint greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.fill;
    final Path greenPath = Path()
      ..moveTo(12.0 * sx, 23.0 * sy)
      ..cubicTo(
        14.97 * sx,
        23.0 * sy,
        17.46 * sx,
        22.02 * sy,
        19.28 * sx,
        20.34 * sy,
      )
      ..lineTo(15.71 * sx, 17.57 * sy)
      ..cubicTo(
        14.73 * sx,
        18.23 * sy,
        13.48 * sx,
        18.63 * sy,
        12.0 * sx,
        18.63 * sy,
      )
      ..cubicTo(
        9.14 * sx,
        18.63 * sy,
        6.71 * sx,
        16.7 * sy,
        5.84 * sx,
        14.09 * sy,
      )
      ..lineTo(2.18 * sx, 16.93 * sy)
      ..cubicTo(
        3.99 * sx,
        20.53 * sy,
        7.7 * sx,
        23.0 * sy,
        12.0 * sx,
        23.0 * sy,
      )
      ..close();
    canvas.drawPath(greenPath, greenPaint);

    // Blue path
    final Paint bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;
    final Path bluePath = Path()
      ..moveTo(22.56 * sx, 12.25 * sy)
      ..cubicTo(
        22.56 * sx,
        11.47 * sy,
        22.49 * sx,
        10.72 * sy,
        22.36 * sx,
        10.0 * sy,
      )
      ..lineTo(12.0 * sx, 10.0 * sy)
      ..lineTo(12.0 * sx, 14.26 * sy)
      ..lineTo(17.92 * sx, 14.26 * sy)
      ..cubicTo(
        17.66 * sx,
        15.63 * sy,
        16.88 * sx,
        16.79 * sy,
        15.71 * sx,
        17.57 * sy,
      )
      ..lineTo(19.28 * sx, 20.34 * sy)
      ..cubicTo(
        21.36 * sx,
        18.42 * sy,
        22.56 * sx,
        15.6 * sy,
        22.56 * sx,
        12.25 * sy,
      )
      ..close();
    canvas.drawPath(bluePath, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

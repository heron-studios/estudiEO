import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/core/config/app_config.dart';

/// Botón oficial ultra-premium para descargar e instalar la app desde Google Play Store.
/// Creado bajo los estándares estrictos de Apple Design:
/// - Respuesta táctil instantánea en pointer-down (micro-escala 0.965).
/// - Hápticos de confirmación inmediata.
/// - Logotipo vectorial oficial de Google Play con los 4 colores de marca.
/// - Reflejo superior de luz y profundidad visual.
class GooglePlayButton extends StatefulWidget {
  final VoidCallback? onTap;
  final double? width;
  final double height;
  final String topLabel;
  final String mainLabel;
  final bool showBadge;
  final bool isHero;

  const GooglePlayButton({
    super.key,
    this.onTap,
    this.width,
    this.height = 56.0,
    this.topLabel = 'DISPONIBLE EN',
    this.mainLabel = 'Google Play',
    this.showBadge = true,
    this.isHero = true,
  });

  @override
  State<GooglePlayButton> createState() => _GooglePlayButtonState();
}

class _GooglePlayButtonState extends State<GooglePlayButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  Future<void> _handleTap() async {
    HapticFeedback.lightImpact();
    if (widget.onTap != null) {
      widget.onTap!();
      return;
    }

    final uri = Uri.parse(AppConfig.playStoreUrl);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _handleTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.965 : (_isHovered ? 1.015 : 1.0),
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOutCubic,
          child: Container(
            width: widget.width,
            height: widget.height,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.isHero
                    ? [
                        const Color(0xFF047857),
                        const Color(0xFF059669),
                        const Color(0xFF10B981),
                      ]
                    : [
                        const Color(0xFF0F172A),
                        const Color(0xFF1E293B),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.isHero
                    ? const Color(0xFF34D399).withValues(alpha: 0.7)
                    : const Color(0xFF10B981).withValues(alpha: 0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF10B981).withValues(
                    alpha: _isHovered ? 0.45 : 0.30,
                  ),
                  blurRadius: _isHovered ? 20 : 14,
                  spreadRadius: _isHovered ? 2 : 0,
                  offset: const Offset(0, 5),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Reflejo sutil de luz superior (Apple Design)
                Positioned(
                  top: 0,
                  left: 20,
                  right: 20,
                  height: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.white.withValues(alpha: 0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                LayoutBuilder(
                  builder: (context, constraints) {
                    final isCompact = constraints.maxWidth < 300;
                    final showBadges = widget.showBadge && constraints.maxWidth >= 340;
                    final showArrow = constraints.maxWidth >= 380;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icono Vectorial Oficial de Google Play
                        GooglePlayLogo(size: isCompact ? 24 : 28),
                        SizedBox(width: isCompact ? 10 : 12),

                        // Tipografía de dos líneas alineada
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.topLabel,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  fontSize: isCompact ? 8.5 : 9.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              const SizedBox(height: 1),
                              Text(
                                widget.mainLabel,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isCompact ? 16 : 18,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Outfit',
                                  letterSpacing: 0.3,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (showBadges) ...[
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.28),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.2),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified_rounded,
                                  color: Color(0xFF6EE7B7),
                                  size: 13,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Oficial',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        if (showArrow) ...[
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Logotipo vectorial geométrico oficial de Google Play con sus 4 sectores cromáticos.
class GooglePlayLogo extends StatelessWidget {
  final double size;

  const GooglePlayLogo({super.key, this.size = 28.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 0.88,
      height: size,
      child: CustomPaint(
        painter: _GooglePlayPainter(),
      ),
    );
  }
}

class _GooglePlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Coordenadas del triángulo base
    final pTopLeft = Offset(w * 0.08, h * 0.05);
    final pBottomLeft = Offset(w * 0.08, h * 0.95);
    final pRightTip = Offset(w * 0.96, h * 0.50);

    // Punto de cruce interior
    final pCross = Offset(w * 0.58, h * 0.50);

    // Puntos auxiliares de solapamiento
    final pTopCross = Offset(w * 0.72, h * 0.28);
    final pBottomCross = Offset(w * 0.72, h * 0.72);

    // 1. Sector Azul / Cyan (Superior)
    final bluePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF00C3FF), Color(0xFF0288D1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final bluePath = Path()
      ..moveTo(pTopLeft.dx, pTopLeft.dy)
      ..lineTo(pCross.dx, pCross.dy)
      ..lineTo(pTopCross.dx, pTopCross.dy)
      ..close();
    canvas.drawPath(bluePath, bluePaint);

    // 2. Sector Verde (Inferior)
    final greenPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF00E676), Color(0xFF00B0FF)],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final greenPath = Path()
      ..moveTo(pBottomLeft.dx, pBottomLeft.dy)
      ..lineTo(pBottomCross.dx, pBottomCross.dy)
      ..lineTo(pCross.dx, pCross.dy)
      ..close();
    canvas.drawPath(greenPath, greenPaint);

    // 3. Sector Amarillo (Punta derecha)
    final yellowPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFFD500), Color(0xFFFF9100)],
        begin: Alignment.topRight,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final yellowPath = Path()
      ..moveTo(pTopCross.dx, pTopCross.dy)
      ..lineTo(pCross.dx, pCross.dy)
      ..lineTo(pBottomCross.dx, pBottomCross.dy)
      ..lineTo(pRightTip.dx, pRightTip.dy)
      ..close();
    canvas.drawPath(yellowPath, yellowPaint);

    // 4. Sector Rojo / Coral (Solapamiento lateral izquierdo)
    final redPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFF334B), Color(0xFFE53935)],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final redPath = Path()
      ..moveTo(pTopLeft.dx, pTopLeft.dy)
      ..lineTo(pCross.dx, pCross.dy)
      ..lineTo(pBottomLeft.dx, pBottomLeft.dy)
      ..close();
    canvas.drawPath(redPath, redPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

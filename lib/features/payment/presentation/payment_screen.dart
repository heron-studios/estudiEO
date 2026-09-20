import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/core/config/app_config.dart';

/// Pantalla exclusiva de pago y activación para EDUPOL PRO Vitalicio.
/// Diseñada bajo los principios de Apple Design (WWDC):
/// - Materials & Depth: Superficies traslúcidas (frosted glass) y bordes hairline.
/// - Response: Interacción táctil inmediata en pointer-down (scale 0.96) y haptics.
/// - Typography: Tracking óptico negativo en titulares grandes e interlineado compacto.
/// - Apple Wallet Pass: Tarjeta de Yape con acabados de pase digital y QR de alta resolución.
/// - Inset Grouped Lists: Lista de beneficios estilo iOS Settings / Apple Store specs.
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  static const String _yapeNumber = '955285763';
  static const String _formattedNumber = '955 285 763';
  static const String _price = 'S/ 30.00';
  bool _copied = false;
  Timer? _copyTimer;

  @override
  void dispose() {
    _copyTimer?.cancel();
    super.dispose();
  }

  Future<void> _copyNumber() async {
    HapticFeedback.mediumImpact();
    await Clipboard.setData(const ClipboardData(text: _yapeNumber));
    if (!mounted) return;
    setState(() => _copied = true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Color(0xFF30D158)),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Número de Yape copiado al portapapeles (955 285 763)',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1C1C1E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.12),
            width: 0.8,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    _copyTimer?.cancel();
    _copyTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  Future<void> _sendWhatsAppMessage() async {
    HapticFeedback.mediumImpact();
    const message =
        '¡Hola! Acabo de transferir S/ 30 por Yape para mi Acceso EDUPOL PRO de por vida. Adjunto mi comprobante para que activen mi cuenta de inmediato.';
    final waNumber = AppConfig.whatsappNumber.isNotEmpty
        ? AppConfig.whatsappNumber
        : '51$_yapeNumber';
    final uri = Uri.parse(
      'https://wa.me/$waNumber?text=${Uri.encodeComponent(message)}',
    );
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se pudo abrir WhatsApp: $e'),
            backgroundColor: const Color(0xFFFF453A),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    final isDesktop = media.width >= 860;

    return Scaffold(
      backgroundColor: const Color(0xFF000000), // OLED True Black
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AppBar(
              backgroundColor: Colors.black.withValues(alpha: 0.55),
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: _ApplePressable(
                onTap: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/home');
                  }
                },
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              title: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified_rounded,
                      color: Color(0xFF30D158),
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'EDUPOL PRO • Activación',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: 'Outfit',
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0.8),
                child: Container(
                  height: 0.8,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // ── FONDO AMBIENTAL APPLE (LUCES DIFUSAS SUTILES) ──
          Positioned(
            top: -120,
            right: -100,
            child: Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF30D158).withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: -140,
            child: Container(
              width: 420,
              height: 420,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF742284).withValues(alpha: 0.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -60,
            child: Container(
              width: 340,
              height: 340,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF0A84FF).withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // ── CONTENIDO PRINCIPAL SCROLLABLE ──
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 48 : 18,
                vertical: 24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1020),
                  child: isDesktop
                      ? _buildDesktopLayout(context)
                      : _buildMobileLayout(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ── LAYOUT ESCRITORIO (2 COLUMNAS) ──
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Columna Izquierda: Hero, Precio, Beneficios Inset Grouped
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderBadge(),
              const SizedBox(height: 16),
              _buildHeadline(),
              const SizedBox(height: 18),
              _buildPriceBox(),
              const SizedBox(height: 24),
              _buildBenefitsCard(),
              const SizedBox(height: 22),
              _buildGuaranteesRow(),
            ],
          ),
        ),
        const SizedBox(width: 36),
        // Columna Derecha: Tarjeta Estilo Apple Wallet Pass para Yape & WhatsApp CTA
        Expanded(
          flex: 5,
          child: _buildYapePaymentCard(),
        ),
      ],
    );
  }

  /// ── LAYOUT MÓVIL (VERTICAL) ──
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeaderBadge(),
        const SizedBox(height: 14),
        _buildHeadline(),
        const SizedBox(height: 16),
        _buildPriceBox(),
        const SizedBox(height: 24),
        _buildYapePaymentCard(),
        const SizedBox(height: 26),
        _buildBenefitsCard(),
        const SizedBox(height: 22),
        _buildGuaranteesRow(),
        const SizedBox(height: 32),
      ],
    );
  }

  // ── COMPONENTES APPLE DESIGN ──────────────────────────────────────────────

  /// Píldora de Categoría / Status Superior
  Widget _buildHeaderBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFBF5AF2).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFBF5AF2).withValues(alpha: 0.35),
          width: 0.8,
        ),
      ),
      child: const FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.stars_rounded, color: Color(0xFFD087FA), size: 15),
            SizedBox(width: 6),
            Text(
              'PLAN VITALICIO OFICIAL • EDUPOL PRO',
              style: TextStyle(
                color: Color(0xFFD087FA),
                fontWeight: FontWeight.w700,
                fontSize: 11.5,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Titular con Tracking Óptico Negativo e Interlineado Apple
  Widget _buildHeadline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Desbloquea tu Vacante en la PNP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.w800,
            fontFamily: 'Outfit',
            letterSpacing: -0.8,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Acceso completo e ilimitado a todo el banco de preguntas oficial 2026, simulacros cronometrados, diagnóstico de radar predictivo y repaso inteligente.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.72),
            fontSize: 13.5,
            height: 1.45,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  /// Tarjeta de Precio Estilo Apple Glass
  Widget _buildPriceBox() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.14),
              width: 0.8,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.08),
                Colors.white.withValues(alpha: 0.02),
              ],
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Text(
                            'S/ 89.00',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 13,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF453A).withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              '66% DCTO',
                              style: TextStyle(
                                color: Color(0xFFFF453A),
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            _price,
                            style: TextStyle(
                              color: Color(0xFF30D158),
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Outfit',
                              letterSpacing: -1.0,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'PEN',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '⚡ Un solo pago de por vida • Sin mensualidades',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF30D158).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF30D158).withValues(alpha: 0.3),
                    width: 0.8,
                  ),
                ),
                child: const Icon(
                  Icons.all_inclusive_rounded,
                  color: Color(0xFF30D158),
                  size: 26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Tarjeta Estilo Apple Wallet Pass con QR de Yape y Acción WhatsApp
  Widget _buildYapePaymentCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.045),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.14),
              width: 0.9,
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF261033).withValues(alpha: 0.85),
                const Color(0xFF100B17).withValues(alpha: 0.95),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF742284).withValues(alpha: 0.22),
                blurRadius: 36,
                spreadRadius: 1,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.8),
                blurRadius: 24,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Encabezado tipo Pass
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF742284),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.18),
                              width: 0.8,
                            ),
                          ),
                          child: const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.qr_code_2_rounded, color: Colors.white, size: 15),
                                SizedBox(width: 5),
                                Text(
                                  'YAPE OFICIAL',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF30D158).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFF30D158).withValues(alpha: 0.3),
                              width: 0.8,
                            ),
                          ),
                          child: const Text(
                            'PAGO SEGURO',
                            style: TextStyle(
                              color: Color(0xFF30D158),
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Monto: S/ 30',
                    style: TextStyle(
                      color: Color(0xFF30D158),
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Contenedor del QR con acabado Inset de Apple
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.85),
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.35),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: const Color(0xFF742284).withValues(alpha: 0.2),
                        blurRadius: 28,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(19),
                    child: Image.asset(
                      'assets/images/yape_qr.jpg',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.broken_image_rounded, color: Colors.grey, size: 40),
                              SizedBox(height: 8),
                              Text(
                                'QR no disponible',
                                style: TextStyle(color: Colors.black54, fontSize: 11),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Micro-instrucción
              Center(
                child: Text(
                  'Escanea este código desde la app de Yape',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.65),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Cápsula interactiva para copiar el número de Yape (ApplePressable)
              _ApplePressable(
                onTap: _copyNumber,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.16),
                      width: 0.8,
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.phone_iphone_rounded,
                          color: Color(0xFF30D158),
                          size: 17,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          _formattedNumber,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(width: 14),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOutCubic,
                          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                          decoration: BoxDecoration(
                            color: _copied
                                ? const Color(0xFF30D158)
                                : const Color(0xFF742284),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _copied ? Icons.check_rounded : Icons.copy_rounded,
                                color: Colors.white,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _copied ? '¡Copiado!' : 'Copiar',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Pasos de activación al estilo Apple Guide
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                    width: 0.8,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Instrucciones de activación rápida:',
                      style: TextStyle(
                        color: Color(0xFF30D158),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildStepRow('1', 'Yapea S/ 30.00 escaneando el QR o al 955 285 763.'),
                    const SizedBox(height: 5),
                    _buildStepRow('2', 'Guarda la captura de pantalla de tu comprobante.'),
                    const SizedBox(height: 5),
                    _buildStepRow('3', 'Presiona el botón de abajo para enviárnoslo por WhatsApp y activamos tu cuenta PRO al instante.'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── BOTÓN PRINCIPAL WHATSAPP CTA (Apple Pay / App Store Style) ──
              _ApplePressable(
                onTap: _sendWhatsAppMessage,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF30D158), // Apple System Green Vibrancy
                        Color(0xFF24A845),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF30D158).withValues(alpha: 0.35),
                        blurRadius: 18,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_rounded, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Enviar mensaje para mi acceso PRO',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 14.5,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  '⚡ Respuesta inmediata por WhatsApp • Activación en minutos',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepRow(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 17,
          height: 17,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.72),
              fontSize: 11,
              height: 1.35,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  /// Lista Inset Grouped de Beneficios estilo iOS Settings / Apple Specs
  Widget _buildBenefitsCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.045),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
              width: 0.8,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '¿Qué incluye tu Acceso PRO de por vida?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.5,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Outfit',
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 16),
              _buildBenefitItem(
                Icons.menu_book_rounded,
                const Color(0xFF30D158), // Apple Green
                'Temarios Oficiales PNP 2026 Completos',
                'Acceso a todos los cursos y balotarios para Oficiales y Suboficiales.',
                showDivider: true,
              ),
              _buildBenefitItem(
                Icons.timer_rounded,
                const Color(0xFF0A84FF), // Apple Blue
                'Simulacros Oficiales Cronometrados',
                'Pruebas con tiempo real de examen y puntuación según baremo PNP.',
                showDivider: true,
              ),
              _buildBenefitItem(
                Icons.radar_rounded,
                const Color(0xFFBF5AF2), // Apple Purple
                'Radar Predictivo de Riesgo y Rendimiento',
                'Algoritmo que localiza tus fallas y temas débiles antes del examen.',
                showDivider: true,
              ),
              _buildBenefitItem(
                Icons.security_update_good_rounded,
                const Color(0xFFFF9F0A), // Apple Orange
                'Bóveda de Errores con Algoritmo SRS',
                'Repetición espaciada para memorizar las respuestas difíciles sin olvidar.',
                showDivider: true,
              ),
              _buildBenefitItem(
                Icons.wifi_off_rounded,
                const Color(0xFF64D2FF), // Apple Teal
                'Modo Offline en la App Android',
                'Estudia en tu celular sin consumir tus datos móviles ni requerir internet.',
                showDivider: true,
              ),
              _buildBenefitItem(
                Icons.support_agent_rounded,
                const Color(0xFFFF375F), // Apple Pink
                'Soporte Prioritario y Nuevas Preguntas',
                'Todas las futuras actualizaciones y balotarios agregados sin costo extra.',
                showDivider: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(
    IconData icon,
    Color color,
    String title,
    String desc, {
    required bool showDivider,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: color.withValues(alpha: 0.3),
                    width: 0.8,
                  ),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      desc,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.65),
                        fontSize: 11.5,
                        height: 1.35,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.only(left: 48, top: 4, bottom: 4),
            child: Divider(
              color: Colors.white.withValues(alpha: 0.08),
              height: 1,
              thickness: 0.7,
            ),
          ),
      ],
    );
  }

  Widget _buildGuaranteesRow() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 14,
      runSpacing: 8,
      children: [
        _buildMiniPill(Icons.verified_rounded, 'Pago 100% Seguro'),
        _buildMiniPill(Icons.lock_rounded, 'Sin cobros ocultos'),
        _buildMiniPill(Icons.all_inclusive_rounded, 'Acceso Vitalicio'),
        _buildMiniPill(Icons.phone_android_rounded, 'Para App Android'),
      ],
    );
  }

  Widget _buildMiniPill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.09),
          width: 0.7,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFF30D158)),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget modular con microinteracción táctil instantánea bajo Apple Design:
/// Reduce la escala a 0.96 en pointer-down de inmediato y vibra con respuesta háptica.
class _ApplePressable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _ApplePressable({
    required this.child,
    this.onTap,
  });

  @override
  State<_ApplePressable> createState() => _ApplePressableState();
}

class _ApplePressableState extends State<_ApplePressable> {
  bool _pressed = false;

  void _onTapDown(TapDownDetails details) {
    if (widget.onTap == null) return;
    HapticFeedback.lightImpact();
    setState(() => _pressed = true);
  }

  void _onTapUp(TapUpDetails details) {
    if (_pressed) setState(() => _pressed = false);
  }

  void _onTapCancel() {
    if (_pressed) setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}

import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/core/config/app_config.dart';

/// Pantalla compacta de pago y activación para EDUPOL PRO Vitalicio bajo Apple Design.
/// Diseño de 2 pestañas (Segmented Control) sin scroll ("Zero-Scroll"):
/// - Tab 0: Pago & QR (Precio S/ 30, QR Yape, número copiable y botón "Solicitar acceso PRO" a WhatsApp).
/// - Tab 1: Beneficios PRO (Temarios, simulacros, radar, SRS, offline, soporte, garantías).
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  static const String _yapeNumber = '955285763';
  static const String _formattedNumber = '955 285 763';
  static const String _price = 'S/ 30.00';

  int _selectedTab = 0; // 0 = Pago & QR, 1 = Beneficios PRO
  bool _copied = false;
  Timer? _copyTimer;

  @override
  void dispose() {
    _copyTimer?.cancel();
    super.dispose();
  }

  Future<void> _copyNumber() async {
    HapticFeedback.mediumImpact();
    try {
      await Clipboard.setData(const ClipboardData(text: _yapeNumber));
    } catch (_) {}
    if (!mounted) return;
    setState(() => _copied = true);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Color(0xFF30D158), size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Número de Yape copiado (955 285 763)',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.5,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1C1C1E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
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
      if (kIsWeb) {
        // En Web, lanzar inmediatamente con target _blank sin await previo para no perder la activación del usuario
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.platformDefault,
          webOnlyWindowName: '_blank',
        );
        if (!launched) {
          final fallbackUri = Uri.parse(
            'https://api.whatsapp.com/send?phone=$waNumber&text=${Uri.encodeComponent(message)}',
          );
          await launchUrl(
            fallbackUri,
            mode: LaunchMode.platformDefault,
            webOnlyWindowName: '_blank',
          );
        }
      } else {
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        if (!launched) {
          await launchUrl(uri, mode: LaunchMode.platformDefault);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se pudo abrir WhatsApp: $e. Puedes escribir directamente al $waNumber'),
            backgroundColor: const Color(0xFFFF453A),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'Copiar número',
              textColor: Colors.white,
              onPressed: _copyNumber,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000), // OLED True Black
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
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
                    size: 17,
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
                      size: 16,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'EDUPOL PRO • Activación',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        fontFamily: 'Outfit',
                        letterSpacing: -0.2,
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
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Luces ambientales tenues de fondo (Apple Ambient Glow)
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF30D158).withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF742284).withValues(alpha: 0.16),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Contenedor principal centrado perfectamente en desktop/web y móvil
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 480,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 1. Selector de Pestañas iOS Segmented Control
                          _buildSegmentedControl(),

                          const SizedBox(height: 10),

                          // 2. Contenido del Tab seleccionado
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 220),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInCubic,
                            child: _selectedTab == 0
                                ? _buildTabPayment()
                                : _buildTabBenefits(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── 1. IOS SEGMENTED CONTROL ───────────────────────────────────────────────

  Widget _buildSegmentedControl() {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 0.8,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ApplePressable(
              onTap: () {
                if (_selectedTab != 0) {
                  HapticFeedback.selectionClick();
                  setState(() => _selectedTab = 0);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _selectedTab == 0
                      ? const Color(0xFF742284)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: _selectedTab == 0
                      ? [
                          BoxShadow(
                            color: const Color(0xFF742284).withValues(alpha: 0.45),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.qr_code_2_rounded,
                        size: 15,
                        color: _selectedTab == 0 ? Colors.white : Colors.white60,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Pago & QR',
                        style: TextStyle(
                          color: _selectedTab == 0 ? Colors.white : Colors.white60,
                          fontSize: 12.5,
                          fontWeight: _selectedTab == 0 ? FontWeight.w800 : FontWeight.w500,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: _ApplePressable(
              onTap: () {
                if (_selectedTab != 1) {
                  HapticFeedback.selectionClick();
                  setState(() => _selectedTab = 1);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _selectedTab == 1
                      ? const Color(0xFF30D158)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: _selectedTab == 1
                      ? [
                          BoxShadow(
                            color: const Color(0xFF30D158).withValues(alpha: 0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.stars_rounded,
                        size: 15,
                        color: _selectedTab == 1 ? Colors.white : Colors.white60,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Beneficios PRO',
                        style: TextStyle(
                          color: _selectedTab == 1 ? Colors.white : Colors.white60,
                          fontSize: 12.5,
                          fontWeight: _selectedTab == 1 ? FontWeight.w800 : FontWeight.w500,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── 2. TAB 0: PAGO & QR (PRECIO, QR, NÚMERO Y SOLICITAR ACCESO) ───────────

  Widget _buildTabPayment() {
    return Column(
      key: const ValueKey('tab_payment'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // A. Caja de Precio Ultra Compacta
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.12),
                  width: 0.8,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Text(
                            'S/ 89.00',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF453A).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              '66% DCTO',
                              style: TextStyle(
                                color: Color(0xFFFF453A),
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            _price,
                            style: TextStyle(
                              color: Color(0xFF30D158),
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Outfit',
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'PEN',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF30D158).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF30D158).withValues(alpha: 0.3),
                        width: 0.8,
                      ),
                    ),
                    child: const Text(
                      'Un solo pago de por vida',
                      style: TextStyle(
                        color: Color(0xFF30D158),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // B. Tarjeta Apple Pass con QR de Yape y Copia de Número
        ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.045),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.12),
                  width: 0.8,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF241030).withValues(alpha: 0.8),
                    const Color(0xFF110B18).withValues(alpha: 0.95),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header de la tarjeta Yape
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF742284),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.qr_code_2_rounded, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'YAPE OFICIAL',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Monto: S/ 30',
                        style: TextStyle(
                          color: Color(0xFF30D158),
                          fontWeight: FontWeight.w800,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // QR Image Compacto (172x172 dp) interactivo
                  Tooltip(
                    message: 'Toca para copiar el número de Yape (955 285 763)',
                    child: _ApplePressable(
                      onTap: _copyNumber,
                      child: Container(
                        width: 172,
                        height: 172,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.9),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.4),
                              blurRadius: 14,
                              offset: const Offset(0, 4),
                            ),
                            BoxShadow(
                              color: const Color(0xFF742284).withValues(alpha: 0.25),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            'assets/images/yape_qr.jpg',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => const Center(
                              child: Icon(Icons.qr_code_rounded, size: 50, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Micro-instrucción
                  Text(
                    'Escanea el QR o copia el número de Yape:',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Píldora de Número Interactivo con Copiado Rápido
                  _ApplePressable(
                    onTap: _copyNumber,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.15),
                          width: 0.8,
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.phone_iphone_rounded,
                              color: Color(0xFF30D158),
                              size: 15,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              _formattedNumber,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(width: 8),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
                              decoration: BoxDecoration(
                                color: _copied
                                    ? const Color(0xFF30D158)
                                    : const Color(0xFF742284),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _copied ? Icons.check_rounded : Icons.copy_rounded,
                                    color: Colors.white,
                                    size: 11,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _copied ? '¡Copiado!' : 'Copiar',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
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
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // C. Botón Principal: Solicitar Acceso PRO (WhatsApp)
        _ApplePressable(
          onTap: _sendWhatsAppMessage,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF30D158), // Apple System Green Vibrancy
                  Color(0xFF24A845),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF30D158).withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
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
                      'Solicitar acceso PRO',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 6),

        const Center(
          child: Text(
            '⚡ Respuesta inmediata por WhatsApp • Activación en minutos',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 10.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  // ── 3. TAB 1: BENEFICIOS PRO COMPACTOS (SIN TANTA COSA) ────────────────────

  Widget _buildTabBenefits() {
    return Column(
      key: const ValueKey('tab_benefits'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Tarjeta Inset Grouped con 6 Beneficios Clave
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
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
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Outfit',
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCompactBenefitRow(
                    Icons.menu_book_rounded,
                    const Color(0xFF30D158),
                    'Temarios Oficiales PNP 2026 Completos',
                    'Cursos y balotarios Oficiales y Suboficiales.',
                  ),
                  _buildCompactBenefitRow(
                    Icons.timer_rounded,
                    const Color(0xFF0A84FF),
                    'Simulacros Oficiales Cronometrados',
                    'Tiempo real de examen y baremo PNP.',
                  ),
                  _buildCompactBenefitRow(
                    Icons.radar_rounded,
                    const Color(0xFFBF5AF2),
                    'Radar Predictivo de Riesgo',
                    'Localiza tus temas débiles antes de rendir.',
                  ),
                  _buildCompactBenefitRow(
                    Icons.security_update_good_rounded,
                    const Color(0xFFFF9F0A),
                    'Bóveda de Errores con Algoritmo SRS',
                    'Repetición espaciada para memorización sólida.',
                  ),
                  _buildCompactBenefitRow(
                    Icons.wifi_off_rounded,
                    const Color(0xFF64D2FF),
                    'Modo Offline en la App Android',
                    'Estudia sin internet ni gastar datos móviles.',
                  ),
                  _buildCompactBenefitRow(
                    Icons.support_agent_rounded,
                    const Color(0xFFFF375F),
                    'Soporte Prioritario y Nuevas Preguntas',
                    'Todas las actualizaciones futuras sin costo.',
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Píldoras de Garantías
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 6,
          children: [
            _buildMiniPill(Icons.verified_rounded, 'Pago 100% Seguro'),
            _buildMiniPill(Icons.lock_rounded, 'Sin cobros ocultos'),
            _buildMiniPill(Icons.all_inclusive_rounded, 'Acceso Vitalicio'),
            _buildMiniPill(Icons.phone_android_rounded, 'Para App Android'),
          ],
        ),

        const SizedBox(height: 12),

        // Botón para ir al pago directo
        _ApplePressable(
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() => _selectedTab = 0);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 13),
            decoration: BoxDecoration(
              color: const Color(0xFF742284),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF742284).withValues(alpha: 0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code_2_rounded, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text(
                  'Ver QR de Pago (S/ 30.00)',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactBenefitRow(
    IconData icon,
    Color color,
    String title,
    String desc, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: color.withValues(alpha: 0.3),
                    width: 0.8,
                  ),
                ),
                child: Icon(icon, color: color, size: 15),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        letterSpacing: -0.2,
                      ),
                    ),
                    Text(
                      desc,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 10.5,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.only(left: 38),
            child: Divider(
              color: Colors.white.withValues(alpha: 0.06),
              height: 1,
              thickness: 0.6,
            ),
          ),
      ],
    );
  }

  Widget _buildMiniPill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 0.7,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: const Color(0xFF30D158)),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 10,
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
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
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
      ),
    );
  }
}

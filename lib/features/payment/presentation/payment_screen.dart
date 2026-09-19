import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/core/config/app_config.dart';

/// Pantalla exclusiva de pago para la activación de EDUPOL PRO Vitalicio.
/// No es visible en los menús de navegación de la web; se accede únicamente mediante enlace directo.
/// Diseñada para la versión Android y Web con QR de Yape, copia de número y confirmación por WhatsApp.
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
    await Clipboard.setData(const ClipboardData(text: _yapeNumber));
    if (!mounted) return;
    setState(() => _copied = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Color(0xFF10B981)),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Número de Yape copiado al portapapeles (955 285 763)',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1E293B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
    _copyTimer?.cancel();
    _copyTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  Future<void> _sendWhatsAppMessage() async {
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
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    final isDesktop = media.width >= 820;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white70, size: 20),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
          tooltip: 'Regresar',
        ),
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_user_rounded, color: Color(0xFF34D399), size: 18),
              SizedBox(width: 8),
              Text(
                'EDUPOL PRO • Activación',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  fontFamily: 'Outfit',
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 40 : 18,
            vertical: 24,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: isDesktop
                  ? _buildDesktopLayout(context)
                  : _buildMobileLayout(context),
            ),
          ),
        ),
      ),
    );
  }

  /// ── LAYOUT ESCRITORIO (2 COLUMNAS) ──
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Columna Izquierda: Beneficios, propuesta de valor y precio
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
              const SizedBox(height: 20),
              _buildGuaranteesRow(),
            ],
          ),
        ),
        const SizedBox(width: 32),
        // Columna Derecha: Tarjeta de Pago con QR de Yape y Botón WhatsApp
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
        const SizedBox(height: 22),
        _buildYapePaymentCard(),
        const SizedBox(height: 24),
        _buildBenefitsCard(),
        const SizedBox(height: 20),
        _buildGuaranteesRow(),
        const SizedBox(height: 30),
      ],
    );
  }

  // ── COMPONENTES MODULARES ────────────────────────────────────────────────

  Widget _buildHeaderBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF8B5CF6).withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF8B5CF6).withValues(alpha: 0.45),
          width: 1,
        ),
      ),
      child: const FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.stars_rounded, color: Color(0xFFA78BFA), size: 16),
            SizedBox(width: 6),
            Text(
              'PLAN VITALICIO OFICIAL • EDUPOL PRO',
              style: TextStyle(
                color: Color(0xFFA78BFA),
                fontWeight: FontWeight.w800,
                fontSize: 11.5,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Desbloquea tu Vacante en la PNP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w900,
            fontFamily: 'Outfit',
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Acceso completo e ilimitado a todo el banco de preguntas oficial 2026, simulacros cronometrados, diagnóstico de radar predictivo y repaso inteligente.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
            fontSize: 13.5,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceBox() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1E293B),
            const Color(0xFF0F172A).withValues(alpha: 0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
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
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          '66% DCTO',
                          style: TextStyle(
                            color: Color(0xFFF87171),
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
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
                          color: Color(0xFF34D399),
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Outfit',
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'PEN',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
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
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.all_inclusive_rounded,
              color: Color(0xFF10B981),
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  /// ── TARJETA YAPE CON QR Y BOTÓN DE WHATSAPP ──
  Widget _buildYapePaymentCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF241235), // Tono morado Yape oscuro
            Color(0xFF161026),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: const Color(0xFF742284).withValues(alpha: 0.6),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF742284).withValues(alpha: 0.25),
            blurRadius: 30,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Encabezado Yape
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF742284),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.qr_code_2_rounded, color: Colors.white, size: 16),
                            SizedBox(width: 6),
                            Text(
                              'YAPE OFICIAL',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00D1A0).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'PAGO SEGURO',
                        style: TextStyle(
                          color: Color(0xFF00D1A0),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
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
                  color: Color(0xFF00D1A0),
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Contenedor del QR
          Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/yape_qr.jpg',
                  width: 230,
                  height: 230,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 230,
                    height: 230,
                    color: const Color(0xFF1E293B),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code_scanner_rounded, color: Colors.white54, size: 50),
                          SizedBox(height: 8),
                          Text(
                            'QR Yape 955 285 763',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Escanea el QR desde tu App Yape',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'O realiza la transferencia directa al número:',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white60,
              fontSize: 11.5,
            ),
          ),

          const SizedBox(height: 10),

          // Caja para copiar el número de Yape
          InkWell(
            onTap: _copyNumber,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.phone_iphone_rounded, color: Color(0xFF00D1A0), size: 18),
                    const SizedBox(width: 8),
                    const Text(
                      _formattedNumber,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _copied
                            ? const Color(0xFF10B981)
                            : const Color(0xFF742284),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _copied ? Icons.check_rounded : Icons.copy_rounded,
                            color: Colors.white,
                            size: 13,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _copied ? '¡Copiado!' : 'Copiar',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
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

          const SizedBox(height: 20),

          // Separador de pasos
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0B111E),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.07),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Instrucciones de activación rápida:',
                  style: TextStyle(
                    color: Color(0xFF00D1A0),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '1. Yapea S/ 30.00 escaneando el QR o al 955 285 763.\n2. Guarda la captura de tu comprobante.\n3. Presiona el botón verde de abajo para enviárnoslo por WhatsApp y activamos tu cuenta PRO al instante.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // ── BOTÓN PRINCIPAL WHATSAPP (Enviar mensaje para mi acceso PRO) ──
          FilledButton.icon(
            onPressed: _sendWhatsAppMessage,
            icon: const Icon(Icons.chat_bubble_rounded, size: 22),
            label: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Enviar mensaje para mi acceso PRO',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF25D366),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              shadowColor: const Color(0xFF25D366).withValues(alpha: 0.5),
            ),
          ),

          const SizedBox(height: 10),

          const Center(
            child: Text(
              '⚡ Respuesta inmediata por WhatsApp • Activación en minutos',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '¿Qué incluye tu Acceso PRO de por vida?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              fontFamily: 'Outfit',
            ),
          ),
          const SizedBox(height: 14),
          _buildBenefitItem(
            Icons.menu_book_rounded,
            const Color(0xFF10B981),
            'Temarios Oficiales PNP 2026 Completos',
            'Acceso a todos los cursos y balotarios para Oficiales y Suboficiales.',
          ),
          const SizedBox(height: 10),
          _buildBenefitItem(
            Icons.timer_rounded,
            const Color(0xFF38BDF8),
            'Simulacros Oficiales Cronometrados',
            'Pruebas con tiempo real de examen y puntuación según baremo PNP.',
          ),
          const SizedBox(height: 10),
          _buildBenefitItem(
            Icons.radar_rounded,
            const Color(0xFFA78BFA),
            'Radar Predictivo de Riesgo y Rendimiento',
            'Algoritmo que localiza tus fallas y temas débiles antes del examen.',
          ),
          const SizedBox(height: 10),
          _buildBenefitItem(
            Icons.security_update_good_rounded,
            const Color(0xFFF59E0B),
            'Bóveda de Errores con Algoritmo SRS',
            'Repetición espaciada para memorizar las respuestas difíciles sin olvidar.',
          ),
          const SizedBox(height: 10),
          _buildBenefitItem(
            Icons.wifi_off_rounded,
            const Color(0xFF10B981),
            'Modo Offline en la App Android',
            'Estudia en tu celular sin consumir tus datos móviles ni requerir internet.',
          ),
          const SizedBox(height: 10),
          _buildBenefitItem(
            Icons.support_agent_rounded,
            const Color(0xFF06B6D4),
            'Soporte Prioritario y Nuevas Preguntas',
            'Todas las futuras actualizaciones y balotarios agregados sin costo extra.',
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(
    IconData icon,
    Color color,
    String title,
    String desc,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 12),
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
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.65),
                  fontSize: 11.5,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGuaranteesRow() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 10,
      children: [
        _buildMiniPill(Icons.verified_rounded, 'Pago 100% Seguro'),
        _buildMiniPill(Icons.lock_rounded, 'Sin cobros ocultos'),
        _buildMiniPill(Icons.all_inclusive_rounded, 'Acceso Vitalicio'),
        _buildMiniPill(Icons.phone_android_rounded, 'Para App Android'),
      ],
    );
  }

  Widget _buildMiniPill(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: const Color(0xFF10B981)),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

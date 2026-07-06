import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/app_config.dart';
import 'package:learn/features/auth/domain/auth_service.dart';

// ─── Beneficios del plan ──────────────────────────────────────────────────────
const _benefits = [
  _Benefit(Icons.all_inclusive_rounded,     Color(0xFF3B82F6), 'Acceso permanente a la app',         'Una vez, para siempre. Sin renovaciones.'),
  _Benefit(Icons.quiz_rounded,              Color(0xFF8B5CF6), 'Simulacro Tipo Examen de Admisión',  'Con preguntas reales de exámenes de procesos pasados.'),
  _Benefit(Icons.psychology_rounded,        Color(0xFFF59E0B), 'Misión Diaria de Aprendizaje',       'Sistema inteligente para repasar temas frecuentes.'),
  _Benefit(Icons.health_and_safety_rounded, Color(0xFF10B981), 'Examen Médico y Psicológico',        'Pruebas Eysenck, Sacks y test de personalidad.'),
  _Benefit(Icons.record_voice_over_rounded, Color(0xFFEF4444), 'Simulador de Entrevista Personal',   'Practica el balotario oral bajo presión.'),
  _Benefit(Icons.extension_rounded,         Color(0xFF06B6D4), 'Minijuegos de Agilidad Mental',      'ANP Master, Silogismos y Tabla Periódica interactiva.'),
  _Benefit(Icons.support_agent_rounded,     Color(0xFFFFD700), 'Soporte VIP y Actualizaciones',      'Grupo exclusivo y nuevas preguntas sin costo adicional.'),
];

class _Benefit {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  const _Benefit(this.icon, this.color, this.title, this.subtitle);
}

// ─── Pantalla principal ───────────────────────────────────────────────────────

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pulseCtrl;
  late final AnimationController _floatCtrl;
  late final AnimationController _entranceCtrl;
  late final AnimationController _bgCtrl;

  late final Animation<double> _pulseAnim;
  late final Animation<double> _floatAnim;
  late final Animation<double> _entranceAnim;

  bool _isPressing = false;

  @override
  void initState() {
    super.initState();

    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _floatCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
    _entranceCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))
      ..forward();
    _bgCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 8));
    if (kIsWeb) {
      _bgCtrl.repeat();
    }

    _pulseAnim = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
    _floatAnim = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );
    _entranceAnim = CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOutBack);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _floatCtrl.dispose();
    _entranceCtrl.dispose();
    _bgCtrl.dispose();
    super.dispose();
  }

  Future<void> _launchWhatsApp() async {
    const text = 'Hola! estoy interesado en adquirir la aplicacion con el descuento Cyber Wow de 15 soles, mas informacion por favor';
    final uri = Uri.parse(
      'https://wa.me/${AppConfig.whatsappNumber}?text=${Uri.encodeComponent(text)}',
    );
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo abrir WhatsApp: $e'), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 900; // Breakpoint optimizado

    return Scaffold(
      backgroundColor: const Color(0xFF060B18),
      body: Stack(
        children: [
          // Fondo animado
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _bgCtrl,
              builder: (_, __) => CustomPaint(
                painter: _BgPainter(_bgCtrl.value),
              ),
            ),
          ),

          // Volver / Atrás
          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white70),
                onPressed: () {
                  context.go('/home');
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.05),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ),
          ),

          // Contenido
          SafeArea(
            child: isWide
                ? _buildWideLayout()
                : _buildNarrowLayout(),
          ),

          // Cerrar sesión
          Positioned(
            top: 16,
            right: 16,
            child: SafeArea(
              child: TextButton.icon(
                onPressed: () async {
                  final authService = context.read<AuthService>();
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: const Color(0xFF1E293B),
                      title: const Text('¿Cerrar Sesión?', style: TextStyle(color: Colors.white)),
                      content: const Text(
                        '¿Estás seguro de que deseas salir y volver al inicio de sesión?',
                        style: TextStyle(color: Color(0xFF94A3B8)),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: const Text('Cancelar', style: TextStyle(color: Colors.white70)),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444)),
                          child: const Text('Salir', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await authService.signOut();
                  }
                },
                icon: const Icon(Icons.logout_rounded, color: Colors.white70, size: 16),
                label: const Text(
                  'Cerrar Sesión',
                  style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.05),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Layout ancho: web / escritorio ──────────────────────────────────────────
  Widget _buildWideLayout() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Columna izquierda: Badge, Título, Descripción y Lista de Beneficios
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopBadge(),
                      const SizedBox(height: 24),
                      _buildTitleLeft(),
                      const SizedBox(height: 40),
                      const Text(
                        'Beneficios exclusivos incluidos:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildBenefitsList(),
                    ],
                  ),
                ),
                const SizedBox(width: 50),
                // Columna derecha: Tarjeta de compra unificada
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      const SizedBox(height: 40), // Alínea verticalmente con el título de la izquierda
                      ScaleTransition(
                        scale: _entranceAnim,
                        child: _buildUnifiedCheckoutCard(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Layout estrecho: móvil ──────────────────────────────────────────────────
  Widget _buildNarrowLayout() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            _buildTopBadge(),
            const SizedBox(height: 20),
            _buildFloatingIcon(),
            const SizedBox(height: 24),
            _buildTitleCenter(),
            const SizedBox(height: 32),
            ScaleTransition(
              scale: _entranceAnim,
              child: _buildUnifiedCheckoutCard(),
            ),
            const SizedBox(height: 36),
            const Text(
              '¿Qué incluye tu acceso permanente?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildBenefitsList(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ── Componentes de la UI ─────────────────────────────────────────────────────

  Widget _buildTopBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFD700).withValues(alpha: 0.15),
            const Color(0xFFFFA500).withValues(alpha: 0.25),
            const Color(0xFFFFD700).withValues(alpha: 0.15),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        border: Border.all(color: const Color(0xFFFFD700).withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department_rounded, color: Color(0xFFFFD700), size: 16),
          const SizedBox(width: 6),
          Text(
            'OFERTA ESPECIAL · ACCESO PERMANENTE',
            style: TextStyle(
              color: const Color(0xFFFFD700).withValues(alpha: 0.9),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingIcon() {
    return AnimatedBuilder(
      animation: _floatAnim,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _floatAnim.value),
        child: child,
      ),
      child: AnimatedBuilder(
        animation: _pulseAnim,
        builder: (_, child) => Transform.scale(scale: _pulseAnim.value, child: child),
        child: Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [Color(0xFF4F9EFF), Color(0xFF1E40AF)],
              center: Alignment(-0.3, -0.3),
            ),
            boxShadow: [
              BoxShadow(color: const Color(0xFF3B82F6).withValues(alpha: 0.6), blurRadius: 40, spreadRadius: 10),
              BoxShadow(color: const Color(0xFF7C3AED).withValues(alpha: 0.4), blurRadius: 60, spreadRadius: 5),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
              const Icon(Icons.military_tech_rounded, color: Colors.white, size: 52),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleLeft() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (b) => const LinearGradient(
                  colors: [Color(0xFF60A5FA), Color(0xFFA78BFA), Color(0xFFF472B6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(b),
                child: const Text(
                  'Tu vacante a la PNP\ncomienza aquí',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.15,
                    letterSpacing: -1.0,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Miles de postulantes a oficiales y suboficiales ya se preparan y aprueban con EDUPOL. Obtén acceso de por vida a la plataforma y asegura tu futuro en la policía.',
                style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.65), height: 1.6),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        _buildFloatingIcon(),
      ],
    );
  }

  Widget _buildTitleCenter() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [Color(0xFF60A5FA), Color(0xFFA78BFA), Color(0xFFF472B6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(b),
          child: const Text(
            'Tu vacante a la PNP\ncomienza aquí',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.15,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Miles de alumnos y cadetes ya aprobaron con EDUPOL.\nSé el próximo.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.white.withValues(alpha: 0.6), height: 1.6),
        ),
      ],
    );
  }

  Widget _buildBenefitsList() {
    return Column(
      children: _benefits.map((b) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 2),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: b.color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(color: b.color.withValues(alpha: 0.3)),
              ),
              child: Icon(b.icon, color: b.color, size: 16),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(b.title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(b.subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12.5, height: 1.35)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 4, left: 8),
              child: Icon(Icons.check_circle_rounded, color: Color(0xFF22C55E), size: 18),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildUnifiedCheckoutCard() {
    final checkoutContent = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cabecera del Plan
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF7C3AED)]),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PLAN COMPLETO', style: TextStyle(color: Color(0xFF93C5FD), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
                  Text('Acceso Permanente', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF22C55E).withValues(alpha: 0.5)),
                ),
                child: const Text('ÚNICO PAGO', style: TextStyle(color: Color(0xFF4ADE80), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.8)),
              ),
            ],
          ),

          const SizedBox(height: 24),
          const Divider(color: Color(0xFF1E3A5F), thickness: 1.5),
          const SizedBox(height: 20),

          // Precio
          _buildPriceSection(),

          const SizedBox(height: 30),

          // Botón de WhatsApp
          _buildBuyButton(),

          const SizedBox(height: 16),

          _buildSecondaryButton(
            icon: Icons.refresh_rounded,
            label: '¿Ya pagaste? Verificar Acceso',
            subtitle: 'Comprobar si tu cuenta ya fue activada en Firestore',
            gradient: const [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
            onTap: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Row(
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      ),
                      SizedBox(width: 12),
                      Text('Verificando acceso...'),
                    ],
                  ),
                  duration: Duration(seconds: 1),
                ),
              );

              final authService = context.read<AuthService>();
              final hasAccess = await authService.checkAndSetAuthorization();

              if (mounted) {
                if (hasAccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('¡Acceso verificado con éxito! Redirigiendo...'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  final lastErr = authService.lastVerificationError;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Acceso aún no activo. Si ya pagaste, por favor escribe a soporte.'
                        '${lastErr != null ? '\n\nDetalle técnico:\n$lastErr' : ''}'
                      ),
                      backgroundColor: Colors.orange,
                      duration: const Duration(seconds: 10),
                      action: SnackBarAction(
                        label: 'Copiar',
                        textColor: Colors.white,
                        onPressed: () {
                          // Copiar al portapapeles si es posible
                          try {
                            Clipboard.setData(ClipboardData(text: lastErr ?? 'Sin detalles'));
                          } catch (_) {}
                        },
                      ),
                    ),
                  );
                }
              }
            },
          ),

          const SizedBox(height: 12),

          _buildSecondaryButton(
            icon: Icons.groups_rounded,
            label: 'Comunidad de WhatsApp',
            subtitle: 'Únete para recibir novedades gratis',
            gradient: const [Color(0xFF25D366), Color(0xFF075E54)],
            onTap: () => _launchUrl('https://whatsapp.com/channel/0029Vb8DGVV7YSd7ld4WjX05'),
          ),

          const SizedBox(height: 12),

          _buildSecondaryButton(
            icon: Icons.download_for_offline_rounded,
            label: 'Descargar App (Android / PC)',
            subtitle: 'Consigue la versión para celular y computadora',
            gradient: const [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
            onTap: () => _launchUrl('https://drive.google.com/drive/folders/1HOvLB-RUYYPUABrrNRbjrrVFcEs-6ooE?usp=sharing'),
          ),

          const SizedBox(height: 24),
          const Divider(color: Color(0xFF1E3A5F), thickness: 1.5),
          const SizedBox(height: 20),

          // Badges de Confianza (Seguro, Activación rápida, Yape/Plin)
          _buildTrustBadges(),

          const SizedBox(height: 24),

          // Textos de Seguridad y Garantía
          _buildSecurityText(),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E3A5F), Color(0xFF0F1F3D), Color(0xFF1A1040)],
        ),
        border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.5), width: 1.5),
        boxShadow: [
          BoxShadow(color: const Color(0xFF3B82F6).withValues(alpha: 0.2), blurRadius: 35, spreadRadius: 5, offset: const Offset(0, 10)),
          BoxShadow(color: const Color(0xFF7C3AED).withValues(alpha: 0.15), blurRadius: 45, offset: const Offset(0, -5)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: kIsWeb
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: checkoutContent,
              )
            : checkoutContent,
      ),
    );
  }

  Widget _buildPriceSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('S/', style: TextStyle(color: Color(0xFF60A5FA), fontSize: 22, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(width: 4),
            ShaderMask(
              shaderCallback: (b) => const LinearGradient(
                colors: [Color(0xFF60A5FA), Color(0xFFA78BFA)],
              ).createShader(b),
              child: const Text('15', style: TextStyle(color: Colors.white, fontSize: 80, fontWeight: FontWeight.w900, height: 1, letterSpacing: -4)),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('.00', style: TextStyle(color: Color(0xFF60A5FA), fontSize: 22, fontWeight: FontWeight.w700)),
                  Text('soles', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.5)),
            ),
            child: const Text(
              '🔥 Descuento Cyber Wow 50%: de 30 soles a 15 soles todo el mes de julio',
              style: TextStyle(color: Color(0xFFEF4444), fontSize: 13, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Center(
          child: Text(
            'Pago único · Sin mensualidades · Sin sorpresas',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildTrustBadges() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const _TrustItem(icon: Icons.verified_user_rounded,  label: '100%\nSeguro',             color: Color(0xFF22C55E)),
        Container(height: 40, width: 1, color: Colors.white.withValues(alpha: 0.1)),
        const _TrustItem(icon: Icons.flash_on_rounded,       label: 'Activación\nInmediata',     color: Color(0xFF3B82F6)),
        Container(height: 40, width: 1, color: Colors.white.withValues(alpha: 0.1)),
        const _TrustItem(icon: Icons.phone_android_rounded,  label: 'Yape /\nPlin',              color: Color(0xFF8B5CF6)),
      ],
    );
  }

  Widget _buildBuyButton() {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressing = true),
      onTapUp: (_) { setState(() => _isPressing = false); _launchWhatsApp(); },
      onTapCancel: () => setState(() => _isPressing = false),
      child: AnimatedScale(
        scale: _isPressing ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: AnimatedBuilder(
          animation: _pulseAnim,
          builder: (_, child) => Container(
            width: double.infinity,
            height: 62,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF25D366), Color(0xFF1DAA54)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF25D366).withValues(alpha: 0.5 * _pulseAnim.value),
                  blurRadius: 25 * _pulseAnim.value,
                  spreadRadius: 2,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: child,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.message_rounded, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('COMPRAR AHORA · S/15',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                  Text('Contactar por WhatsApp',
                      style: TextStyle(color: Colors.white70, fontSize: 11)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityText() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline_rounded, color: Colors.white.withValues(alpha: 0.3), size: 14),
            const SizedBox(width: 6),
            Text('Pago 100% seguro por Yape o Plin',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12)),
          ],
        ),
        const SizedBox(height: 6),
        Text('Tu acceso se activa en menos de 1 hora',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 11)),
      ],
    );
  }

  Future<void> _launchUrl(String urlStr) async {
    final Uri url = Uri.parse(urlStr);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo abrir el enlace: $e'), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  Widget _buildSecondaryButton({
    required IconData icon,
    required String label,
    required String subtitle,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withValues(alpha: 0.03),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradient),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.white.withValues(alpha: 0.3), size: 14),
          ],
        ),
      ),
    );
  }
}

// ─── Badge de confianza ───────────────────────────────────────────────────────

class _TrustItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _TrustItem({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 6),
        Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11, fontWeight: FontWeight.w600, height: 1.3)),
      ],
    );
  }
}

// ─── Fondo animado ────────────────────────────────────────────────────────────

class _BgPainter extends CustomPainter {
  final double t;
  const _BgPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    // Fondo base
    final bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF060B18), Color(0xFF0A1628), Color(0xFF080E1E)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);

    // Orbes de luz
    _drawOrb(canvas, size, 0.15, 0.2, 0.0, const Color(0xFF3B82F6));
    _drawOrb(canvas, size, 0.85, 0.6, 0.3, const Color(0xFF7C3AED));
    _drawOrb(canvas, size, 0.5,  0.9, 0.6, const Color(0xFF06B6D4));

    // Grid sutil
    final grid = Paint()..color = Colors.white.withValues(alpha: 0.025)..strokeWidth = 0.5;
    const step = 50.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  void _drawOrb(Canvas canvas, Size size, double nx, double ny, double phase, Color color) {
    final pulse = math.sin((t + phase) * 2 * math.pi) * 0.5 + 0.5;
    final radius = (size.shortestSide * 0.55) * (0.85 + pulse * 0.15);
    final opacity = 0.04 + pulse * 0.04;

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color.withValues(alpha: opacity), color.withValues(alpha: 0)],
      ).createShader(Rect.fromCircle(center: Offset(nx * size.width, ny * size.height), radius: radius));
    
    if (kIsWeb) {
      paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);
    }

    canvas.drawCircle(Offset(nx * size.width, ny * size.height), radius, paint);
  }

  @override
  bool shouldRepaint(_BgPainter old) => old.t != t;
}

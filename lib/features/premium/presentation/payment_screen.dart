import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/app_config.dart';
import 'package:learn/features/auth/domain/auth_service.dart';

// ─── Constantes de datos ──────────────────────────────────────────────────────

const _benefits = [
  _Benefit(
    Icons.quiz_rounded,
    Color(0xFF8B5CF6),
    'Simulacros de Examen de Admisión',
    'Cientos de preguntas reales de procesos EO PNP y EETSPN anteriores. Practica ilimitado.',
    '+400 preguntas verificadas',
  ),
  _Benefit(
    Icons.psychology_alt_rounded,
    Color(0xFFF59E0B),
    'Tutor IA "ARIA" (Inteligencia Artificial)',
    'Tu cerebro digital que analiza tus debilidades y te dice exactamente qué temas dominar.',
    'Análisis en tiempo real',
  ),
  _Benefit(
    Icons.sports_mma_rounded,
    Color(0xFFEF4444),
    'Arena Policial (PvP 1 vs 1)',
    'Combate en vivo contra otros postulantes de todo el Perú. Gana XP y domina el Leaderboard.',
    'Multijugador en tiempo real',
  ),
  _Benefit(
    Icons.health_and_safety_rounded,
    Color(0xFF10B981),
    'Área Médica y Psicométrica',
    'Simuladores del Test de Eysenck, Sacks y Trail Making Test (TMT). Los mismos que toma la PNP.',
    'Evaluación psicológica oficial',
  ),
  _Benefit(
    Icons.record_voice_over_rounded,
    Color(0xFF3B82F6),
    'Simulador Táctico de Entrevista',
    'Preguntas bajo presión con cuenta regresiva. Aprende el lenguaje táctico que el jurado quiere escuchar.',
    'IA + Modo Realismo',
  ),
  _Benefit(
    Icons.directions_run_rounded,
    Color(0xFF06B6D4),
    'Calculadora de Aptitud Física Oficial',
    'Ingresa tus barras, planchas y tiempo de carrera. Obtén tu nota exacta del Anexo 05 y 06.',
    'Basada en tablas oficiales PNP',
  ),
  _Benefit(
    Icons.leaderboard_rounded,
    Color(0xFFFFD700),
    'Cuadro de Mérito Ponderado',
    'Simula tu nota final promediando físico, conocimientos, entrevista y psicométrico. Sabe si ya pasaste.',
    'Predictor de vacante real',
  ),
  _Benefit(
    Icons.extension_rounded,
    Color(0xFFEC4899),
    'Mini-Apps y Herramientas Interactivas',
    'ANP Master, Silogismos, Productos Notables, Tabla Periódica y Taller de Redacción Policial.',
    '10+ herramientas incluidas',
  ),
  _Benefit(
    Icons.support_agent_rounded,
    Color(0xFFA78BFA),
    'Soporte VIP y Actualizaciones Eternas',
    'Grupo exclusivo de WhatsApp para cadetes + nuevas preguntas y mejoras sin costo adicional nunca.',
    'Para siempre, sin mensualidades',
  ),
];

const _faqs = [
  _FAQ(
    '¿Cuánto tiempo tengo acceso?',
    'Acceso de por vida. Pagas una sola vez y EDUPOL es tuyo para siempre, incluyendo todas las actualizaciones futuras.',
  ),
  _FAQ(
    '¿Sirve para EO PNP y EETSPN?',
    'Sí. El contenido está actualizado y cubre ambas escuelas: Escuela de Oficiales (EO PNP) y Escuela de Técnicos y Suboficiales (EETSPN).',
  ),
  _FAQ(
    '¿Cómo pago y cuándo activo?',
    'Paga por Yape o Plin al número de WhatsApp. Envías el voucher y en menos de 1 hora tienes acceso completo activado.',
  ),
  _FAQ(
    '¿Funciona sin internet?',
    'El núcleo de quizzes y estudio funciona offline. La Arena y el Leaderboard requieren conexión a internet.',
  ),
  _FAQ(
    '¿El precio sube después de julio?',
    'Sí. El precio regular de EDUPOL es S/60. Por lanzamiento lo estamos ofreciendo al 50% de descuento: S/30 pago único, acceso de por vida.',
  ),
];

const _competitorComparison = [
  _CompareRow('Costo mensual', 'S/0 (único pago)', 'S/80-200/mes'),
  _CompareRow('Simulador físico oficial', '✓ Anexo 05 y 06', '✗ No existe'),
  _CompareRow(
    'Tests psicométricos reales',
    '✓ Eysenck, Sacks, TMT',
    '✗ Solo teoría',
  ),
  _CompareRow('Competencia multijugador', '✓ Arena 1v1 en vivo', '✗ No existe'),
  _CompareRow(
    'Tutor con Inteligencia Artificial',
    '✓ ARIA 24/7',
    '✗ No existe',
  ),
  _CompareRow(
    'Simulador de entrevista con IA',
    '✓ Modo realismo',
    '✗ No existe',
  ),
  _CompareRow(
    'Disponible 24/7',
    '✓ En tu celular',
    '✗ Solo horario de academia',
  ),
];

class _Benefit {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String tag;
  const _Benefit(this.icon, this.color, this.title, this.subtitle, this.tag);
}

class _FAQ {
  final String question;
  final String answer;
  const _FAQ(this.question, this.answer);
}

class _CompareRow {
  final String feature;
  final String edupol;
  final String competitor;
  const _CompareRow(this.feature, this.edupol, this.competitor);
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
  int _expandedFaq = -1;

  @override
  void initState() {
    super.initState();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );

    if (kIsWeb) {
      _bgCtrl.repeat();
    }

    _pulseAnim = Tween<double>(
      begin: 0.97,
      end: 1.03,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
    _floatAnim = Tween<double>(
      begin: -6.0,
      end: 6.0,
    ).animate(CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));
    _entranceAnim = CurvedAnimation(
      parent: _entranceCtrl,
      curve: Curves.easeOutBack,
    );
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
    const text =
        'Hola! quiero adquirir EDUPOL por S/30. ¿Me confirman el Yape/Plin para hacer el pago y activar mi acceso completo?';
    final uri = Uri.parse(
      'https://wa.me/${AppConfig.whatsappNumber}?text=${Uri.encodeComponent(text)}',
    );
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se pudo abrir WhatsApp: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Future<void> _launchUrl(String urlStr) async {
    final Uri url = Uri.parse(urlStr);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se pudo abrir el enlace: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 900;

    return Scaffold(
      backgroundColor: const Color(0xFF060B18),
      body: Stack(
        children: [
          // Fondo animado
          Positioned.fill(
            child: RepaintBoundary(
              child: AnimatedBuilder(
                animation: _bgCtrl,
                builder: (_, __) =>
                    CustomPaint(painter: _BgPainter(_bgCtrl.value)),
              ),
            ),
          ),

          // Contenido principal
          SafeArea(child: isWide ? _buildWideLayout() : _buildNarrowLayout()),

          // Botón Cerrar Sesión
          Positioned(
            top: 16,
            right: 16,
            child: SafeArea(child: _buildLogoutButton()),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return TextButton.icon(
      onPressed: () async {
        final authService = context.read<AuthService>();
        final confirm = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: const Color(0xFF1E293B),
            title: const Text(
              '¿Cerrar Sesión?',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              '¿Estás seguro de que deseas salir?',
              style: TextStyle(color: Color(0xFF94A3B8)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444),
                ),
                child: const Text(
                  'Salir',
                  style: TextStyle(color: Colors.white),
                ),
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
        style: TextStyle(
          color: Colors.white70,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
    );
  }

  // ── Layout ancho ─────────────────────────────────────────────────────────────
  Widget _buildWideLayout() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 30),
            child: Column(
              children: [
                // Hero section: 2 columnas
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopBadge(),
                          const SizedBox(height: 12),
                          _buildTitleLeft(),
                          const SizedBox(height: 20),
                          _buildSocialProofBar(),
                          const SizedBox(height: 28),
                          const Text(
                            '¿QUÉ INCLUYE TU ACCESO PERMANENTE?',
                            style: TextStyle(
                              color: Color(0xFF93C5FD),
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 14),
                          _buildBenefitsList(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          const SizedBox(height: 64),
                          ScaleTransition(
                            scale: _entranceAnim,
                            child: _buildUnifiedCheckoutCard(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 56),
                _buildComparisonSection(),
                _buildFaqSection(),
                const SizedBox(height: 56),
                _buildFinalCTABanner(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Layout estrecho ───────────────────────────────────────────────────────────
  Widget _buildNarrowLayout() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            _buildTopBadge(),
            const SizedBox(height: 16),
            _buildFloatingIcon(),
            const SizedBox(height: 20),
            _buildTitleCenter(),
            const SizedBox(height: 16),
            _buildSocialProofBar(),
            const SizedBox(height: 28),
            ScaleTransition(
              scale: _entranceAnim,
              child: _buildUnifiedCheckoutCard(),
            ),
            const SizedBox(height: 40),
            _buildSectionHeader('TODO LO QUE INCLUYE TU ACCESO'),
            const SizedBox(height: 16),
            _buildBenefitsList(),
            const SizedBox(height: 40),
            _buildComparisonSection(),
            _buildFaqSection(),
            const SizedBox(height: 40),
            _buildFinalCTABanner(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ── Social Proof Bar ──────────────────────────────────────────────────────────
  Widget _buildSocialProofBar() {
    return Row(
      children: [
        // Avatares apilados
        Builder(
          builder: (context) {
            final avatarColors = [
              const Color(0xFF3B82F6),
              const Color(0xFF10B981),
              const Color(0xFFEF4444),
              const Color(0xFF8B5CF6),
            ];
            return SizedBox(
              width: 76,
              height: 32,
              child: Stack(
                children: List.generate(
                  4,
                  (i) => Positioned(
                    left: i * 18.0,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF060B18),
                          width: 2,
                        ),
                        color: avatarColors[i],
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        color: Colors.white70,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 10),
        Flexible(
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: '+5,000 postulantes ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                TextSpan(
                  text: 'ya entrenan con EDUPOL',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Row(
          children: List.generate(
            5,
            (_) => const Icon(
              Icons.star_rounded,
              color: Color(0xFFFFD700),
              size: 14,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '4.9',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ── Top Badge ─────────────────────────────────────────────────────────────────
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
        ),
        border: Border.all(
          color: const Color(0xFFFFD700).withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.local_fire_department_rounded,
            color: Color(0xFFFFD700),
            size: 16,
          ),
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
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _floatAnim,
        builder: (_, child) => Transform.translate(
          offset: Offset(0, _floatAnim.value),
          child: child,
        ),
        child: AnimatedBuilder(
          animation: _pulseAnim,
          builder: (_, child) =>
              Transform.scale(scale: _pulseAnim.value, child: child),
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
                BoxShadow(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.6),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: const Icon(
              Icons.military_tech_rounded,
              color: Colors.white,
              size: 52,
            ),
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
                  colors: [
                    Color(0xFF60A5FA),
                    Color(0xFFA78BFA),
                    Color(0xFFF472B6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(b),
                child: const Text(
                  'Tu vacante a la PNP\ncomienza aquí',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.15,
                    letterSpacing: -1.0,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'La única plataforma con Simuladores Oficiales, IA de entrenamiento, Arena Multijugador y tests médicos reales. Todo por un único pago.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withValues(alpha: 0.65),
                  height: 1.5,
                ),
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
          'Simuladores Oficiales · IA ARIA · Arena PvP\nTests Médicos · Cuadro de Mérito Real',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.6),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  // ── Benefits List ─────────────────────────────────────────────────────────────
  Widget _buildBenefitsList() {
    return Column(
      children: _benefits.map((b) => _buildBenefitItem(b)).toList(),
    );
  }

  Widget _buildBenefitItem(_Benefit b) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: b.color.withValues(alpha: 0.05),
        border: Border.all(color: b.color.withValues(alpha: 0.15), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: b.color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: b.color.withValues(alpha: 0.3)),
            ),
            child: Icon(b.icon, color: b.color, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        b.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: b.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        b.tag,
                        style: TextStyle(
                          color: b.color,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  b.subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 4, left: 10),
            child: Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF22C55E),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  // ── Checkout Card ─────────────────────────────────────────────────────────────
  Widget _buildUnifiedCheckoutCard() {
    final checkoutContent = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cabecera
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF7C3AED)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PLAN COMPLETO EDUPOL',
                      style: TextStyle(
                        color: Color(0xFF93C5FD),
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      'Acceso Permanente',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF22C55E).withValues(alpha: 0.5),
                  ),
                ),
                child: const Text(
                  'ÚNICO PAGO',
                  style: TextStyle(
                    color: Color(0xFF4ADE80),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(color: Color(0xFF1E3A5F), thickness: 1.5),
          const SizedBox(height: 12),

          // Precio tachado + precio real
          Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                       'S/60',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.35),
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.white.withValues(alpha: 0.35),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'S/',
                      style: TextStyle(
                        color: Color(0xFF60A5FA),
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (b) => const LinearGradient(
                        colors: [Color(0xFF60A5FA), Color(0xFFA78BFA)],
                      ).createShader(b),
                      child: const Text(
                         '30',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 72,
                          fontWeight: FontWeight.w900,
                          height: 1,
                          letterSpacing: -3,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '.00',
                            style: TextStyle(
                              color: Color(0xFF60A5FA),
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'soles',
                            style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.4),
                    ),
                  ),
                  child: const Text(
                    '50% OFF · Oferta de lanzamiento · Antes S/60',
                    style: TextStyle(
                      color: Color(0xFFFF6B6B),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Pago único · Sin mensualidades · Sin sorpresas',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // ─ Botón principal CTA ─
          _buildBuyButton(),

          const SizedBox(height: 14),
          const Divider(color: Color(0xFF1E3A5F), thickness: 1.5),
          const SizedBox(height: 10),

          // Pasos de cómo comprar
          _buildHowToBuy(),

          const SizedBox(height: 14),
          const Divider(color: Color(0xFF1E3A5F), thickness: 1.5),
          const SizedBox(height: 10),

          // Links secundarios
          _buildSecondaryButton(
            icon: Icons.home_rounded,
            label: 'Volver al menú principal',
            subtitle: 'Explorar la aplicación sin comprar',
            gradient: const [Color(0xFF64748B), Color(0xFF475569)],
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/home');
              }
            },
          ),
          const SizedBox(height: 8),
          _buildSecondaryButton(
            icon: Icons.groups_rounded,
            label: 'Comunidad de WhatsApp',
            subtitle: 'Únete para recibir novedades gratis',
            gradient: const [Color(0xFF25D366), Color(0xFF075E54)],
            onTap: () => _launchUrl(
              'https://whatsapp.com/channel/0029Vb8DGVV7YSd7ld4WjX05',
            ),
          ),
          const SizedBox(height: 8),
          _buildSecondaryButton(
            icon: Icons.download_for_offline_rounded,
            label: 'Descargar App (Android / PC)',
            subtitle: 'Consigue la versión para celular y computadora',
            gradient: const [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
            onTap: () => _launchUrl(
              'https://drive.google.com/drive/folders/1HOvLB-RUYYPUABrrNRbjrrVFcEs-6ooE?usp=sharing',
            ),
          ),

          const SizedBox(height: 16),
          const Divider(color: Color(0xFF1E3A5F), thickness: 1.5),
          const SizedBox(height: 12),

          // Trust badges
          _buildTrustBadges(),

          const SizedBox(height: 14),
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
        border: Border.all(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
            blurRadius: 35,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.15),
            blurRadius: 45,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: kIsWeb
            ? checkoutContent
            : BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: checkoutContent,
              ),
      ),
    );
  }

  Widget _buildHowToBuy() {
    final steps = [
      ('1', 'Toca "COMPRAR AHORA"', 'Se abre WhatsApp automáticamente'),
      ('2', 'Paga S/30 por Yape o Plin', 'Número del administrador'),
      ('3', 'Envía captura del pago', 'Al mismo WhatsApp'),
      ('4', '¡Acceso activado!', 'En menos de 1 hora'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CÓMO COMPRAR (4 PASOS):',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        ...steps.map(
          (s) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Color(0xFF25D366),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      s.$1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.$2,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      Text(
                        s.$3,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.45),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBuyButton() {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressing = true),
      onTapUp: (_) {
        setState(() => _isPressing = false);
        _launchWhatsApp();
      },
      onTapCancel: () => setState(() => _isPressing = false),
      child: AnimatedScale(
        scale: _isPressing ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: RepaintBoundary(
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
                    color: const Color(
                      0xFF25D366,
                    ).withValues(alpha: 0.5 * _pulseAnim.value),
                    blurRadius: 28 * _pulseAnim.value,
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
                    Text(
                      'COMPRAR AHORA · S/30',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'Toca aquí · Pagar por WhatsApp',
                      style: TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrustBadges() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const _TrustItem(
          icon: Icons.verified_user_rounded,
          label: '100%\nSeguro',
          color: Color(0xFF22C55E),
        ),
        Container(
          height: 40,
          width: 1,
          color: Colors.white.withValues(alpha: 0.1),
        ),
        const _TrustItem(
          icon: Icons.flash_on_rounded,
          label: 'Activación\nInmediata',
          color: Color(0xFF3B82F6),
        ),
        Container(
          height: 40,
          width: 1,
          color: Colors.white.withValues(alpha: 0.1),
        ),
        const _TrustItem(
          icon: Icons.phone_android_rounded,
          label: 'Yape /\nPlin',
          color: Color(0xFF8B5CF6),
        ),
      ],
    );
  }

  Widget _buildSecurityText() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline_rounded,
              color: Colors.white.withValues(alpha: 0.3),
              size: 14,
            ),
            const SizedBox(width: 6),
            Text(
              'Pago 100% seguro por Yape o Plin',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Tu acceso se activa en menos de 1 hora',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.3),
            fontSize: 11,
          ),
        ),
      ],
    );
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
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
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
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white.withValues(alpha: 0.3),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  // ── Comparison Section ────────────────────────────────────────────────────────
  Widget _buildComparisonSection() {
    return Column(
      children: [
        _buildSectionHeader('EDUPOL vs ACADEMIA TRADICIONAL'),
        const SizedBox(height: 6),
        Text(
          'La ventaja competitiva desleal que mereces',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withValues(alpha: 0.03),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // Header row
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                color: Colors.white.withValues(alpha: 0.05),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Text(
                        'Característica',
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3B82F6), Color(0xFF7C3AED)],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'EDUPOL',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Academia',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...List.generate(_competitorComparison.length, (i) {
                final row = _competitorComparison[i];
                final isEven = i % 2 == 0;
                return Container(
                  color: isEven
                      ? Colors.white.withValues(alpha: 0.02)
                      : Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          row.feature,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          row.edupol,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF22C55E),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: Text(
                          row.competitor,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.3),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  // ── FAQ Section ───────────────────────────────────────────────────────────────
  Widget _buildFaqSection() {
    return Column(
      children: [
        _buildSectionHeader('PREGUNTAS FRECUENTES'),
        const SizedBox(height: 24),
        ...List.generate(_faqs.length, (i) {
          final isExpanded = _expandedFaq == i;
          final faq = _faqs[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: isExpanded
                  ? const Color(0xFF3B82F6).withValues(alpha: 0.08)
                  : Colors.white.withValues(alpha: 0.03),
              border: Border.all(
                color: isExpanded
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.4)
                    : Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: InkWell(
              onTap: () => setState(() => _expandedFaq = isExpanded ? -1 : i),
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            faq.question,
                            style: TextStyle(
                              color: isExpanded
                                  ? const Color(0xFF93C5FD)
                                  : Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: isExpanded
                              ? const Color(0xFF60A5FA)
                              : Colors.white.withValues(alpha: 0.4),
                        ),
                      ],
                    ),
                    if (isExpanded) ...[
                      const SizedBox(height: 10),
                      Text(
                        faq.answer,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.65),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  // ── Final CTA Banner ──────────────────────────────────────────────────────────
  Widget _buildFinalCTABanner() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E3A5F), Color(0xFF1A1040)],
        ),
        border: Border.all(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
            blurRadius: 40,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (b) => const LinearGradient(
              colors: [Color(0xFF60A5FA), Color(0xFFA78BFA)],
            ).createShader(b),
            child: const Text(
              '¿Sigues pensándolo?\nEl cupo de tu vacante no espera.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Miles de postulantes están entrenando ahora mismo en la Arena Policial. Cada día que pasa, ellos se ponen por delante tuyo en el Cuadro de Mérito.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _launchWhatsApp,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF25D366), Color(0xFF1DAA54)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF25D366).withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.message_rounded, color: Colors.white, size: 22),
                  SizedBox(width: 10),
                  Text(
                    'UNIRME AHORA POR S/30',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Utility ───────────────────────────────────────────────────────────────────
  Widget _buildSectionHeader(String text) {
    return ShaderMask(
      shaderCallback: (b) => const LinearGradient(
        colors: [Color(0xFF60A5FA), Color(0xFFA78BFA)],
      ).createShader(b),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ─── Trust Item ───────────────────────────────────────────────────────────────

class _TrustItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _TrustItem({
    required this.icon,
    required this.label,
    required this.color,
  });

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
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 11,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
        ),
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
    final bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF060B18), Color(0xFF0A1628), Color(0xFF080E1E)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);

    _drawOrb(canvas, size, 0.15, 0.2, 0.0, const Color(0xFF3B82F6));
    _drawOrb(canvas, size, 0.85, 0.6, 0.3, const Color(0xFF7C3AED));
    _drawOrb(canvas, size, 0.5, 0.9, 0.6, const Color(0xFF06B6D4));

    final grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.025)
      ..strokeWidth = 0.5;
    const step = 50.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  void _drawOrb(
    Canvas canvas,
    Size size,
    double nx,
    double ny,
    double phase,
    Color color,
  ) {
    final pulse = math.sin((t + phase) * 2 * math.pi) * 0.5 + 0.5;
    final radius = (size.shortestSide * 0.55) * (0.85 + pulse * 0.15);
    final opacity = 0.04 + pulse * 0.04;

    final paint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              color.withValues(alpha: opacity),
              color.withValues(alpha: 0),
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(nx * size.width, ny * size.height),
              radius: radius,
            ),
          );

    canvas.drawCircle(Offset(nx * size.width, ny * size.height), radius, paint);
  }

  @override
  bool shouldRepaint(_BgPainter old) => old.t != t;
}

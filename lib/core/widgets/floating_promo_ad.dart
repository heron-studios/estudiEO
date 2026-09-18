import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/core/config/app_config.dart';

/// Anuncio oficial de alta conversión para la App Oficial de Android de EDUPOL.
/// Muestra un modal centrado con posters completos en proporción vertical nativa (1:2)
/// tanto en Computadora (diseño split de 2 columnas) como en Web Móvil (diseño vertical responsivo),
/// con argumentos persuasivos para convencer al usuario de instalar la app.
class FloatingPromoAd extends StatefulWidget {
  final double? bottomOffset;
  final double? rightOffset;
  final double? leftOffset;

  const FloatingPromoAd({
    super.key,
    this.bottomOffset,
    this.rightOffset,
    this.leftOffset,
  });

  @override
  State<FloatingPromoAd> createState() => _FloatingPromoAdState();
}

class _FloatingPromoAdState extends State<FloatingPromoAd>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = true;
  late final PageController _pageController;
  int _currentIndex = 0;
  Timer? _carouselTimer;

  static const List<Map<String, String>> _promoSlides = [
    {
      'image': 'assets/images/promo_1.jpg',
      'tag': 'ADMISION PNP 2026',
      'title': '¿Quieres ser Policía Nacional?',
      'subtitle': 'Simulacros reales cronometrados y preparación táctica para tu ingreso.',
    },
    {
      'image': 'assets/images/promo_2.jpg',
      'tag': 'METODOLOGÍA INTELIGENTE',
      'title': 'Tu Herramienta Clave de Estudio',
      'subtitle': 'Temarios completos, Flashcards SRS y Bóveda de Errores en tu bolsillo.',
    },
    {
      'image': 'assets/images/promo_3.jpg',
      'tag': 'RADAR PREDICTIVO',
      'title': 'Toda la Información en tus Manos',
      'subtitle': 'Diagnóstico predictivo de puntos críticos sin cargar libros pesados.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
  }

  void _startTimer() {
    _carouselTimer?.cancel();
    _carouselTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || !_pageController.hasClients || !_isExpanded) return;
      final nextIndex = (_currentIndex + 1) % _promoSlides.length;
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _pauseTimer() {
    _carouselTimer?.cancel();
  }

  void _goToPreviousSlide() {
    _pauseTimer();
    final prevIndex =
        (_currentIndex - 1 + _promoSlides.length) % _promoSlides.length;
    _pageController.animateToPage(
      prevIndex,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void _goToNextSlide() {
    _pauseTimer();
    final nextIndex = (_currentIndex + 1) % _promoSlides.length;
    _pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _launchPlayStore() async {
    final uri = Uri.parse(AppConfig.playStoreUrl);
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
            content: Text('No se pudo abrir Google Play Store: $e'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    }
  }

  Future<void> _launchDownload() async {
    final uri = Uri.parse(AppConfig.androidApkDownloadUrl);
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
            content: Text('No se pudo abrir el enlace de descarga: $e'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isExpanded) {
      final screenWidth = MediaQuery.sizeOf(context).width;
      final isMobile = screenWidth < 600;
      final defaultBottom = isMobile ? 86.0 : 24.0;
      final bottom = widget.bottomOffset ?? defaultBottom;
      final right = widget.rightOffset ?? 16.0;

      return Positioned(
        bottom: bottom,
        right: right,
        left: widget.leftOffset,
        child: _buildCollapsedPill(),
      );
    }

    // Modal centrado en pantalla con telón oscurecido y desenfoque
    return Positioned.fill(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Telón táctil para cerrar tocando afuera
          GestureDetector(
            onTap: () {
              _pauseTimer();
              setState(() => _isExpanded = false);
            },
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 7, sigmaY: 7),
              child: Container(
                color: Colors.black.withValues(alpha: 0.68),
              ),
            ),
          ),

          // Tarjeta Principal (Split en desktop, vertical en mobile)
          Center(
            child: _buildExpandedCard(context),
          ),
        ],
      ),
    );
  }

  /// Píldora colapsada en la esquina inferior derecha
  Widget _buildCollapsedPill() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() => _isExpanded = true);
          _startTimer();
        },
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xE60F172A),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color(0xFF10B981).withValues(alpha: 0.6),
              width: 1.4,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withValues(alpha: 0.25),
                blurRadius: 16,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.android_rounded,
                  color: Colors.white,
                  size: 15,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Instalar App Android',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  fontFamily: 'Outfit',
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.open_in_full_rounded,
                color: Color(0xFF34D399),
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Selector de tarjeta: Computadora (Split) o Móvil (Vertical)
  Widget _buildExpandedCard(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    final isDesktop = media.width >= 768;

    if (isDesktop) {
      return _buildDesktopCard(context, media);
    } else {
      return _buildMobileCard(context, media);
    }
  }

  /// ── MODAL COMPUTADORA / ESCRITORIO (DISEÑO SPLIT DE 2 COLUMNAS) ──
  Widget _buildDesktopCard(BuildContext context, Size media) {
    final cardWidth = (media.width * 0.72).clamp(760.0, 860.0);
    final cardHeight = (media.height * 0.84).clamp(520.0, 580.0);

    return Material(
      color: Colors.transparent,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF141E34)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: const Color(0xFF10B981).withValues(alpha: 0.45),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.8),
              blurRadius: 40,
              spreadRadius: 3,
              offset: const Offset(0, 16),
            ),
            BoxShadow(
              color: const Color(0xFF10B981).withValues(alpha: 0.22),
              blurRadius: 30,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Columna Izquierda: Showcase de Posters Verticales (Sin recortes)
              SizedBox(
                width: 290,
                child: _buildPosterShowcase(isDesktop: true),
              ),

              // Separador sutil
              Container(
                width: 1,
                color: Colors.white.withValues(alpha: 0.08),
              ),

              // Columna Derecha: Panel Persuasivo de Alta Conversión
              Expanded(
                child: _buildDesktopPersuasionPanel(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Showcase de Posters Verticales (Mantiene proporción 100% nativa)
  Widget _buildPosterShowcase({required bool isDesktop}) {
    return Container(
      color: const Color(0xFF070B14),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Carrusel de imágenes sin recorte
          PageView.builder(
            controller: _pageController,
            onPageChanged: (idx) => setState(() => _currentIndex = idx),
            itemCount: _promoSlides.length,
            itemBuilder: (context, index) {
              final slide = _promoSlides[index];
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  isDesktop ? 14 : 12,
                  isDesktop ? 16 : 10,
                  isDesktop ? 14 : 12,
                  isDesktop ? 34 : 26,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D1424),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.6),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(19),
                    child: Image.asset(
                      slide['image']!,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(
                          Icons.image_not_supported_rounded,
                          color: Colors.white24,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Flecha de navegación: Izquierda
          Positioned(
            left: 6,
            child: _buildArrowButton(
              icon: Icons.chevron_left_rounded,
              tooltip: 'Anterior',
              onPressed: _goToPreviousSlide,
            ),
          ),

          // Flecha de navegación: Derecha
          Positioned(
            right: 6,
            child: _buildArrowButton(
              icon: Icons.chevron_right_rounded,
              tooltip: 'Siguiente',
              onPressed: _goToNextSlide,
            ),
          ),

          // Badge superior con contador de diapositivas
          Positioned(
            top: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.touch_app_rounded,
                    size: 11,
                    color: Color(0xFF34D399),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${_currentIndex + 1} / ${_promoSlides.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Puntos indicadores de paginación
          Positioned(
            bottom: isDesktop ? 12 : 8,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                _promoSlides.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentIndex == i ? 22 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _currentIndex == i
                        ? const Color(0xFF10B981)
                        : Colors.white30,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Botón de flecha circular para navegación rápida del poster
  Widget _buildArrowButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.7),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.22),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 8,
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  /// Panel persuasivo para computadora con argumentos de conversión
  Widget _buildDesktopPersuasionPanel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 22, 28, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Cabecera: Badges flexibles y Botón Cerrar
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF10B981).withValues(alpha: 0.45),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shield_rounded, size: 14, color: Color(0xFF34D399)),
                          SizedBox(width: 6),
                          Text(
                            'EDUPOL ANDROID OFICIAL',
                            style: TextStyle(
                              color: Color(0xFF34D399),
                              fontWeight: FontWeight.w900,
                              fontSize: 11,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star_rounded, size: 14, color: Color(0xFFFBBF24)),
                          SizedBox(width: 4),
                          Text(
                            '4.9 ★ (+10,000 postulantes)',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white70,
                    size: 18,
                  ),
                ),
                tooltip: 'Cerrar anuncio',
                onPressed: () {
                  _pauseTimer();
                  setState(() => _isExpanded = false);
                },
              ),
            ],
          ),

          // Título y Gancho Principal
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '¡Asegura tu Ingreso a la Policía Nacional!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Outfit',
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'No te limites al navegador web. La App nativa te ofrece una ventaja competitiva decisiva para aprobar con honores:',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 13,
                  height: 1.35,
                ),
              ),
            ],
          ),

          // 4 Pilares de Valor (Convencimiento)
          Column(
            children: [
              _buildFeatureRow(
                icon: Icons.offline_bolt_rounded,
                iconColor: const Color(0xFF10B981),
                title: 'Modo Práctica 100% Offline',
                desc: 'Resuelve bancos y simulacros completos sin consumir megas ni depender de Wi-Fi.',
              ),
              const SizedBox(height: 9),
              _buildFeatureRow(
                icon: Icons.speed_rounded,
                iconColor: const Color(0xFF38BDF8),
                title: 'Máxima Fluidez y Cero Lag',
                desc: 'Respuesta táctil instantánea, sin recargas de página web ni esperas.',
              ),
              const SizedBox(height: 9),
              _buildFeatureRow(
                icon: Icons.radar_rounded,
                iconColor: const Color(0xFFA78BFA),
                title: 'Radar Predictivo de Rendimiento',
                desc: 'Algoritmo que detecta en qué temas vas a fallar antes del examen real.',
              ),
              const SizedBox(height: 9),
              _buildFeatureRow(
                icon: Icons.security_update_good_rounded,
                iconColor: const Color(0xFFF59E0B),
                title: 'Bóveda de Errores con Repaso SRS',
                desc: 'Convierte tus fallas en aciertos con preguntas repetidas estratégicamente.',
              ),
            ],
          ),

          // Botones de Acción (CTAs)
          Row(
            children: [
              // Botón Principal: Play Store
              Expanded(
                flex: 6,
                child: FilledButton.icon(
                  onPressed: _launchPlayStore,
                  icon: const Icon(Icons.play_arrow_rounded, size: 23),
                  label: const Text(
                    'Instalar desde Play Store',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.5,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFF10B981).withValues(alpha: 0.5),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Botón Secundario: Descarga APK
              Expanded(
                flex: 4,
                child: OutlinedButton.icon(
                  onPressed: _launchDownload,
                  icon: const Icon(
                    Icons.download_rounded,
                    size: 19,
                    color: Color(0xFF38BDF8),
                  ),
                  label: const Text(
                    'Descargar APK',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.25),
                      width: 1.2,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Sellos de Confianza
          const Center(
            child: Text(
              '✓ Verificado por Play Protect • ✓ Temario PNP 2026 • ✓ 100% Gratuito',
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

  /// ── MODAL WEB MÓVIL (DISEÑO VERTICAL RESPONSIVO SIN OVERFLOW) ──
  Widget _buildMobileCard(BuildContext context, Size media) {
    final cardWidth = (media.width - 24.0).clamp(290.0, 430.0);

    return Material(
      color: Colors.transparent,
      child: Container(
        width: cardWidth,
        constraints: BoxConstraints(
          maxHeight: media.height * 0.90,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF162035)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFF10B981).withValues(alpha: 0.45),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.8),
              blurRadius: 35,
              spreadRadius: 2,
              offset: const Offset(0, 14),
            ),
            BoxShadow(
              color: const Color(0xFF10B981).withValues(alpha: 0.20),
              blurRadius: 25,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Cabecera compacta
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 10, 8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.android_rounded,
                          color: Color(0xFF34D399),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'EDUPOL OFICIAL ANDROID',
                              style: TextStyle(
                                color: Color(0xFF34D399),
                                fontWeight: FontWeight.w900,
                                fontSize: 11.5,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              '⭐ 4.9 • En Google Play y APK Directa',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.white70,
                            size: 16,
                          ),
                        ),
                        onPressed: () {
                          _pauseTimer();
                          setState(() => _isExpanded = false);
                        },
                      ),
                    ],
                  ),
                ),

                // Showcase del poster en formato smartphone (~330px de alto)
                SizedBox(
                  height: 330,
                  child: _buildPosterShowcase(isDesktop: false),
                ),

                // Argumentos persuasivos y Botones de Instalación
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        '¡Estudia como un verdadero Oficial!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.5,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Outfit',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'La App oficial corre a máxima velocidad sin cortes, incluye modo offline sin gastar datos y radar predictivo PNP.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 12,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 14),

                      // Botón Play Store
                      FilledButton.icon(
                        onPressed: _launchPlayStore,
                        icon: const Icon(Icons.play_arrow_rounded, size: 22),
                        label: const Text(
                          'Instalar desde Play Store',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.5,
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          elevation: 3,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Botón Descargar APK
                      OutlinedButton.icon(
                        onPressed: _launchDownload,
                        icon: const Icon(
                          Icons.download_rounded,
                          size: 18,
                          color: Color(0xFF38BDF8),
                        ),
                        label: const Text(
                          'Descargar APK Directa',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.25),
                            width: 1.2,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '✓ Verificado por Play Protect • Temario PNP 2026',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
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

  /// Fila de beneficio con icono premium
  Widget _buildFeatureRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String desc,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: iconColor.withValues(alpha: 0.35),
              width: 1,
            ),
          ),
          child: Icon(icon, size: 16, color: iconColor),
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
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 11,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

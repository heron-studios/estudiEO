import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/core/config/app_config.dart';

/// Anuncio oficial ultra-moderno, centrado y ampliado para la App Oficial de Android.
/// Se muestra centrado en pantalla al entrar al login y al menú principal, y puede minimizarse a una píldora flotante.
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
      'tag': 'PROSPECTO PNP 2026',
      'title': '¿Quieres ser Policía Nacional?',
      'subtitle': 'Simulacros reales cronometrados, diagnóstico predictivo y retroalimentación inmediata.',
    },
    {
      'image': 'assets/images/promo_2.jpg',
      'tag': 'METODOLOGÍA INTELIGENTE',
      'title': 'Tu Herramienta Clave de Estudio',
      'subtitle': 'Temarios completos, Flashcards SRS y Bóveda de Errores para asegurar tu ingreso.',
    },
    {
      'image': 'assets/images/promo_3.jpg',
      'tag': 'APP OFICIAL ANDROID',
      'title': 'Estudia en Cualquier Lugar',
      'subtitle': 'Mayor fluidez gráfica nativa, sin lag y con modo de práctica táctica offline.',
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
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _pauseTimer() {
    _carouselTimer?.cancel();
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
            content: Text('No se pudo abrir Play Store: $e'),
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

    // Cuando está expandido, se muestra centrado en toda la pantalla con backdrop sutil
    return Positioned.fill(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Telón semitransparente con blur que permite cerrar al hacer clic afuera
          GestureDetector(
            onTap: () {
              _pauseTimer();
              setState(() => _isExpanded = false);
            },
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: Colors.black.withValues(alpha: 0.65),
              ),
            ),
          ),

          // Tarjeta Principal Centrada y Ampliada
          Center(
            child: _buildExpandedCard(context),
          ),
        ],
      ),
    );
  }

  /// Vista colapsada: píldora flotante compacta en la esquina
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

  /// Vista expandida: anuncio centrado, amplio y de alto impacto visual
  Widget _buildExpandedCard(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    final isDesktop = media.width >= 700;
    final cardWidth = isDesktop ? 580.0 : (media.width - 32.0).clamp(300.0, 500.0);
    final carouselHeight = isDesktop ? 220.0 : 175.0;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: cardWidth,
        constraints: BoxConstraints(
          maxHeight: media.height * 0.90,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF161E31)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: const Color(0xFF10B981).withValues(alpha: 0.45),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.7),
              blurRadius: 35,
              spreadRadius: 4,
              offset: const Offset(0, 14),
            ),
            BoxShadow(
              color: const Color(0xFF10B981).withValues(alpha: 0.20),
              blurRadius: 30,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── HEADER DEL ANUNCIO ──
                Container(
                  padding: const EdgeInsets.fromLTRB(18, 14, 12, 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withValues(alpha: 0.07),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFF10B981).withValues(alpha: 0.4),
                          ),
                        ),
                        child: const Icon(
                          Icons.android_rounded,
                          color: Color(0xFF34D399),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'EDUPOL OFICIAL',
                                  style: TextStyle(
                                    color: Color(0xFF34D399),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Badge(
                                  backgroundColor: Color(0xFF10B981),
                                  label: Text(
                                    'ANDROID',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Disponible en Google Play y descarga directa',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Botón cerrar
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
                ),

                // ── CARRUSEL VISUAL AMPLIO ──
                SizedBox(
                  height: carouselHeight,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        onPageChanged: (idx) {
                          setState(() => _currentIndex = idx);
                        },
                        itemCount: _promoSlides.length,
                        itemBuilder: (context, index) {
                          final slide = _promoSlides[index];
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                slide['image']!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: const Color(0xFF1E293B),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.image_not_supported_rounded,
                                    color: Colors.white24,
                                    size: 40,
                                  ),
                                ),
                              ),
                              // Gradiente oscuro suave para legibilidad premium
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 0.85),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                              // Textos destacados superpuestos
                              Positioned(
                                bottom: 14,
                                left: 18,
                                right: 18,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF10B981),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        slide['tag']!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9.5,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      slide['title']!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: isDesktop ? 17 : 14.5,
                                        fontFamily: 'Outfit',
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      slide['subtitle']!,
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.85),
                                        fontSize: isDesktop ? 12 : 11,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      // Indicadores de puntos (dots)
                      Positioned(
                        top: 12,
                        right: 14,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            _promoSlides.length,
                            (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.symmetric(horizontal: 2.5),
                              width: _currentIndex == i ? 18 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: _currentIndex == i
                                    ? const Color(0xFF10B981)
                                    : Colors.white38,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── SECCIÓN DE BOTONES DE ACCIÓN ──
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
                  child: Column(
                    children: [
                      if (isDesktop)
                        Row(
                          children: [
                            // Botón Google Play Store
                            Expanded(
                              flex: 6,
                              child: FilledButton.icon(
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
                                  padding: const EdgeInsets.symmetric(vertical: 13),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  elevation: 4,
                                  shadowColor: const Color(0xFF10B981).withValues(alpha: 0.5),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Botón Descargar APK Directa
                            Expanded(
                              flex: 5,
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
                                  padding: const EdgeInsets.symmetric(vertical: 13),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            // Botón Google Play Store
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
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
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  elevation: 4,
                                  shadowColor: const Color(0xFF10B981).withValues(alpha: 0.5),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Botón Descargar APK Directa
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
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
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      const SizedBox(height: 12),

                      // Garantías / Mini pills
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 12,
                        runSpacing: 6,
                        children: [
                          _buildMiniBadge(Icons.verified_user_rounded, 'Play Protect'),
                          _buildMiniBadge(Icons.bolt_rounded, 'Sin latencia'),
                          _buildMiniBadge(Icons.wifi_off_rounded, 'Modo offline'),
                        ],
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

  Widget _buildMiniBadge(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: const Color(0xFF10B981)),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

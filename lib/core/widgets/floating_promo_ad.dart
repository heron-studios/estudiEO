import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/core/config/app_config.dart';

/// Anuncio flotante ultra-moderno y persistente para la descarga de la App Oficial de Android.
/// Se muestra en la pantalla de Login y en el Menú Principal (Home).
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
      'title': '¿Quieres ser Policía?',
      'subtitle': 'Simulacros reales cronometrados y evaluación táctica.',
    },
    {
      'image': 'assets/images/promo_2.jpg',
      'tag': 'ESTUDIO INTELIGENTE',
      'title': 'Herramienta Definitiva',
      'subtitle': 'Bancos 2026, Flashcards SRS y Bóveda de Errores.',
    },
    {
      'image': 'assets/images/promo_3.jpg',
      'tag': 'APP OFICIAL ANDROID',
      'title': 'Estudia Sin Conexión',
      'subtitle': 'Mayor fluidez gráfica, sin lag y práctica offline.',
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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;

    // Calcular posición responsiva para no chocar con elementos inferiores
    final defaultBottom = isMobile ? 86.0 : 24.0;
    final bottom = widget.bottomOffset ?? defaultBottom;
    final right = widget.rightOffset ?? 16.0;

    return Positioned(
      bottom: bottom,
      right: right,
      left: widget.leftOffset,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        child: _isExpanded ? _buildExpandedCard(isMobile) : _buildCollapsedPill(),
      ),
    );
  }

  /// Vista colapsada: píldora flotante compacta y elegante
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
                Icons.keyboard_arrow_up_rounded,
                color: Color(0xFF34D399),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Vista expandida: tarjeta flotante con carrusel e instalación directa
  Widget _buildExpandedCard(bool isMobile) {
    final cardWidth = isMobile ? 290.0 : 310.0;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: const Color(0xF20F172A),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFF10B981).withValues(alpha: 0.4),
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.55),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: const Color(0xFF10B981).withValues(alpha: 0.15),
              blurRadius: 20,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── HEADER SUPERIOR ──
                Container(
                  padding: const EdgeInsets.fromLTRB(14, 10, 8, 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withValues(alpha: 0.06),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.android_rounded,
                          color: Color(0xFF34D399),
                          size: 15,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'APP OFICIAL ANDROID',
                              style: TextStyle(
                                color: Color(0xFF34D399),
                                fontWeight: FontWeight.w900,
                                fontSize: 10.5,
                                letterSpacing: 0.6,
                              ),
                            ),
                            Text(
                              'Disponible para descarga directa',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 9.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Botón para minimizar a píldora
                      IconButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.white70,
                          size: 20,
                        ),
                        tooltip: 'Minimizar anuncio',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 28,
                          minHeight: 28,
                        ),
                        onPressed: () {
                          _pauseTimer();
                          setState(() => _isExpanded = false);
                        },
                      ),
                    ],
                  ),
                ),

                // ── CARRUSEL VISUAL ──
                SizedBox(
                  height: 130,
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
                                    size: 32,
                                  ),
                                ),
                              ),
                              // Gradiente oscuro para texto legible
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withValues(alpha: 0.1),
                                      Colors.black.withValues(alpha: 0.8),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                              // Textos superpuestos
                              Positioned(
                                bottom: 8,
                                left: 12,
                                right: 12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF10B981),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        slide['tag']!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      slide['title']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12.5,
                                        fontFamily: 'Outfit',
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      slide['subtitle']!,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                        top: 8,
                        right: 10,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            _promoSlides.length,
                            (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              width: _currentIndex == i ? 14 : 5,
                              height: 5,
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

                // ── BOTONES DE INSTALACIÓN Y DESCARGA ──
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
                  child: Column(
                    children: [
                      // Botón Play Store
                      FilledButton(
                        onPressed: _launchPlayStore,
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 9,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          shadowColor: const Color(0xFF10B981).withValues(alpha: 0.5),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow_rounded, size: 19),
                            SizedBox(width: 6),
                            Text(
                              'Instalar desde Play Store',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.5,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Botón Descargar APK Directa
                      OutlinedButton(
                        onPressed: _launchDownload,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.22),
                            width: 1.0,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.download_rounded,
                              size: 16,
                              color: Color(0xFF34D399),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Descargar APK Directa',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 11.5,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Google Play Store oficial • APK Android 8.0+',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 9.5,
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
}

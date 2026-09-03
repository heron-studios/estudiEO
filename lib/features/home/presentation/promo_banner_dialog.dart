import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'downloads_dialog.dart';

/// Diálogo modal con banner publicitario interactivo para las 3 imágenes promocionales oficiales de Edupol.
/// Se muestra automáticamente al entrar o recargar la página (controlado por sesión en memoria).
class PromoBannerDialog extends StatefulWidget {
  /// Flag estático en memoria que persiste durante la sesión actual de la pestaña.
  /// Al recargar (F5 / reload) o cerrar y reabrir la web, vuelve a `false`.
  static bool hasSeenPromoThisSession = false;

  const PromoBannerDialog({super.key});

  /// Muestra el modal si aún no ha sido visto en esta sesión.
  static void showIfFirstTime(BuildContext context) {
    if (hasSeenPromoThisSession) return;
    hasSeenPromoThisSession = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: 'Cerrar Banner Promocional',
        barrierColor: Colors.black.withValues(alpha: 0.75),
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (ctx, anim1, anim2) => const PromoBannerDialog(),
        transitionBuilder: (ctx, anim, _, child) {
          final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
          return ScaleTransition(
            scale: Tween<double>(begin: 0.92, end: 1.0).animate(curved),
            child: FadeTransition(
              opacity: curved,
              child: child,
            ),
          );
        },
      );
    });
  }

  @override
  State<PromoBannerDialog> createState() => _PromoBannerDialogState();
}

class _PromoBannerDialogState extends State<PromoBannerDialog> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _autoSlideTimer;

  static const List<Map<String, String>> _promoItems = [
    {
      'image': 'assets/images/promo_1.jpg',
      'tag': 'PROSPECTO PNP 2026',
      'title': '¿Quieres ser Policía?',
      'subtitle': 'Prepárate con simulacros reales, cronometrados y con retroalimentación inmediata.',
    },
    {
      'image': 'assets/images/promo_2.jpg',
      'tag': 'METODOLOGÍA INTELIGENTE',
      'title': 'Tu Herramienta Definitiva',
      'subtitle': 'Temario completo, Flashcards SRS y Bóveda de Errores para no fallar en el examen.',
    },
    {
      'image': 'assets/images/promo_3.jpg',
      'tag': 'ESTUDIA DONDE SEA',
      'title': 'Toda la Información en tus Manos',
      'subtitle': 'Diagnóstico predictivo de riesgo y bancos actualizados sin cargar libros pesados.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || !_pageController.hasClients) return;
      final nextIndex = (_currentIndex + 1) % _promoItems.length;
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _pauseAutoSlide() {
    _autoSlideTimer?.cancel();
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isMobile = media.size.width < 700;
    final maxDialogWidth = isMobile ? media.size.width * 0.94 : 760.0;
    final maxDialogHeight = isMobile ? media.size.height * 0.88 : 620.0;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: maxDialogWidth,
          height: maxDialogHeight,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F766E).withValues(alpha: 0.35),
                blurRadius: 40,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.8),
                blurRadius: 50,
                spreadRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF0F172A),
                      Color(0xFF0D251C),
                      Color(0xFF061410),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.35),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    // Barra superior con Badge y botón Cerrar
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 14, 16, 8),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF059669), Color(0xFF10B981)],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF10B981).withValues(alpha: 0.3),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.verified_rounded, size: 13, color: Colors.white),
                                SizedBox(width: 5),
                                Text(
                                  'EDUPOL OFICIAL · PNP 2026',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          // Botón cerrar
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.08),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.15),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: Colors.white70,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Contenido central interactivo
                    Expanded(
                      child: isMobile
                          ? _buildMobileCarousel(context)
                          : _buildDesktopSplitView(context),
                    ),

                    // Barra inferior de acciones
                    _buildBottomBar(context, isMobile),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Vista para pantallas móviles con carrusel a pantalla completa y controles
  Widget _buildMobileCarousel(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (notif) {
              if (notif is ScrollStartNotification) _pauseAutoSlide();
              if (notif is ScrollEndNotification) _startAutoSlide();
              return false;
            },
            child: PageView.builder(
              controller: _pageController,
              itemCount: _promoItems.length,
              onPageChanged: (idx) => setState(() => _currentIndex = idx),
              itemBuilder: (ctx, idx) {
                final item = _promoItems[idx];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          item['image']!,
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                        // Sombra de fondo para legibilidad
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(16, 32, 16, 12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.85),
                                  Colors.black,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['subtitle']!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 12,
                                    height: 1.25,
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
              },
            ),
          ),
        ),
        // Indicador de puntos
        _buildDotsIndicator(),
      ],
    );
  }

  /// Vista dividida para escritorio/tablet (Imagen promocional a la izquierda, info destacada y selector a la derecha)
  Widget _buildDesktopSplitView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagen promocional vertical con bordes redondeados y sombra
          Expanded(
            flex: 11,
            child: MouseRegion(
              onEnter: (_) => _pauseAutoSlide(),
              onExit: (_) => _startAutoSlide(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: _promoItems.length,
                    onPageChanged: (idx) => setState(() => _currentIndex = idx),
                    itemBuilder: (ctx, idx) {
                      final item = _promoItems[idx];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.45),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            item['image']!,
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                          ),
                        ),
                      );
                    },
                  ),
                  // Flechas de navegación rápida
                  Positioned(
                    left: 6,
                    child: _buildArrowButton(
                      icon: Icons.chevron_left_rounded,
                      onTap: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOutCubic,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 6,
                    child: _buildArrowButton(
                      icon: Icons.chevron_right_rounded,
                      onTap: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOutCubic,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 24),

          // Columna informativa a la derecha
          Expanded(
            flex: 13,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Selector de pestañas para las 3 imágenes
                Row(
                  children: List.generate(_promoItems.length, (idx) {
                    final isSelected = _currentIndex == idx;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            idx,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOutCubic,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: EdgeInsets.only(right: idx < 2 ? 8 : 0),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF10B981).withValues(alpha: 0.18)
                                : Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF10B981).withValues(alpha: 0.6)
                                  : Colors.white.withValues(alpha: 0.08),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '0${idx + 1}',
                              style: TextStyle(
                                color: isSelected ? const Color(0xFF34D399) : Colors.white54,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 18),

                // Tag animado
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey('tag_$_currentIndex'),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF10B981).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      _promoItems[_currentIndex]['tag']!,
                      style: const TextStyle(
                        color: Color(0xFF34D399),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Título animado
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    _promoItems[_currentIndex]['title']!,
                    key: ValueKey('title_$_currentIndex'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      height: 1.15,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Subtítulo descriptivo
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    _promoItems[_currentIndex]['subtitle']!,
                    key: ValueKey('sub_$_currentIndex'),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // 3 Bullets de beneficios clave
                _buildBenefitRow(Icons.bolt_rounded, 'Aceleración de aprendizaje con algoritmos adaptativos.'),
                const SizedBox(height: 8),
                _buildBenefitRow(Icons.library_books_rounded, 'Bancos de preguntas 100% actualizados al prospecto.'),
                const SizedBox(height: 8),
                _buildBenefitRow(Icons.security_rounded, 'Simulación en tiempo real bajo condiciones de examen.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: const Color(0xFF34D399)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11.5,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildArrowButton({required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.65),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  Widget _buildDotsIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_promoItems.length, (idx) {
          final isSelected = _currentIndex == idx;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isSelected ? 22 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF10B981) : Colors.white24,
              borderRadius: BorderRadius.circular(3),
            ),
          );
        }),
      ),
    );
  }

  /// Barra inferior con CTA principal y botón secundario para cerrar
  Widget _buildBottomBar(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 12 : 16,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
      ),
      child: Row(
        children: [
          // Botón Cerrar / Continuar
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white60,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            ),
            child: const Text(
              'Continuar al Menú',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          const Spacer(),
          // Botón CTA Principal: Abrir Centro de Descargas
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF059669), Color(0xFF10B981), Color(0xFF22C55E)],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF10B981).withValues(alpha: 0.45),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop(); // Cierra el banner promocional
                  DownloadsDialog.show(context); // Abre el centro de descargas
                },
                borderRadius: BorderRadius.circular(14),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.download_rounded, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Instalar App Oficial',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
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
}

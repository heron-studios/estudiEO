import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Modelo de datos para las plataformas de descarga en la galería shader
class ShaderGalleryItem {
  final String id;
  final String title;
  final String format;
  final String badge;
  final Color badgeColor;
  final String image;
  final Color accentColor;
  final IconData icon;
  final String description;
  final List<String> specs;
  final String buttonLabel;
  final VoidCallback onDownload;

  const ShaderGalleryItem({
    required this.id,
    required this.title,
    required this.format,
    required this.badge,
    required this.badgeColor,
    required this.image,
    required this.accentColor,
    required this.icon,
    required this.description,
    required this.specs,
    required this.buttonLabel,
    required this.onDownload,
  });
}

/// Galería horizontal avanzada con efectos de shaders inspirados en WebGL / Three.js:
/// - Distorsión de plano 3D (Vertex Shader emulation via Matrix4)
/// - Desplazamiento de canales cromáticos / RGB shift al deslizar y pasar el cursor
/// - Reflejo especular holográfico interactivo según la posición del cursor (Pointer tracking)
/// - Desplazamiento fluido mediante rueda de ratón (mouse wheel) y arrastre inercial
class ShaderHorizontalGallery extends StatefulWidget {
  final List<ShaderGalleryItem> items;
  final bool isDesktop;

  const ShaderHorizontalGallery({
    super.key,
    required this.items,
    this.isDesktop = true,
  });

  @override
  State<ShaderHorizontalGallery> createState() => _ShaderHorizontalGalleryState();
}

class _ShaderHorizontalGalleryState extends State<ShaderHorizontalGallery>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _scanlineController;
  double _currentPage = 0.0;
  int _activeCardIndex = 0;

  @override
  void initState() {
    super.initState();
    // viewportFraction 0.78 en desktop permite ver los planos curvos laterales
    _pageController = PageController(
      viewportFraction: widget.isDesktop ? 0.78 : 0.88,
      initialPage: 0,
    );

    _pageController.addListener(() {
      if (_pageController.hasClients && _pageController.page != null) {
        setState(() {
          _currentPage = _pageController.page!;
          _activeCardIndex = _currentPage.round().clamp(0, widget.items.length - 1);
        });
      }
    });

    // Controlador para barrido continuo de líneas de escaneo (HUD shader)
    _scanlineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scanlineController.dispose();
    super.dispose();
  }

  void _scrollToPage(int page) {
    if (!_pageController.hasClients) return;
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeOutCubic,
    );
  }

  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent) return;
    if (!_pageController.hasClients) return;
    // Rueda del ratón para desplazamiento horizontal fluido
    if (event.scrollDelta.dy > 0 || event.scrollDelta.dx > 0) {
      if (_activeCardIndex < widget.items.length - 1) {
        _scrollToPage(_activeCardIndex + 1);
      }
    } else if (event.scrollDelta.dy < 0 || event.scrollDelta.dx < 0) {
      if (_activeCardIndex > 0) {
        _scrollToPage(_activeCardIndex - 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

    final activeItem = widget.items[_activeCardIndex];

    return Column(
      crossAxisAlignment:
          widget.isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // ── BARRA SUPERIOR DE CONTROL Y TABS DE PLATAFORMA ───────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Badge WebGL Shader
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: activeItem.accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: activeItem.accentColor.withValues(alpha: 0.35),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: activeItem.accentColor.withValues(alpha: 0.2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.view_in_ar_rounded,
                    size: 13,
                    color: activeItem.accentColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'ZONA DE DESCARGA 3D',
                    style: TextStyle(
                      color: activeItem.accentColor,
                      fontSize: 9.5,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),

            // Selector rápido de plataformas
            Row(
              children: List.generate(widget.items.length, (idx) {
                final item = widget.items[idx];
                final isSelected = _activeCardIndex == idx;
                return Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: InkWell(
                    onTap: () => _scrollToPage(idx),
                    borderRadius: BorderRadius.circular(14),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? item.accentColor.withValues(alpha: 0.2)
                            : Colors.white.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? item.accentColor.withValues(alpha: 0.6)
                              : Colors.white.withValues(alpha: 0.08),
                          width: isSelected ? 1.2 : 0.8,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item.icon,
                            size: 12,
                            color: isSelected ? item.accentColor : Colors.white60,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.id.toUpperCase(),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white60,
                              fontSize: 10,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Título interactivo
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descargas Oficiales de Alta Velocidad',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.4,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Desliza horizontalmente para explorar los instaladores nativos.',
                    style: TextStyle(
                      color: Color(0xFF9AA0A6),
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
            // Flechas prev / next
            Row(
              children: [
                _NavCircleButton(
                  icon: Icons.chevron_left_rounded,
                  enabled: _activeCardIndex > 0,
                  onTap: () => _scrollToPage(_activeCardIndex - 1),
                ),
                const SizedBox(width: 6),
                _NavCircleButton(
                  icon: Icons.chevron_right_rounded,
                  enabled: _activeCardIndex < widget.items.length - 1,
                  onTap: () => _scrollToPage(_activeCardIndex + 1),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 14),

        // ── VIEWPORT 3D SHADER (PAGEVIEW CON TRANSFORMACIONES GEOMÉTRICAS) ──
        Listener(
          onPointerSignal: _handlePointerSignal,
          child: SizedBox(
            height: widget.isDesktop ? 370 : 390,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.items.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final item = widget.items[index];

                // Distancia normalizada al centro [-1.0 .. 1.0]
                final dist = index - _currentPage;

                return _Shader3DCard(
                  item: item,
                  distanceFromCenter: dist,
                  isActive: _activeCardIndex == index,
                  scanlineAnimation: _scanlineController,
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 12),

        // ── TRACK DE PROGRESO Y GUÍA RÁPIDA ──────────────────────────────────
        Row(
          children: [
            // Indicador de barra de progreso interactiva
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: LayoutBuilder(
                  builder: (context, box) {
                    final segmentWidth = box.maxWidth / widget.items.length;
                    final leftPos = (_currentPage * segmentWidth).clamp(0.0, box.maxWidth - segmentWidth);

                    return Stack(
                      children: [
                        Positioned(
                          left: leftPos,
                          width: segmentWidth,
                          height: 4,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  activeItem.accentColor,
                                  activeItem.accentColor.withValues(alpha: 0.8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2),
                              boxShadow: [
                                BoxShadow(
                                  color: activeItem.accentColor.withValues(alpha: 0.6),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 14),
            Row(
              children: [
                Icon(
                  Icons.mouse_rounded,
                  size: 13,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
                const SizedBox(width: 5),
                Text(
                  'Usa la rueda o arrastra para rotar',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ── TARJETA 3D CON TRANSFORMACIÓN GEOMÉTRICA (VERTEX & FRAGMENT FX) ─────────
class _Shader3DCard extends StatefulWidget {
  final ShaderGalleryItem item;
  final double distanceFromCenter;
  final bool isActive;
  final Animation<double> scanlineAnimation;

  const _Shader3DCard({
    required this.item,
    required this.distanceFromCenter,
    required this.isActive,
    required this.scanlineAnimation,
  });

  @override
  State<_Shader3DCard> createState() => _Shader3DCardState();
}

class _Shader3DCardState extends State<_Shader3DCard> {
  Offset _pointerPos = Offset.zero;
  bool _isHovered = false;

  void _onHover(PointerHoverEvent event, Size size) {
    if (size.width == 0 || size.height == 0) return;
    setState(() {
      // Normalizado de -1.0 a 1.0 desde el centro de la tarjeta
      _pointerPos = Offset(
        (event.localPosition.dx / size.width) * 2 - 1,
        (event.localPosition.dy / size.height) * 2 - 1,
      );
      _isHovered = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _pointerPos = Offset.zero;
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dist = widget.distanceFromCenter;
    final absDist = dist.abs().clamp(0.0, 1.2);

    // 1. VERTEX SHADER SIMULATION:
    // - Curvatura cilíndrica horizontal (rotateY)
    // - Escala de proximidad al centro (scale)
    // - Profundidad en el eje Z (translateZ)
    final rotationY = -dist * 0.28;
    final scale = (1.0 - (absDist * 0.14)).clamp(0.84, 1.0);
    final translateZ = -absDist * 80;

    // Inclinación adicional por puntero (Mouse Interactive Tilt)
    final pointerTiltX = _isHovered ? -_pointerPos.dy * 0.10 : 0.0;
    final pointerTiltY = _isHovered ? _pointerPos.dx * 0.10 : 0.0;

    // Matriz de proyección en perspectiva 3D (Three.js PlaneGeometry feel)
    final matrix = Matrix4.identity()
      ..setEntry(3, 2, 0.0012) // Perspectiva de profundidad de cámara
      ..multiply(Matrix4.translationValues(0.0, 0.0, translateZ))
      ..multiply(Matrix4.diagonal3Values(scale, scale, 1.0))
      ..rotateY(rotationY + pointerTiltY)
      ..rotateX(pointerTiltX);

    // 2. PARALLAX OFFSET de la fotografía de fondo (movimiento opuesto)
    final parallaxOffset = -dist * 35;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Transform(
        transform: matrix,
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return MouseRegion(
              onHover: (e) => _onHover(e, constraints.biggest),
              onExit: _onExit,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: _isHovered
                        ? widget.item.accentColor.withValues(alpha: 0.8)
                        : widget.isActive
                            ? widget.item.accentColor.withValues(alpha: 0.45)
                            : Colors.white.withValues(alpha: 0.12),
                    width: _isHovered ? 1.8 : 1.2,
                  ),
                  boxShadow: [
                    // Brillo RGB de profundidad
                    if (widget.isActive || _isHovered) ...[
                      BoxShadow(
                        color: widget.item.accentColor
                            .withValues(alpha: _isHovered ? 0.35 : 0.2),
                        blurRadius: 28,
                        offset: const Offset(0, 10),
                      ),
                      BoxShadow(
                        color: const Color(0xFF00E5FF).withValues(alpha: 0.12),
                        blurRadius: 18,
                        offset: Offset(dist * 6, 0),
                      ),
                    ],
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.6),
                      blurRadius: 22,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(23),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // ── 3. FOTOGRAFÍA DE FONDO CON PARALLAX ─────────────────
                      Positioned.fill(
                        child: Transform.translate(
                          offset: Offset(parallaxOffset, 0),
                          child: Transform.scale(
                            scale: 1.18,
                            child: Image.asset(
                              widget.item.image,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),

                      // ── 4. FRAGMENT SHADER: CHROMATIC ABERRATION & GRASS MESH
                      if (_isHovered || absDist > 0.1)
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _ChromaticAberrationPainter(
                              intensity: _isHovered ? 0.85 : (absDist * 0.5),
                              accentColor: widget.item.accentColor,
                            ),
                          ),
                        ),

                      // ── 5. DEGRADADO CINEMATOGRÁFICO DE LECTURA ─────────────
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.4, 0.75, 1.0],
                            colors: [
                              Colors.black.withValues(alpha: 0.35),
                              Colors.black.withValues(alpha: 0.5),
                              Colors.black.withValues(alpha: 0.90),
                              const Color(0xFF070B14).withValues(alpha: 0.98),
                            ],
                          ),
                        ),
                      ),

                      // ── 6. LUZ ESPECULAR DEL CURSOR (SPECULAR HIGHLIGHT) ────
                      if (_isHovered)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                center: Alignment(
                                  _pointerPos.dx,
                                  _pointerPos.dy,
                                ),
                                radius: 0.85,
                                colors: [
                                  widget.item.accentColor
                                      .withValues(alpha: 0.25),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),

                      // ── 7. HUD CORNER RETICLES (Shader Cyber Accents) ──────
                      Positioned(
                        top: 10,
                        right: 12,
                        child: Text(
                          '${(scale * 100).toInt()}% 3D · ${widget.item.id.toUpperCase()}',
                          style: TextStyle(
                            color: widget.item.accentColor.withValues(alpha: 0.75),
                            fontSize: 8.5,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'monospace',
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),

                      // ── 8. CONTENIDO DE LA TARJETA (HEADER + SPECS + CTA) ──
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Cabecera: Ícono + Badge
                            Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: widget.item.accentColor
                                        .withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: widget.item.accentColor
                                          .withValues(alpha: 0.5),
                                      width: 1.2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: widget.item.accentColor
                                            .withValues(alpha: 0.3),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    widget.item.icon,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.item.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: widget.item.badgeColor
                                              .withValues(alpha: 0.18),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                            color: widget.item.badgeColor
                                                .withValues(alpha: 0.35),
                                          ),
                                        ),
                                        child: Text(
                                          widget.item.badge,
                                          style: TextStyle(
                                            color: widget.item.badgeColor,
                                            fontSize: 8.5,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 0.6,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const Spacer(),

                            // Chip del formato (.APK, .EXE, .DMG)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.12),
                                ),
                              ),
                              child: Text(
                                widget.item.format,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),

                            const SizedBox(height: 6),

                            // Descripción
                            Text(
                              widget.item.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 12,
                                height: 1.3,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Bullets de especificaciones técnicas
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.item.specs.map((spec) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_rounded,
                                        size: 12,
                                        color: widget.item.accentColor,
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          spec,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 10.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 12),

                            // ── BOTÓN DE DESCARGA DIRECTA (CTA SHADER GLOW) ──
                            Container(
                              width: double.infinity,
                              height: 38,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    widget.item.accentColor,
                                    widget.item.accentColor
                                        .withValues(alpha: 0.85),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(11),
                                boxShadow: [
                                  BoxShadow(
                                    color: widget.item.accentColor
                                        .withValues(alpha: 0.45),
                                    blurRadius: 12,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: widget.item.onDownload,
                                  borderRadius: BorderRadius.circular(11),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.download_rounded,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          widget.item.buttonLabel,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w900,
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
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ── SIMULADOR DE ABERRACIÓN CROMÁTICA (FRAGMENT SHADER RGB SHIFT) ────────────
class _ChromaticAberrationPainter extends CustomPainter {
  final double intensity;
  final Color accentColor;

  _ChromaticAberrationPainter({
    required this.intensity,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (intensity <= 0.05) return;

    final redPaint = Paint()
      ..color = const Color(0xFFFF0055).withValues(alpha: 0.12 * intensity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final cyanPaint = Paint()
      ..color = const Color(0xFF00F0FF).withValues(alpha: 0.14 * intensity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final offsetAmount = 2.5 * intensity;

    // Desplazamiento del canal rojo (hacia la izquierda/arriba)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          -offsetAmount,
          -offsetAmount,
          size.width + offsetAmount,
          size.height + offsetAmount,
        ),
        const Radius.circular(23),
      ),
      redPaint,
    );

    // Desplazamiento del canal cian (hacia la derecha/abajo)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          offsetAmount,
          offsetAmount,
          size.width - offsetAmount,
          size.height - offsetAmount,
        ),
        const Radius.circular(23),
      ),
      cyanPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ChromaticAberrationPainter oldDelegate) {
    return oldDelegate.intensity != intensity || oldDelegate.accentColor != accentColor;
  }
}

// ── BOTÓN CIRCULAR DE NAVEGACIÓN ────────────────────────────────────────────
class _NavCircleButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _NavCircleButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: enabled
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.white.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: enabled
                  ? Colors.white.withValues(alpha: 0.18)
                  : Colors.white.withValues(alpha: 0.04),
            ),
          ),
          child: Icon(
            icon,
            size: 18,
            color: enabled ? Colors.white : Colors.white24,
          ),
        ),
      ),
    );
  }
}

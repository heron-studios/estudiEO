import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:learn/core/config/neural_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  HoverGlassCard — tarjeta glassmorphism con hover animado
//
//  • Glassmorphism: opacidad de superficie 40%–60% (según NeuralThemeData)
//  • Borde: 1px rgba(255,255,255,0.10) → rgba(255,255,255,0.22) en hover
//  • Escala: 1.0 → 1.018 en hover (micro-animación anti-rebuild)
//  • MouseRegion usa SystemMouseCursors.click
//  • Toda la animación vive en este widget; NO propaga rebuilds al padre.
//  • blur: parámetro opcional (por defecto 14). Evitar > 20 en grids densos.
// ─────────────────────────────────────────────────────────────────────────────
class HoverGlassCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius borderRadius;
  final double blur;

  /// Si [hoverGradientBorder] es true, el borde en hover transiciona al
  /// gradiente neural del tema en lugar del blanco puro.
  final bool hoverGradientBorder;

  const HoverGlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.blur = 14.0,
    this.hoverGradientBorder = false,
  });

  @override
  State<HoverGlassCard> createState() => _HoverGlassCardState();
}

class _HoverGlassCardState extends State<HoverGlassCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _hoverT;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.018).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
    _hoverT = _ctrl; // alias semántico
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onEnter(_) => _ctrl.forward();
  void _onExit(_) => _ctrl.reverse();

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _ctrl,
          // builder sólo reconstruye ESTE widget, no el árbol padre
          builder: (_, child) {
            final t = _hoverT.value;
            final borderColor = Color.lerp(
              nt.borderSubtle,
              nt.borderHover,
              t,
            )!;
            final surfaceOpacity = ui.lerpDouble(
              nt.cardOpacityMin,
              nt.cardOpacityMax,
              t,
            )!;

              // Ahora que usamos CanvasKit en web, podemos permitir un poco más de blur sin lag,
              // aunque lo limitamos a 12.0 para mantener un rendimiento seguro en dispositivos móviles web.
              final double effectiveBlur = kIsWeb ? (widget.blur > 12.0 ? 12.0 : widget.blur) : widget.blur;

              return Transform.scale(
                scale: _scale.value,
                child: ClipRRect(
                  borderRadius: widget.borderRadius,
                  child: effectiveBlur > 0 
                      ? BackdropFilter(
                          filter: ui.ImageFilter.blur(
                            sigmaX: effectiveBlur,
                            sigmaY: effectiveBlur,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: nt.surfaceCard.withValues(alpha: surfaceOpacity),
                              borderRadius: widget.borderRadius,
                              border: Border.all(color: borderColor, width: 1.0),
                            ),
                            child: child,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: nt.surfaceCard.withValues(alpha: surfaceOpacity),
                            borderRadius: widget.borderRadius,
                            border: Border.all(color: borderColor, width: 1.0),
                          ),
                          child: child,
                        ),
                ),
              );
            },
            child: widget.child, // estático — no se reconstruye en la animación
          ),
        ),
      );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  StaticGlassContainer — versión sin hover para listas de datos (ej. stats)
//  Más barato: sin AnimationController ni MouseRegion.
// ─────────────────────────────────────────────────────────────────────────────
class StaticGlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final double blur;
  final double? opacity;

  const StaticGlassContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.blur = 15.0,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    final effectiveOpacity = opacity ?? nt.cardOpacityMax;
    final double effectiveBlur = kIsWeb ? (blur > 12.0 ? 12.0 : blur) : blur;

    Widget container = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: nt.surfaceCard.withValues(alpha: effectiveOpacity),
        borderRadius: borderRadius,
        border: Border.all(color: nt.borderSubtle, width: 1.0),
      ),
      child: child,
    );

    return ClipRRect(
      borderRadius: borderRadius,
      child: effectiveBlur > 0
          ? BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: effectiveBlur, sigmaY: effectiveBlur),
              child: container,
            )
          : container,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  PsicoLearnSvgContainer — contenedor estandarizado para gráficos SVG
//  del módulo psicotécnico.
//
//  Protocolo de acoplamiento SVG:
//  • AspectRatio fijo 1:1 (cuadrado) para matrices y rotaciones.
//  • ConstrainedBox con maxWidth: 320, maxHeight: 320 (canvas estándar).
//  • El color de stroke hereda [NeuralThemeData.textSecondary] (#C4C7C5)
//    o reacciona al borde del contenedor mediante [accentColor].
//  • El child recibe el Color del accent para que el SVG pueda pintarlo.
//  • Nunca aplica BackdropFilter interno (el SVG ya es vectorial limpio).
// ─────────────────────────────────────────────────────────────────────────────
class PsicoLearnSvgContainer extends StatelessWidget {
  /// Widget SVG (e.g. SvgPicture.asset o un CustomPainter).
  final Widget svgChild;

  /// Color del trazo SVG. Si null, usa [NeuralThemeData.textSecondary].
  final Color? strokeColor;

  /// Grosor estándar del trazo SVG del sistema psicoLearn.
  static const double standardStrokeWidth = 1.5;

  /// Canvas estándar en dp (máximo del sistema psicoLearn).
  static const double canvasSize = 320.0;

  const PsicoLearnSvgContainer({
    super.key,
    required this.svgChild,
    this.strokeColor,
  });

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    final effectiveStroke = strokeColor ?? nt.textSecondary;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: canvasSize,
          maxHeight: canvasSize,
        ),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            decoration: BoxDecoration(
              color: nt.surfaceCard.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                // El borde "reacciona a la luz" con el color del trazo
                color: effectiveStroke.withValues(alpha: 0.20),
                width: 1.0,
              ),
            ),
            padding: const EdgeInsets.all(16),
            // Pasa el strokeColor al descendiente mediante InheritedTheme
            // (el widget SVG debe leer DefaultTextStyle o IconTheme para el color)
            child: IconTheme(
              data: IconThemeData(color: effectiveStroke),
              child: DefaultTextStyle(
                style: TextStyle(
                  color: effectiveStroke,
                  fontSize: PsicoLearnSvgContainer.standardStrokeWidth,
                ),
                child: svgChild,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

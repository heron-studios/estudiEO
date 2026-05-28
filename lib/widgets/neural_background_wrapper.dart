import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:learn/config/neural_design_system.dart';

/// Wrapper de Fondo Neural animado e inmersivo.
/// Renderiza manchas de luz difuminadas con un blur extremo y un movimiento lento
/// de respiración y cambio de opacidad.
class NeuralBackgroundWrapper extends StatefulWidget {
  final Widget child;

  const NeuralBackgroundWrapper({super.key, required this.child});

  @override
  State<NeuralBackgroundWrapper> createState() => _NeuralBackgroundWrapperState();
}

class _NeuralBackgroundWrapperState extends State<NeuralBackgroundWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Fondo base de color místico oscuro
        Container(color: NeuralDesignSystem.background),

        // Blobs de luz neural con desenfoque extremo
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final scale = _animation.value;
            return Stack(
              fit: StackFit.expand,
              children: [
                // Blob Azul
                Positioned(
                  top: -80 * scale,
                  left: -50 * scale,
                  child: Container(
                    width: 350 * scale,
                    height: 350 * scale,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: NeuralDesignSystem.blueGoogle.withValues(alpha: 0.18),
                    ),
                  ),
                ),
                // Blob Morado
                Positioned(
                  top: 250 * scale,
                  right: -100 * scale,
                  child: Container(
                    width: 400 * scale,
                    height: 400 * scale,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: NeuralDesignSystem.purple.withValues(alpha: 0.15),
                    ),
                  ),
                ),
                // Blob Rosa
                Positioned(
                  bottom: -100 * scale,
                  left: 100 * scale,
                  child: Container(
                    width: 380 * scale,
                    height: 380 * scale,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: NeuralDesignSystem.pink.withValues(alpha: 0.12),
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        // Capa de desenfoque de fondo masivo para fusionar los blobs de luz
        Positioned.fill(
          child: IgnorePointer(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 110, sigmaY: 110),
              child: const SizedBox.shrink(),
            ),
          ),
        ),

        // Capa sutil de ruido visual u opacidad para unificar
        Container(
          color: Colors.black.withValues(alpha: 0.05),
        ),

        // Contenido encima
        widget.child,
      ],
    );
  }
}

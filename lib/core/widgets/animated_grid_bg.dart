import 'package:flutter/material.dart';

/// Static panoramic background with fisheye-like distortion overlay.
/// Replaces the old animated grid lines with the EO PNP school image.
class AnimatedGridBackground extends StatelessWidget {
  final Widget child;

  const AnimatedGridBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image (Static for performance optimization)
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(1.15, 1.15, 1.0)
            ..setEntry(3, 2, 0.001), // perspective
          child: Image.asset(
            'assets/images/bg_escuela.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),

        // Fisheye-style radial vignette + color tint overlay
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 0.85,
              colors: [
                const Color(0xFF0F172A).withValues(alpha: 0.55),
                const Color(0xFF0F172A).withValues(alpha: 0.75),
                const Color(0xFF0F172A).withValues(alpha: 0.92),
              ],
              stops: const [0.0, 0.6, 1.0],
            ),
          ),
        ),

        // Top + bottom fade bars for clean edges
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF0F172A).withValues(alpha: 0.8),
                Colors.transparent,
                Colors.transparent,
                const Color(0xFF0F172A).withValues(alpha: 0.9),
              ],
              stops: const [0.0, 0.15, 0.85, 1.0],
            ),
          ),
        ),

        // Child content on top
        child,
      ],
    );
  }
}

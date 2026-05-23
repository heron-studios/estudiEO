import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Rotating panoramic background with fisheye-like distortion overlay.
/// Replaces the old animated grid lines with the EO PNP school image.
class AnimatedGridBackground extends StatefulWidget {
  final Widget child;
  const AnimatedGridBackground({super.key, required this.child});

  @override
  State<AnimatedGridBackground> createState() => _AnimatedGridBackgroundState();
}

class _AnimatedGridBackgroundState extends State<AnimatedGridBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
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
        // Background image that scrolls horizontally
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // Pan the image horizontally — a gentle left-right sweep
            final sweep = math.sin(_controller.value * 2 * math.pi);
            // Slight scale pulse for dynamism
            final scale = 1.15 + 0.05 * math.sin(_controller.value * 4 * math.pi);

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..scale(scale)
                ..translate(sweep * 40, 0.0),
              child: child,
            );
          },
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
        widget.child,
      ],
    );
  }
}

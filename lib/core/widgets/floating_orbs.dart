import 'dart:math' as math;
import 'package:flutter/material.dart';

class FloatingOrbs extends StatelessWidget {
  final Animation<double> orbAnimation;
  const FloatingOrbs({super.key, required this.orbAnimation});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: orbAnimation,
      builder: (context, _) {
        final double val = orbAnimation.value;
        final double t = val * 2 * math.pi;

        // Orb 1: Blue, top: -80, left: -60 (period: 8s)
        final double t1 = t * (60.0 / 8.0);
        final double dx1 = 12.0 * math.sin(t1);
        final double dy1 = -18.0 * math.cos(t1);
        final double scale1 = 1.0 + 0.05 * math.sin(t1);

        // Orb 2: Purple, bottom: 20, right: 80 (period: 11s, reverse)
        final double t2 = -t * (60.0 / 11.0);
        final double dx2 = 12.0 * math.sin(t2);
        final double dy2 = -18.0 * math.cos(t2);
        final double scale2 = 1.0 + 0.05 * math.sin(t2);

        // Orb 3: Pink, top: 40%, left: 45% (period: 9s, offset 2s phase)
        final double t3 = (t - (2.0 / 60.0) * 2 * math.pi) * (60.0 / 9.0);
        final double dx3 = 12.0 * math.sin(t3);
        final double dy3 = -18.0 * math.cos(t3);
        final double scale3 = 1.0 + 0.05 * math.sin(t3);

        return Stack(
          children: [
            Positioned(
              top: -80 + dy1,
              left: -60 + dx1,
              child: Transform.scale(
                scale: scale1,
                child: const _Orb(
                  size: 280,
                  color: Color(0xFF4285F4),
                  opacity: 0.07,
                ),
              ),
            ),
            Positioned(
              bottom: 20 + dy2,
              right: 80 + dx2,
              child: Transform.scale(
                scale: scale2,
                child: const _Orb(
                  size: 200,
                  color: Color(0xFF9C27B0),
                  opacity: 0.08,
                ),
              ),
            ),
            Positioned(
              top: (screenSize.height * 0.4) + dy3,
              left: (screenSize.width * 0.45) + dx3,
              child: Transform.scale(
                scale: scale3,
                child: const _Orb(
                  size: 160,
                  color: Color(0xFFF472B6),
                  opacity: 0.06,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Orb extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;
  const _Orb({required this.size, required this.color, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: opacity),
            color.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 0.7],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BentoCard extends StatefulWidget {
  final String title;
  final String description;
  final String tag;
  final IconData icon;
  final Color glowColor;
  final Color iconColor;
  final Color iconBgColor;
  final double shimmerPhase;
  final Animation<double> shimmerAnimation;

  const BentoCard({
    super.key,
    required this.title,
    required this.description,
    required this.tag,
    required this.icon,
    required this.glowColor,
    required this.iconColor,
    required this.iconBgColor,
    required this.shimmerPhase,
    required this.shimmerAnimation,
  });

  @override
  State<BentoCard> createState() => _BentoCardState();
}

class _BentoCardState extends State<BentoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(0.0, _isHovered ? -2.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: _isHovered ? 0.07 : 0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: _isHovered ? 0.15 : 0.08),
            width: 1.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Radial Glow on hover
              if (_isHovered)
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          widget.glowColor,
                          Colors.transparent,
                        ],
                        center: const Alignment(-0.6, -0.4),
                        radius: 0.8,
                      ),
                    ),
                  ),
                ),
              
              // Shimmer overlay
              Positioned.fill(
                child: RepaintBoundary(
                  child: AnimatedBuilder(
                    animation: widget.shimmerAnimation,
                    builder: (context, _) {
                      final double t = widget.shimmerAnimation.value;
                      final double localT = (t - widget.shimmerPhase) % 1.0;
                      double sweepPos;
                      if (localT < 0.5) {
                        sweepPos = -1.0 + (localT / 0.5) * 2.2;
                      } else {
                        sweepPos = 1.2 - ((localT - 0.5) / 0.5) * 2.2;
                      }
                      
                      return FractionallySizedBox(
                        widthFactor: 0.6,
                        alignment: Alignment(sweepPos, 0.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.white10,
                                Colors.transparent,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: widget.iconBgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        widget.icon,
                        color: widget.iconColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Color(0xFFE8EAED),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          widget.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF9AA0A6),
                            fontSize: 12,
                            height: 1.55,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.07),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.tag,
                        style: const TextStyle(
                          color: Color(0xFF9AA0A6),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
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
  }
}

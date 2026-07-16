import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:learn/core/config/neural_design_system.dart';

/// Un widget interactivo que oculta la respuesta y requiere una acción del
/// usuario (tap, swipe o long-press) para desplegarla de manera fluida y expansiva,
/// con un sutil brillo del gradiente neural de realimentación.
class RevealAnswerCard extends StatefulWidget {
  final Widget question;
  final Widget answer;
  final String instruction;

  const RevealAnswerCard({
    super.key,
    required this.question,
    required this.answer,
    this.instruction = 'Mantén presionado para revelar',
  });

  @override
  State<RevealAnswerCard> createState() => _RevealAnswerCardState();
}

class _RevealAnswerCardState extends State<RevealAnswerCard>
    with SingleTickerProviderStateMixin {
  bool _isRevealed = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Cubic(0.2, 0.8, 0.2, 1.0), // cubic-bezier fluido
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _reveal() {
    if (_isRevealed) return;
    setState(() {
      _isRevealed = true;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: NeuralDesignSystem.surfaceCard.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Color.lerp(
                Colors.white.withValues(alpha: 0.1),
                NeuralDesignSystem.purple.withValues(alpha: 0.5),
                _glowAnimation.value,
              )!,
              width: 1 + _glowAnimation.value * 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Color.lerp(
                  Colors.black.withValues(alpha: 0.2),
                  NeuralDesignSystem.purple.withValues(alpha: 0.15),
                  _glowAnimation.value,
                )!,
                blurRadius: 16 + _glowAnimation.value * 14,
                spreadRadius: _glowAnimation.value * 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Pregunta
                    widget.question,
                    const SizedBox(height: 12),

                    // Lógica del gatillo de revelación
                    if (!_isRevealed)
                      GestureDetector(
                        onLongPress: _reveal,
                        onTap:
                            _reveal, // También permitimos tap simple para accesibilidad
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.visibility_rounded,
                                color: NeuralDesignSystem.purple,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.instruction,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: NeuralDesignSystem.textPrimaryAlt,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      SizeTransition(
                        sizeFactor: _expandAnimation,
                        alignment: const Alignment(-1.0, -1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(color: Colors.white10, height: 24),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    NeuralDesignSystem.blueGoogle.withValues(
                                      alpha: 0.05,
                                    ),
                                    NeuralDesignSystem.purple.withValues(
                                      alpha: 0.05,
                                    ),
                                  ],
                                ),
                                border: Border.all(
                                  color: NeuralDesignSystem.purple.withValues(
                                    alpha: 0.25,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: widget.answer,
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
      },
    );
  }
}

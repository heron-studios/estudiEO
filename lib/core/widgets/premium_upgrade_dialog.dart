import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PremiumUpgradeDialog extends StatefulWidget {
  final String title;
  final String message;

  const PremiumUpgradeDialog({
    super.key,
    this.title = 'Contenido Premium',
    this.message =
        'Actualiza tu cuenta a Premium para desbloquear el acceso completo a esta funcionalidad y llevar tu preparación al máximo nivel.',
  });

  static void show(BuildContext context, {String? title, String? message}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withValues(alpha: 0.6),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) => PremiumUpgradeDialog(
        title: title ?? 'Contenido Premium',
        message:
            message ??
            'Actualiza tu cuenta a Premium para desbloquear el acceso completo a esta funcionalidad y llevar tu preparación al máximo nivel.',
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
          child: FadeTransition(opacity: anim1, child: child),
        );
      },
    );
  }

  @override
  State<PremiumUpgradeDialog> createState() => _PremiumUpgradeDialogState();
}

class _PremiumUpgradeDialogState extends State<PremiumUpgradeDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.all(36),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A).withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: const Color(
                  0xFFFFD700,
                ).withValues(alpha: 0.4), // Borde dorado
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFD700).withValues(alpha: 0.15),
                  blurRadius: 50,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ícono animado
                AnimatedBuilder(
                  animation: _pulseAnim,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnim.value,
                      child: Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFDF00), Color(0xFFFF9500)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFFFFD700,
                              ).withValues(alpha: 0.5),
                              blurRadius: 25,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.workspace_premium_rounded,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 28),

                // Título
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    fontFamily: 'Outfit',
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Mensaje
                Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 36),

                // Botón principal
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF7C3AED)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.push('/premium');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'CONSEGUIR PREMIUM',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Botón secundario
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Quizás más tarde',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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

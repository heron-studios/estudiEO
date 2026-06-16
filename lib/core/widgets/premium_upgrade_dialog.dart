import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';

class PremiumUpgradeDialog extends StatelessWidget {
  final String title;
  final String message;

  const PremiumUpgradeDialog({
    super.key,
    this.title = 'Contenido Premium',
    this.message = 'Actualiza tu cuenta a Premium para desbloquear el acceso completo a esta funcionalidad y llevar tu preparación al máximo nivel.',
  });

  static void show(BuildContext context, {String? title, String? message}) {
    showDialog(
      context: context,
      builder: (context) => PremiumUpgradeDialog(
        title: title ?? 'Contenido Premium',
        message: message ?? 'Actualiza tu cuenta a Premium para desbloquear el acceso completo a esta funcionalidad y llevar tu preparación al máximo nivel.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: nt.surfaceCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: nt.pink.withValues(alpha: 0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: nt.pink.withValues(alpha: 0.2),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [nt.pink, nt.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(
                Icons.star_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 18,
                fontFamily: 'Outfit',
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.push('/premium');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: nt.pink,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  shadowColor: nt.pink.withValues(alpha: 0.5),
                ),
                child: const Text(
                  'ACTUALIZAR A PREMIUM',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white60,
              ),
              child: const Text('Más tarde'),
            ),
          ],
        ),
      ),
    );
  }
}

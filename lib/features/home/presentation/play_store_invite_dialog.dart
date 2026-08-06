import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

class PlayStoreInviteDialog extends StatefulWidget {
  const PlayStoreInviteDialog({super.key});

  @override
  State<PlayStoreInviteDialog> createState() => _PlayStoreInviteDialogState();
}

class _PlayStoreInviteDialogState extends State<PlayStoreInviteDialog> {
  bool _doNotShowAgain = false;

  void _close() {
    if (_doNotShowAgain) {
      context.read<LocalStorageService>().saveHasSeenPlayStoreInvite(true);
    }
    Navigator.of(context).pop();
  }

  Future<void> _openWhatsApp() async {
    final auth = context.read<AuthService>();
    final email = auth.currentUser?.email ?? "[Escribe tu correo aquí]";
    final message = "$email quiero ser de los primeros en probar el app";
    final url = Uri.parse("https://wa.me/51955285763?text=${Uri.encodeComponent(message)}");
    
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
    
    // Auto-close after launching WA
    if (mounted) {
      _close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 20,
      backgroundColor: theme.colorScheme.surface,
      child: Container(
        padding: const EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(isDark ? 0.05 : 0.1),
              blurRadius: 30,
              spreadRadius: 5,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.android_rounded,
                size: 56,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 24),
            
            // Title
            Text(
              '¡EDUPOL muy pronto en la Play Store! 🎉',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            
            // Message
            Text(
              'Queremos que seas de los primeros en probar nuestra aplicación móvil. Como usuario de EDUPOL, puedes ser parte del programa de testers.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.5,
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 28),
            
            // Action button to WhatsApp
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _openWhatsApp,
                icon: const Icon(Icons.chat_rounded),
                label: const Text(
                  'Quiero ser tester (WhatsApp)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.green, // WhatsApp Color
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Secondary close button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: _close,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Quizás más tarde',
                  style: TextStyle(
                    fontSize: 15,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Checkbox for do not show again
            InkWell(
              onTap: () {
                setState(() {
                  _doNotShowAgain = !_doNotShowAgain;
                });
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: _doNotShowAgain,
                        onChanged: (value) {
                          setState(() {
                            _doNotShowAgain = value ?? false;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        activeColor: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'No volver a mostrar',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

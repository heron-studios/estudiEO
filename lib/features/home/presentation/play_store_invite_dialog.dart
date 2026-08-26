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
    final email = auth.currentUser?.email ?? '[Escribe tu correo aquí]';
    final name = auth.currentUser?.displayName ?? '[Escribe tu nombre aquí]';
    final message = '$name - $email quiero ser de los primeros en probar el app';
    final url = Uri.parse('https://wa.me/51955285763?text=${Uri.encodeComponent(message)}');
    
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surface.withValues(alpha: 0.95),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.greenAccent.withValues(alpha: 0.15),
              blurRadius: 40,
              spreadRadius: -5,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Premium Header Icon
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0072FF).withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: const Icon(
                Icons.shop_rounded,
                size: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 28),
            
            // Title
            Text(
              '¡EDUPOL en Play Store! 🎉',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            
            // Message
            Text(
              'Únete a nuestros primeros 20 Beta Testers y obtén acceso PRO de por vida totalmente gratis.\n\nEnvíanos un mensaje por WhatsApp con tu correo para asegurar tu lugar.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.6,
                fontSize: 15,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 32),
            
            // Primary Action button to WhatsApp
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _openWhatsApp,
                icon: const Icon(Icons.star_rounded, color: Colors.amberAccent),
                label: const Text(
                  'Solicitar acceso PRO',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366), // WhatsApp Color
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  shadowColor: const Color(0xFF25D366).withValues(alpha: 0.5),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            const SizedBox(height: 16),
            
            // Close button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: _close,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Quizás más tarde',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Checkbox for do not show again
            InkWell(
              onTap: () {
                setState(() {
                  _doNotShowAgain = !_doNotShowAgain;
                });
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Checkbox(
                        value: _doNotShowAgain,
                        onChanged: (value) {
                          setState(() {
                            _doNotShowAgain = value ?? false;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        activeColor: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'No volver a mostrar',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        fontWeight: FontWeight.w500,
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

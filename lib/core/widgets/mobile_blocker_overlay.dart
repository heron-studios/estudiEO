import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:learn/features/auth/domain/auth_service.dart';

class MobileBlockerOverlay extends StatelessWidget {
  const MobileBlockerOverlay({super.key});

  Future<void> _openWhatsApp(BuildContext context) async {
    final auth = context.read<AuthService>();
    final email = auth.currentUser?.email ?? "[Escribe tu correo aquí]";
    final name = auth.currentUser?.displayName ?? "[Escribe tu nombre aquí]";
    final message = "$name - $email quiero ser de los primeros en probar el app";
    final url = Uri.parse("https://wa.me/51955285763?text=${Uri.encodeComponent(message)}");
    
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.desktop_windows_rounded,
                    size: 80,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Solo Disponible en Computadora',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Outfit',
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'EDUPOL Web está optimizado únicamente para pantallas grandes.\n\nSi quieres usar la versión móvil completa, ¡únete a nuestro programa de Beta Testers de la nueva App de Android!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () => _openWhatsApp(context),
                    icon: const Icon(Icons.android_rounded, color: Colors.white),
                    label: const Text(
                      'Quiero ser Beta Tester (WhatsApp)',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                      shadowColor: Colors.green.withValues(alpha: 0.5),
                    ),
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

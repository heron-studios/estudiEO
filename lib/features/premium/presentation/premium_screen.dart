import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/core/config/app_config.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  Future<void> _launchWhatsApp() async {
    final String message = Uri.encodeComponent('Hola, quiero comprar la versiÃ³n Premium de EstudiEO');
    final String urlStr = 'https://wa.me/${AppConfig.whatsappNumber}?text=$message';
    final Uri url = Uri.parse(urlStr);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch WhatsApp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const Icon(
                Icons.lock_person_rounded,
                size: 80,
                color: Color(0xFFFBBF24),
              ),
              const SizedBox(height: 24),
              const Text(
                'Â¡Desbloquea tu potencial completo, Futuro Cadete!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'EstÃ¡s usando la versiÃ³n Demo. Adquiere Premium para asegurar tu vacante.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              
              // Beneficios
              _buildBenefitRow(Icons.library_books, 'Acceso a TODAS las materias y temas'),
              const SizedBox(height: 16),
              _buildBenefitRow(Icons.quiz, 'Simulacros reales de 100 preguntas'),
              const SizedBox(height: 16),
              _buildBenefitRow(Icons.psychology, 'Algoritmo de repaso espaciado ilimitado'),
              const SizedBox(height: 16),
              _buildBenefitRow(Icons.auto_awesome, 'Miles de preguntas actualizadas (Prospecto)'),
              
              const SizedBox(height: 50),
              
              // BotÃ³n de WhatsApp
              ElevatedButton(
                onPressed: _launchWhatsApp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366), // WhatsApp Green
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.message, size: 28),
                    SizedBox(width: 12),
                    Text(
                      'Comprar VersiÃ³n Completa',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Te enviaremos a WhatsApp para gestionar tu acceso VIP mediante YAPE.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    ),
  );
}

  Widget _buildBenefitRow(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFBBF24).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFFFBBF24), size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

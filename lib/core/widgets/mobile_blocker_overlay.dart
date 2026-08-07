import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/core/config/neural_design_system.dart';

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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Warning Header
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 18),
                            const SizedBox(width: 8),
                            const Text(
                              'VERSIÓN WEB SOLO PARA PC',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Main Title
                    const Text(
                      '🎯 Asegura tu vacante en la PNP con EDUPOL RADAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Outfit',
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Intro Text
                    const Text(
                      '¿Sientes que el tiempo no te alcanza, que estudias temas que nunca vienen en el examen y que la presión te juega en contra? La mayoría de postulantes fracasa no por falta de esfuerzo, sino por estudiar a ciegas.\n\nEDUPOL RADAR no es una academia más ni un simple banco de preguntas. Es tu estratega personal diseñado exclusivamente bajo el Prospecto Oficial 2026.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Features Header
                    const Text(
                      '¿Por qué necesitas instalar la App hoy?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Feature List
                    _buildFeatureItem(
                      icon: Icons.radar_rounded,
                      color: Colors.redAccent,
                      title: 'Radar de Riesgo Diario',
                      description: 'Olvídate de no saber por dónde empezar. Cada día, la app te asigna una "Misión del Día" prioritaria con un Semáforo de Riesgo.',
                    ),
                    _buildFeatureItem(
                      icon: Icons.psychology_rounded,
                      color: Colors.blueAccent,
                      title: 'Motor Académico Inteligente',
                      description: 'Explicación técnica detallada de por qué caíste en la trampa (distractor) para que nunca vuelvas a cometer el mismo error.',
                    ),
                    _buildFeatureItem(
                      icon: Icons.loop_rounded,
                      color: Colors.greenAccent,
                      title: 'Sistema Anti-Olvido (SRS)',
                      description: 'La app calcula el momento exacto en el que estás a punto de olvidar un tema y te lo vuelve a preguntar.',
                    ),
                    _buildFeatureItem(
                      icon: Icons.timer_rounded,
                      color: Colors.orangeAccent,
                      title: 'Simulacro Dominical con Presión',
                      description: 'Mídete bajo presión, con tiempo límite y descubre tu posición en el Ranking General frente a cientos de postulantes.',
                    ),
                    _buildFeatureItem(
                      icon: Icons.bar_chart_rounded,
                      color: Colors.purpleAccent,
                      title: 'Estadísticas Quirúrgicas',
                      description: 'Conoce tu verdadero nivel. Métricas exactas de tu porcentaje de acierto por materia y subtema.',
                    ),
                    _buildFeatureItem(
                      icon: Icons.do_not_disturb_alt_rounded,
                      color: Colors.cyanAccent,
                      title: 'Diseño "Cero Distracciones"',
                      description: 'Un entorno táctico, premium, limpio y oscuro. Diseñado 100% para futuros policías que van en serio.',
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Conclusion
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                      ),
                      child: const Text(
                        '⏳ El tiempo corre en tu contra...\nCada día que pasas estudiando con métodos tradicionales, le estás regalando ventaja a tu competencia.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Bottom Action Bar
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () => _openWhatsApp(context),
                      icon: const Icon(Icons.android_rounded, color: Colors.white),
                      label: const Text(
                        '¡Descargar App en Android!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600, // Fixed color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 8,
                        shadowColor: Colors.green.shade600.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.read<AuthService>().signOut(),
                    child: const Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

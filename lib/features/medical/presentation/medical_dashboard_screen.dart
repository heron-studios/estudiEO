import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/core/widgets/premium_upgrade_dialog.dart';

class MedicalDashboardScreen extends StatelessWidget {
  const MedicalDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    final auth = context.read<AuthService>();
    final isPremium = auth.isPremium;

    return NeuralBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            'Examen Médico PNP',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(nt),
                  const SizedBox(height: 24),
                  const Text(
                    'EVALUACIÓN PSICOLÓGICA CLÍNICA',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTestCard(
                    nt: nt,
                    title: 'Test Psicológico General',
                    subtitle: '37 preguntas de despistaje y perfil conductual.',
                    icon: Icons.psychology_alt_rounded,
                    color: nt.purple,
                    badge: '10 MIN',
                    isLocked: false,
                    onTap: () => context.push('/medical/psicologico'),
                  ),
                  const SizedBox(height: 16),
                  _buildTestCard(
                    nt: nt,
                    title: 'Cuestionario de Personalidad (Eysenck)',
                    subtitle: 'Test de temperamento y rasgos de personalidad (Extroversión, Neuroticismo, Psicoticismo).',
                    icon: Icons.timer_rounded,
                    color: nt.cyan,
                    badge: '10 MIN',
                    isLocked: !isPremium,
                    onTap: !isPremium ? () => PremiumUpgradeDialog.show(context) : () => context.push('/medical/eysenck'),
                  ),
                  const SizedBox(height: 16),
                  _buildTestCard(
                    nt: nt,
                    title: 'Frases Incompletas (Sacks)',
                    subtitle: 'Área: Autoridad y Figuras Paternas. Evalúa la subordinación y valores.',
                    icon: Icons.edit_note_rounded,
                    color: nt.blueGoogle,
                    badge: 'INTERACTIVO',
                    isLocked: !isPremium,
                    onTap: !isPremium ? () => PremiumUpgradeDialog.show(context) : () => context.push('/medical/sacks'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(NeuralThemeData nt) {
    return StaticGlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      borderRadius: BorderRadius.circular(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.health_and_safety_rounded, color: nt.cyan, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Preparación Médica',
                  style: TextStyle(
                    color: nt.cyan,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Outfit',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Entrena con los cuestionarios oficiales utilizados en la evaluación de aptitud psicosomática de la PNP. Conoce tu perfil antes de la entrevista.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestCard({
    required NeuralThemeData nt,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String badge,
    required VoidCallback onTap,
    bool isLocked = false,
  }) {
    return HoverGlassCard(
      onTap: onTap,
      hoverGradientBorder: true,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          badge,
                          style: TextStyle(
                            color: color,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(isLocked ? Icons.lock_rounded : Icons.arrow_forward_ios_rounded, color: Colors.white54, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}

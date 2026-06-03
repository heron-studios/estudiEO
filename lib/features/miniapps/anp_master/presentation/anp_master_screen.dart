import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';

class ANPMasterScreen extends StatelessWidget {
  const ANPMasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return Scaffold(
      backgroundColor: nt.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'ANP Master PerÃº',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Domina nuestra Biodiversidad',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'El ecosistema visual para dominar las Ãreas Naturales Protegidas usando Active Recall.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: ListView(
                    children: [
                      _buildModuleCard(
                        context: context,
                        nt: nt,
                        title: 'Mapa Interactivo Vectorial',
                        subtitle: 'Explora y ubica las ANP en el mapa del PerÃº. Modo ciego disponible.',
                        icon: Icons.map_rounded,
                        color: Colors.greenAccent,
                        route: '/miniapps/anp-master/map',
                      ),
                      const SizedBox(height: 16),
                      _buildModuleCard(
                        context: context,
                        nt: nt,
                        title: 'Flashcards de Alto Impacto',
                        subtitle: 'Tarjetas minimalistas con asociaciÃ³n visual para repaso rÃ¡pido.',
                        icon: Icons.style_rounded,
                        color: Colors.orangeAccent,
                        route: '/miniapps/anp-master/flashcards',
                      ),
                      const SizedBox(height: 16),
                      _buildModuleCard(
                        context: context,
                        nt: nt,
                        title: 'DesafÃ­o del Guardaparque',
                        subtitle: 'Quizzes cronometrados basados en RepeticiÃ³n Espaciada.',
                        icon: Icons.shield_rounded,
                        color: Colors.purpleAccent,
                        route: '/miniapps/anp-master/quiz',
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
  }

  Widget _buildModuleCard({
    required BuildContext context,
    required NeuralThemeData nt,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return HoverGlassCard(
      borderRadius: BorderRadius.circular(20),
      onTap: () => context.push(route),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white30,
            ),
          ],
        ),
      ),
    );
  }
}

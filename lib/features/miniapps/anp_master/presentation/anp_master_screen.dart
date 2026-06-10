import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
class ANPMasterScreen extends StatefulWidget {
  const ANPMasterScreen({super.key});

  @override
  State<ANPMasterScreen> createState() => _ANPMasterScreenState();
}

class _ANPMasterScreenState extends State<ANPMasterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _cardAnimations;

  // Dummy stats — in a full implementation these would come from Hive
  final int _anpsDominated = 0;
  final int _totalANPs = 16;
  final int _bestScore = 0;
  final int _streak = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _cardAnimations = List.generate(5, (i) {
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(i * 0.12, (i * 0.12) + 0.5, curve: Curves.easeOutBack),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          'ANP Master Perú',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.greenAccent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.3)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.eco_rounded, color: Colors.greenAccent, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'SINANPE',
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _buildHeroBanner(nt),
                  const SizedBox(height: 24),
                  _buildStatsRow(nt),
                  const SizedBox(height: 24),
                  Text(
                    'Módulos de Aprendizaje',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Domina cada dimensión del SINANPE',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildBentoGrid(nt),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroBanner(NeuralThemeData nt) {
    final progress = _totalANPs > 0 ? _anpsDominated / _totalANPs : 0.0;
    return AnimatedBuilder(
      animation: _cardAnimations[0],
      builder: (context, child) => Transform.translate(
        offset: Offset(0, 30 * (1 - _cardAnimations[0].value)),
        child: Opacity(opacity: _cardAnimations[0].value, child: child),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            colors: [
              nt.successGreen.withValues(alpha: 0.25),
              nt.blueGoogle.withValues(alpha: 0.15),
              nt.purple.withValues(alpha: 0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
              color: nt.successGreen.withValues(alpha: 0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: nt.successGreen.withValues(alpha: 0.1),
              blurRadius: 30,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: nt.successGreen.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: nt.successGreen.withValues(alpha: 0.3)),
                  ),
                  child: Icon(Icons.forest_rounded,
                      color: nt.successGreen, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Domina nuestra Biodiversidad',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$_totalANPs ANPs · 4 categorías de protección',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.55),
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Progress bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progreso Global',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '$_anpsDominated/$_totalANPs ANPs',
                  style: TextStyle(
                      color: nt.successGreen,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                height: 8,
                child: Stack(
                  children: [
                    Container(color: Colors.white.withValues(alpha: 0.08)),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      width: (MediaQuery.of(context).size.width - 88) *
                          progress,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [nt.successGreen, nt.blueGoogle],
                        ),
                        borderRadius: BorderRadius.circular(6),
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

  Widget _buildStatsRow(NeuralThemeData nt) {
    return AnimatedBuilder(
      animation: _cardAnimations[1],
      builder: (context, child) => Transform.translate(
        offset: Offset(0, 20 * (1 - _cardAnimations[1].value)),
        child: Opacity(opacity: _cardAnimations[1].value, child: child),
      ),
      child: Row(
        children: [
          Expanded(
              child: _buildStatCard(
                  'Mejor Score', '$_bestScore pts', Icons.emoji_events_rounded,
                  nt.warningAmber, nt)),
          const SizedBox(width: 12),
          Expanded(
              child: _buildStatCard(
                  'Racha', '$_streak días', Icons.local_fire_department_rounded,
                  nt.pink, nt)),
          const SizedBox(width: 12),
          Expanded(
              child: _buildStatCard(
                  'ANPs', '$_anpsDominated', Icons.park_rounded,
                  nt.successGreen, nt)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color,
      NeuralThemeData nt) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.45), fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBentoGrid(NeuralThemeData nt) {
    return Column(
      children: [
        // Card 1 — Wide: Mapa Interactivo
        _buildAnimatedCard(
          animIndex: 2,
          child: _buildWideCard(
            context: context,
            nt: nt,
            title: 'Mapa Interactivo Vectorial',
            subtitle:
                'Explora las 16 ANPs sobre el mapa del Perú. Modo Ciego para desafíos de ubicación.',
            icon: Icons.map_rounded,
            color: nt.successGreen,
            route: '/miniapps/anp-master/map',
            badge: '16 ANPs',
            badgeIcon: Icons.location_on_rounded,
          ),
        ),
        const SizedBox(height: 14),

        // Row: Flashcards + Quiz
        Row(
          children: [
            Expanded(
              child: _buildAnimatedCard(
                animIndex: 3,
                child: _buildSquareCard(
                  context: context,
                  nt: nt,
                  title: 'Repaso SM-2',
                  subtitle: 'Repetición espaciada inteligente.',
                  icon: Icons.style_rounded,
                  color: nt.warningAmber,
                  route: '/miniapps/anp-master/flashcards',
                  badge: 'SM-2',
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildAnimatedCard(
                animIndex: 3,
                child: _buildSquareCard(
                  context: context,
                  nt: nt,
                  title: 'Quiz Guardaparque',
                  subtitle: 'Desafío con vidas, racha y tiempo.',
                  icon: Icons.shield_rounded,
                  color: nt.purple,
                  route: '/miniapps/anp-master/quiz',
                  badge: '5 tipos',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Card 2 — Wide: Biblioteca
        _buildAnimatedCard(
          animIndex: 4,
          child: _buildWideCard(
            context: context,
            nt: nt,
            title: 'Biblioteca del SINANPE',
            subtitle:
                'Teoría legal, catálogo completo, herramientas de gestión (Plan Maestro, INDIMAPA, SMART).',
            icon: Icons.menu_book_rounded,
            color: nt.blueGoogle,
            route: '/miniapps/anp-master/library',
            badge: 'Ley N°26834',
            badgeIcon: Icons.gavel_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedCard({required int animIndex, required Widget child}) {
    final animIdx = animIndex.clamp(0, _cardAnimations.length - 1);
    return AnimatedBuilder(
      animation: _cardAnimations[animIdx],
      builder: (context, _) => Transform.translate(
        offset: Offset(0, 40 * (1 - _cardAnimations[animIdx].value)),
        child: Opacity(opacity: _cardAnimations[animIdx].value, child: child),
      ),
    );
  }

  Widget _buildWideCard({
    required BuildContext context,
    required NeuralThemeData nt,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String route,
    String? badge,
    IconData? badgeIcon,
  }) {
    return HoverGlassCard(
      borderRadius: BorderRadius.circular(24),
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: color.withValues(alpha: 0.35),
                    width: 1.5),
                boxShadow: [
                  BoxShadow(
                      color: color.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4))
                ],
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (badge != null)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (badgeIcon != null)
                                Icon(badgeIcon,
                                    color: color.withValues(alpha: 0.8),
                                    size: 10),
                              if (badgeIcon != null) const SizedBox(width: 3),
                              Text(
                                badge,
                                style: TextStyle(
                                    color: color,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (badge != null) const SizedBox(height: 6),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.55),
                      fontSize: 12,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white.withValues(alpha: 0.3),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareCard({
    required BuildContext context,
    required NeuralThemeData nt,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String route,
    String? badge,
  }) {
    return HoverGlassCard(
      borderRadius: BorderRadius.circular(24),
      onTap: () => context.push(route),
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                        color: color.withValues(alpha: 0.35), width: 1),
                    boxShadow: [
                      BoxShadow(
                          color: color.withValues(alpha: 0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white.withValues(alpha: 0.2),
                  size: 13,
                ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.45),
                fontSize: 11,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (badge != null) ...[
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                      color: color, fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

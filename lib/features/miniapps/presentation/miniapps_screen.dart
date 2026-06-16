import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/core/widgets/premium_upgrade_dialog.dart';

class MiniAppsScreen extends StatelessWidget {
  const MiniAppsScreen({super.key});

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
          'Mini Apps',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Entry animation for title and subtitle
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(-20 * (1.0 - value), 0),
                          child: Opacity(
                            opacity: value,
                            child: child,
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Herramientas Interactivas',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.95),
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Potencia tu memoria y agilidad mental con estas aplicaciones rápidas.',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    
                    // Entry animation for the cards grid
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(0, 30 * (1.0 - value)),
                          child: Opacity(
                            opacity: value,
                            child: child,
                          ),
                        );
                      },
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 600,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: MediaQuery.of(context).size.width > 900
                              ? 2.5
                              : (MediaQuery.of(context).size.width > 650 ? 2.0 : 2.2),
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          final auth = context.read<AuthService>();
                          final isPremium = auth.isPremium;
                          final isLocked = !isPremium && index != 0;

                          if (index == 0) {
                            return MiniAppCard(
                              title: 'Tabla Periódica',
                              description: 'Modo exploratorio, entrenamiento dual y supervivencia.',
                              icon: Icons.science_rounded,
                              themeColor: nt.blueGoogle,
                              isLocked: false,
                              onTap: () => context.push('/miniapps/periodic-table'),
                            );
                          } else if (index == 1) {
                            return MiniAppCard(
                              title: 'Silogismos',
                              description: 'Lógica deductiva e inferencia. Repaso de razonamiento verbal.',
                              icon: Icons.account_tree_rounded,
                              themeColor: const Color(0xFF14B8A6),
                              badgeText: 'MINIJUEGO',
                              isLocked: isLocked,
                              onTap: isLocked ? () => PremiumUpgradeDialog.show(context) : () => context.push('/miniapps/silogismos'),
                            );
                          } else if (index == 2) {
                            return MiniAppCard(
                              title: 'ANP Master',
                              description: 'Áreas Naturales Protegidas del Perú. Repaso visual activo y mapas.',
                              icon: Icons.map_rounded,
                              themeColor: const Color(0xFF4ADE80),
                              badgeText: 'BIODIVERSIDAD',
                              isLocked: isLocked,
                              onTap: isLocked ? () => PremiumUpgradeDialog.show(context) : () => context.push('/miniapps/anp-master'),
                            );
                          } else {
                            return MiniAppCard(
                              title: 'Prod. Notables',
                              description: 'Aprende de forma interactiva las fórmulas matemáticas principales.',
                              icon: Icons.calculate_rounded,
                              themeColor: Colors.orangeAccent,
                              badgeText: 'MATEMÁTICA',
                              isLocked: isLocked,
                              onTap: isLocked ? () => PremiumUpgradeDialog.show(context) : () => context.push('/miniapps/productos-notables'),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MiniAppCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color themeColor;
  final String? badgeText;
  final VoidCallback onTap;
  final bool isLocked;

  const MiniAppCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.themeColor,
    this.badgeText,
    required this.onTap,
    this.isLocked = false,
  });

  @override
  State<MiniAppCard> createState() => _MiniAppCardState();
}

class _MiniAppCardState extends State<MiniAppCard> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.025).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );
    _glow = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return MouseRegion(
      onEnter: (_) => _ctrl.forward(),
      onExit: (_) => _ctrl.reverse(),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (context, child) {
            return Transform.scale(
              scale: _scale.value,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Color.lerp(
                      nt.borderSubtle,
                      widget.themeColor.withValues(alpha: 0.6),
                      _glow.value,
                    )!,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.themeColor.withValues(alpha: 0.04 + 0.10 * _glow.value),
                      blurRadius: 24,
                      spreadRadius: 4 * _glow.value,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            widget.themeColor.withValues(alpha: 0.12 + 0.08 * _glow.value),
                            nt.surfaceCard.withValues(alpha: 0.4),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  widget.themeColor.withValues(alpha: 0.25),
                                  widget.themeColor.withValues(alpha: 0.08),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: widget.themeColor.withValues(alpha: 0.3 + 0.3 * _glow.value),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: widget.themeColor.withValues(alpha: 0.2 * _glow.value),
                                  blurRadius: 12,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                widget.icon,
                                color: widget.themeColor,
                                size: 32,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        widget.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -0.5,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (widget.badgeText != null) ...[
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: widget.themeColor.withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: widget.themeColor.withValues(alpha: 0.4),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          widget.badgeText!,
                                          style: TextStyle(
                                            color: widget.themeColor,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  widget.description,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.65),
                                    fontSize: 13,
                                    height: 1.4,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Transform.translate(
                            offset: Offset(6 * _glow.value, 0),
                            child: Icon(
                              widget.isLocked ? Icons.lock_rounded : Icons.arrow_forward_ios_rounded,
                              color: widget.isLocked 
                                  ? Colors.white54 
                                  : Color.lerp(
                                      Colors.white24,
                                      widget.themeColor,
                                      _glow.value,
                                    ),
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

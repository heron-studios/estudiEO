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
        automaticallyImplyLeading: false,
        title: const Text(
          'Interactivos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 20,
                      bottom: 110,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Entry animation for Simuladores section
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(-20 * (1.0 - value), 0),
                              child: Opacity(opacity: value, child: child),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SIMULADORES OFICIALES',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 16),
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount:
                                    MediaQuery.of(context).size.width > 600
                                    ? 3
                                    : 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio:
                                    MediaQuery.of(context).size.width > 600
                                    ? 1.0
                                    : 0.85,
                                children: [
                                  MiniAppCard(
                                    title: 'Aptitud Física',
                                    description:
                                        'Calculadora de puntos según las tablas de Anexos 05 y 06.',
                                    icon: Icons.directions_run_rounded,
                                    themeColor: const Color(0xFFF59E0B),
                                    isLocked: !context.read<AuthService>().isPremium,
                                    isSquare: true,
                                    onTap: () {
                                      if (!context.read<AuthService>().isPremium) {
                                        PremiumUpgradeDialog.show(
                                          context,
                                          title: 'Calculadoras Premium',
                                          message: 'El acceso a los simuladores oficiales de Aptitud Física y Cuadro de Mérito es exclusivo para usuarios Premium. ¡Accede por S/30 (antes S/60)!',
                                        );
                                        return;
                                      }
                                      context.push('/fitness-calculator');
                                    },
                                  ),
                                  MiniAppCard(
                                    title: 'Cuadro de Mérito',
                                    description:
                                        'Calculadora ponderada y simulador de bonificaciones.',
                                    icon: Icons.bar_chart_rounded,
                                    themeColor: const Color(0xFF6366F1),
                                    isLocked: !context.read<AuthService>().isPremium,
                                    isSquare: true,
                                    onTap: () {
                                      if (!context.read<AuthService>().isPremium) {
                                        PremiumUpgradeDialog.show(
                                          context,
                                          title: 'Calculadoras Premium',
                                          message: 'El acceso a los simuladores oficiales de Aptitud Física y Cuadro de Mérito es exclusivo para usuarios Premium. ¡Accede por S/30 (antes S/60)!',
                                        );
                                        return;
                                      }
                                      context.push('/merit-calculator');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Entry animation for Herramientas title
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(-20 * (1.0 - value), 0),
                              child: Opacity(opacity: value, child: child),
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
                              child: Opacity(opacity: value, child: child),
                            );
                          },
                          child: Column(
                            children: [
                              _buildBentoRow(
                                context,
                                [
                                  _buildAppCard(context, 0, false, 1.0),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _buildBentoRow(
                                context,
                                [
                                  _buildAppCard(context, 2, true, 1.0),
                                  _buildAppCard(context, 3, true, 1.0),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _buildBentoRow(
                                context,
                                [
                                  _buildAppCard(context, 1, false, 1.0),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _buildBentoRow(
                                context,
                                [
                                  _buildAppCard(context, 4, false, 1.0),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBentoRow(BuildContext context, List<Widget> children) {
    if (children.length == 1) {
      return children.first;
    }
    return Row(
      children: [
        Expanded(child: children[0]),
        const SizedBox(width: 16),
        Expanded(child: children[1]),
      ],
    );
  }

  Widget _buildAppCard(BuildContext context, int index, bool isSquare, double aspectRatio) {
    final auth = context.read<AuthService>();
    final isPremium = auth.isPremium;
    final isLocked = !isPremium;
    final nt = NeuralTheme.of(context);

    if (index == 0) {
      return AspectRatio(
        aspectRatio: isSquare ? aspectRatio : 2.5,
        child: MiniAppCard(
          title: 'Tabla Periódica',
          description: 'Modo exploratorio, entrenamiento dual y supervivencia.',
          icon: Icons.science_rounded,
          themeColor: nt.blueGoogle,
          badgeText: 'EXPLORADOR',
          isLocked: isLocked,
          isSquare: isSquare,
          onTap: isLocked ? () => PremiumUpgradeDialog.show(context) : () => context.push('/miniapps/periodic-table'),
        ),
      );
    } else if (index == 1) {
      return AspectRatio(
        aspectRatio: isSquare ? aspectRatio : 2.5,
        child: MiniAppCard(
          title: 'Generador Flashcards IA',
          description: 'Crea tarjetas de memoria automáticas desde cualquier texto.',
          icon: Icons.auto_awesome_rounded,
          themeColor: const Color(0xFF8B5CF6),
          badgeText: 'EXPERIMENTAL',
          isLocked: isLocked,
          isSquare: isSquare,
          onTap: isLocked ? () => PremiumUpgradeDialog.show(context) : () => context.push('/srs/generator'),
        ),
      );
    } else if (index == 2) {
      return AspectRatio(
        aspectRatio: isSquare ? aspectRatio : 1.0,
        child: MiniAppCard(
          title: 'Silogismos',
          description: 'Lógica deductiva e inferencia. Repaso de razonamiento verbal.',
          icon: Icons.account_tree_rounded,
          themeColor: const Color(0xFF14B8A6),
          badgeText: 'MINIJUEGO',
          isLocked: isLocked,
          isSquare: true, // Force square for half-width cards
          onTap: isLocked ? () => PremiumUpgradeDialog.show(context) : () => context.push('/miniapps/silogismos'),
        ),
      );
    } else if (index == 3) {
      return AspectRatio(
        aspectRatio: isSquare ? aspectRatio : 1.0,
        child: MiniAppCard(
          title: 'ANP Master',
          description: 'Áreas Naturales Protegidas del Perú. Repaso visual activo.',
          icon: Icons.map_rounded,
          themeColor: const Color(0xFF4ADE80),
          badgeText: 'BIODIVERSIDAD',
          isLocked: isLocked,
          isSquare: true,
          onTap: isLocked ? () => PremiumUpgradeDialog.show(context) : () => context.push('/miniapps/anp-master'),
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: isSquare ? aspectRatio : 2.5,
        child: MiniAppCard(
          title: 'Prod. Notables',
          description: 'Aprende de forma interactiva las fórmulas matemáticas principales.',
          icon: Icons.calculate_rounded,
          themeColor: Colors.orangeAccent,
          badgeText: 'EXPLORADOR',
          isLocked: isLocked,
          isSquare: isSquare,
          onTap: isLocked ? () => PremiumUpgradeDialog.show(context) : () => context.push('/miniapps/productos-notables'),
        ),
      );
    }
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
  final bool isSquare;
  const MiniAppCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.themeColor,
    this.badgeText,
    required this.onTap,
    this.isLocked = false,
    this.isSquare = false,
  });

  @override
  State<MiniAppCard> createState() => _MiniAppCardState();
}

class _MiniAppCardState extends State<MiniAppCard>
    with SingleTickerProviderStateMixin {
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
    _scale = Tween<double>(
      begin: 1.0,
      end: 1.025,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _glow = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
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
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (context, child) {
              return Transform.scale(
                scale: _scale.value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withValues(
                        alpha: 0.08 + 0.15 * _glow.value,
                      ),
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.themeColor.withValues(
                          alpha: 0.05 + 0.1 * _glow.value,
                        ),
                        blurRadius: 30,
                        spreadRadius: 2 * _glow.value,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(23),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: nt.surfaceCard.withValues(alpha: 0.35),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              widget.themeColor.withValues(
                                alpha: 0.12 + 0.08 * _glow.value,
                              ),
                              Colors.white.withValues(alpha: 0.02),
                            ],
                            stops: const [0.0, 1.0],
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 20,
                        ),
                        child: widget.isSquare
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: widget.themeColor.withValues(
                                        alpha: 0.1 + (0.1 * _glow.value),
                                      ),
                                      border: Border.all(
                                        color: widget.themeColor.withValues(alpha: 0.2 + (0.3 * _glow.value)),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        widget.icon,
                                        color: widget.themeColor,
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    widget.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -0.3,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (widget.badgeText != null) ...[
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: widget.themeColor.withValues(
                                          alpha: 0.15,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: widget.themeColor.withValues(
                                            alpha: 0.3,
                                          ),
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
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: Text(
                                      widget.description,
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.7,
                                        ),
                                        fontSize: 12,
                                        height: 1.35,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: widget.themeColor.withValues(
                                        alpha: 0.1 + (0.1 * _glow.value),
                                      ),
                                      border: Border.all(
                                        color: widget.themeColor.withValues(alpha: 0.2 + (0.3 * _glow.value)),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        widget.icon,
                                        color: widget.themeColor,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: -0.3,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            if (widget.badgeText != null) ...[
                                              const SizedBox(width: 10),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: widget.themeColor
                                                      .withValues(alpha: 0.15),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: widget.themeColor
                                                        .withValues(alpha: 0.3),
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
                                        const SizedBox(height: 8),
                                        Text(
                                          widget.description,
                                          style: TextStyle(
                                            color: Colors.white.withValues(
                                              alpha: 0.7,
                                            ),
                                            fontSize: 13,
                                            height: 1.4,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Transform.translate(
                                    offset: Offset(8 * _glow.value, 0),
                                    child: Icon(
                                      widget.isLocked
                                          ? Icons.lock_rounded
                                          : Icons.arrow_forward_ios_rounded,
                                      color: widget.isLocked
                                          ? Colors.white54
                                          : Color.lerp(
                                              Colors.white30,
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
      ),
    );
  }
}

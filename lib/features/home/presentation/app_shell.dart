import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/config/app_config.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/core/services/limits_service.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';

class AppShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> with TickerProviderStateMixin {
  late final AnimationController _starsLottieController;

  @override
  void initState() {
    super.initState();
    _starsLottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _starsLottieController.dispose();
    super.dispose();
  }

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  void _showInterviewSelectionModal(BuildContext context, dynamic nt) async {
    final auth = context.read<AuthService>();
    final canUseAI = await LimitsService.canUseEntrevistaIA(auth.isPremium);
    final bool aiLimitReached = !canUseAI;
    
    int horasRestantes = 0;
    if (aiLimitReached) {
      horasRestantes = await LimitsService.getHorasRestantesEntrevistaIA(auth.isPremium);
    }

    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2C),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(color: Colors.white12, width: 1),
          ),
          padding: const EdgeInsets.only(
            top: 12,
            left: 24,
            right: 24,
            bottom: 40,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Entrevista Personal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Selecciona el modo de preparación',
                style: TextStyle(color: Colors.white60, fontSize: 14),
              ),
              const SizedBox(height: 32),

              // Opción A: Quiz
              HoverGlassCard(
                onTap: () {
                  Navigator.pop(context);
                  context.push('/interview-trivia');
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.purpleAccent.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.quiz_rounded,
                          color: Colors.purpleAccent,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pon a prueba tus conocimientos',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Simula la ronda de preguntas frente al jurado.',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.white30),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Opción B: IA
              Opacity(
                opacity: aiLimitReached ? 0.5 : 1.0,
                child: HoverGlassCard(
                  onTap: aiLimitReached
                      ? null
                      : () {
                          Navigator.pop(context);
                          context.push('/entrevista-simulator');
                        },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            aiLimitReached
                                ? Icons.lock_clock
                                : Icons.smart_toy_rounded,
                            color: Colors.deepPurpleAccent,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Entrevistador Virtual (IA)',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                aiLimitReached
                                    ? 'Disponible en $horasRestantes horas.'
                                    : 'Simulador interactivo con reconocimiento de voz.',
                                style: TextStyle(
                                  color: aiLimitReached
                                      ? Colors.redAccent
                                      : Colors.white60,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.white30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _launchWhatsApp() async {
    final urlStr =
        'https://wa.me/${AppConfig.whatsappNumber}?text=${Uri.encodeComponent("Hola, necesito soporte con la plataforma EDUPOL.")}';
    final uri = Uri.parse(urlStr);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    if (!isDesktop) {
      return Scaffold(
        backgroundColor: nt.background,
        body: NeuralBackgroundWrapper(
          child: Stack(
            children: [
              // Contenido principal
              Positioned.fill(child: widget.navigationShell),

              // Navbar flotante (horizontal)
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _NavItem(
                              icon: Icons.home_rounded,
                              label: 'Inicio',
                              isSelected:
                                  widget.navigationShell.currentIndex == 0,
                              onTap: () => _goBranch(0),
                              nt: nt,
                            ),
                            const SizedBox(width: 24),
                            Transform.translate(
                              offset: const Offset(0, -8),
                              child: _NavItem(
                                isProminent: true,
                                customIcon: Transform.scale(
                                  scale: 1.6,
                                  child: SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: Lottie.asset(
                                      'assets/Sparkles Loop Loader ai.lottie',
                                      fit: BoxFit.contain,
                                      controller: _starsLottieController,
                                      onLoaded: (composition) {
                                        _starsLottieController.duration =
                                            composition.duration;
                                        _starsLottieController.repeat();
                                      },
                                    ),
                                  ),
                                ),
                                isSelected: false,
                                onTap: () =>
                                    _showInterviewSelectionModal(context, nt),
                                nt: nt,
                              ),
                            ),
                            const SizedBox(width: 24),
                            _NavItem(
                              icon: Icons.extension_rounded,
                              label: 'Interactivos',
                              isSelected:
                                  widget.navigationShell.currentIndex == 1,
                              onTap: () => _goBranch(1),
                              nt: nt,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Si estamos en Desktop / Web
    return Scaffold(
      backgroundColor: nt.background,
      body: NeuralBackgroundWrapper(
        child: Stack(
          children: [
            // Contenido principal empujado a la derecha para no solapar el sidebar
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(left: 110),
                child: widget.navigationShell,
              ),
            ),
            // Sidebar flotante
            Positioned(
              left: 16,
              top: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: nt.surfaceCard.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Opciones de navegación
                        _NavItem(
                          icon: Icons.home_rounded,
                          label: 'Inicio',
                          isSelected: widget.navigationShell.currentIndex == 0,
                          onTap: () => _goBranch(0),
                          nt: nt,
                        ),
                        const SizedBox(height: 24),
                        _NavItem(
                          isProminent: true,
                          customIcon: Transform.scale(
                            scale: 1.6,
                            child: SizedBox(
                              width: 48,
                              height: 48,
                              child: Lottie.asset(
                                'assets/Sparkles Loop Loader ai.lottie',
                                fit: BoxFit.contain,
                                controller: _starsLottieController,
                                onLoaded: (composition) {
                                  _starsLottieController.duration =
                                      composition.duration;
                                  _starsLottieController.repeat();
                                },
                              ),
                            ),
                          ),
                          isSelected: false,
                          onTap: () =>
                              _showInterviewSelectionModal(context, nt),
                          nt: nt,
                        ),
                        const SizedBox(height: 24),
                        _NavItem(
                          icon: Icons.extension_rounded,
                          label: 'Interactivos',
                          isSelected: widget.navigationShell.currentIndex == 1,
                          onTap: () => _goBranch(1),
                          nt: nt,
                        ),
                        const SizedBox(height: 16),
                        _NavItem(
                          icon: Icons.support_agent_rounded,
                          label: 'Soporte',
                          isSelected: false,
                          onTap: _launchWhatsApp,
                          nt: nt,
                        ),
                      ],
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
}

class _NavItem extends StatelessWidget {
  final IconData? icon;
  final Widget? customIcon;
  final String? label;
  final bool isSelected;
  final VoidCallback onTap;
  final NeuralThemeData nt;
  final bool isProminent;

  const _NavItem({
    this.icon,
    this.customIcon,
    this.label,
    required this.isSelected,
    required this.onTap,
    required this.nt,
    this.isProminent = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isProminent) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: 56,
          height: 56,
          child: Center(child: customIcon ?? const SizedBox()),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? nt.blueGoogle.withValues(alpha: 0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child:
                customIcon ??
                Icon(
                  icon,
                  color: isSelected ? nt.blueGoogle : Colors.white54,
                  size: 24,
                ),
          ),
          if (label != null && label!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              label!,
              style: TextStyle(
                color: isSelected ? nt.blueGoogle : Colors.white54,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/config/app_config.dart';
import 'package:provider/provider.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/core/services/bible_service.dart';

class AppShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  String? _dailyVerse;

  @override
  void initState() {
    super.initState();
    _loadDailyVerse();
  }

  Future<void> _loadDailyVerse() async {
    final verse = await BibleService.getDailyVerse();
    if (mounted) {
      setState(() {
        _dailyVerse = verse;
      });
    }
  }

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  Future<void> _launchWhatsApp() async {
    final urlStr = 'https://wa.me/${AppConfig.whatsappNumber}?text=${Uri.encodeComponent("Hola, necesito soporte con la plataforma EstudiEO.")}';
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
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: (widget.navigationShell.currentIndex == 0 && _dailyVerse != null) ? 155 : 100,
                  ),
                  child: widget.navigationShell,
                ),
              ),
              // Botón de salir flotante (arriba a la derecha)
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: nt.surfaceCard.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.logout_rounded, color: nt.pink),
                    tooltip: 'Cerrar Sesión',
                    onPressed: () async {
                      await context.read<AuthService>().signOut();
                    },
                  ),
                ),
              ),
              // Versículo flotante arriba de la barra de navegación (solo en la pantalla de Inicio)
              if (widget.navigationShell.currentIndex == 0 && _dailyVerse != null)
                Positioned(
                  left: 24,
                  right: 24,
                  bottom: 96,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.65),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        _dailyVerse!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),
                ),
              // Navbar flotante (horizontal)
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    decoration: BoxDecoration(
                      color: nt.surfaceCard.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _NavItem(
                          icon: Icons.home_rounded,
                          label: 'Inicio',
                          isSelected: widget.navigationShell.currentIndex == 0,
                          onTap: () => _goBranch(0),
                          nt: nt,
                        ),
                        const SizedBox(width: 24),
                        _NavItem(
                          icon: Icons.settings_rounded,
                          label: 'Ajustes',
                          isSelected: widget.navigationShell.currentIndex == 1,
                          onTap: () => _goBranch(1),
                          nt: nt,
                        ),
                        const SizedBox(width: 24),
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
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                    decoration: BoxDecoration(
                      color: nt.surfaceCard.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
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
                        const SizedBox(height: 16),
                        _NavItem(
                          icon: Icons.settings_rounded,
                          label: 'Ajustes',
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
                        const SizedBox(height: 24),
                        // Logout
                        IconButton(
                          icon: Icon(Icons.logout_rounded, color: nt.pink),
                          tooltip: 'Cerrar Sesión',
                          onPressed: () async {
                            await context.read<AuthService>().signOut();
                          },
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
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final NeuralThemeData nt;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.nt,
  });

  @override
  Widget build(BuildContext context) {
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
              color: isSelected ? nt.blueGoogle.withValues(alpha: 0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: isSelected ? nt.blueGoogle : Colors.white54,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? nt.blueGoogle : Colors.white54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

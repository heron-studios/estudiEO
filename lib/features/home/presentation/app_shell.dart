import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:provider/provider.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
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
                  padding: const EdgeInsets.only(bottom: 100),
                  child: navigationShell,
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
                          isSelected: navigationShell.currentIndex == 0,
                          onTap: () => _goBranch(0),
                          nt: nt,
                        ),
                        const SizedBox(width: 32),
                        _NavItem(
                          icon: Icons.settings_rounded,
                          label: 'Ajustes',
                          isSelected: navigationShell.currentIndex == 1,
                          onTap: () => _goBranch(1),
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
                child: navigationShell,
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
                          isSelected: navigationShell.currentIndex == 0,
                          onTap: () => _goBranch(0),
                          nt: nt,
                        ),
                        const SizedBox(height: 16),
                        _NavItem(
                          icon: Icons.settings_rounded,
                          label: 'Ajustes',
                          isSelected: navigationShell.currentIndex == 1,
                          onTap: () => _goBranch(1),
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

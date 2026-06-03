import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:provider/provider.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/providers/gamification_provider.dart';

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
        appBar: AppBar(
          toolbarHeight: 48,
          backgroundColor: nt.surfaceCard,
          elevation: 0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🔥', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 6),
              Consumer<GamificationProvider>(
                builder: (context, gamification, _) {
                  return Text(
                    '${gamification.streak}',
                    style: TextStyle(
                      color: nt.warningAmber,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  );
                },
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: nt.surfaceCard,
          selectedItemColor: nt.blueGoogle,
          unselectedItemColor: Colors.white54,
          currentIndex: navigationShell.currentIndex,
          onTap: _goBranch,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded), label: 'Progreso'),
            BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Ajustes'),
          ],
        ),
      );
    }

    // Si estamos en Desktop / Web
    return Scaffold(
      backgroundColor: nt.background,
      body: Row(
        children: [
          // Espacio a la izquierda
          const SizedBox(width: 16),
          // Sidebar flotante
          Column(
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
                    // Gamification streak
                    Consumer<GamificationProvider>(
                      builder: (context, gamification, _) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: nt.warningAmber.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: nt.warningAmber.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('🔥', style: TextStyle(fontSize: 16)),
                              const SizedBox(width: 4),
                              Text(
                                '${gamification.streak}',
                                style: TextStyle(
                                  color: nt.warningAmber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    // Avatar
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: nt.blueGoogle.withValues(alpha: 0.15),
                        border: Border.all(color: nt.blueGoogle.withValues(alpha: 0.3)),
                      ),
                      child: Icon(Icons.person, color: nt.blueGoogle, size: 24),
                    ),
                    const SizedBox(height: 10),
                    // Logout
                    IconButton(
                      icon: Icon(Icons.logout_rounded, color: nt.pink),
                      tooltip: 'Cerrar Sesión',
                      onPressed: () async {
                        await context.read<AuthService>().signOut();
                      },
                    ),
                    const SizedBox(height: 24),
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
                      icon: Icons.analytics_rounded,
                      label: 'Progreso',
                      isSelected: navigationShell.currentIndex == 1,
                      onTap: () => _goBranch(1),
                      nt: nt,
                    ),
                    const SizedBox(height: 16),
                    _NavItem(
                      icon: Icons.settings_rounded,
                      label: 'Ajustes',
                      isSelected: navigationShell.currentIndex == 2,
                      onTap: () => _goBranch(2),
                      nt: nt,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(child: navigationShell),
        ],
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

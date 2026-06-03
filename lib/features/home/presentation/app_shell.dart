import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:provider/provider.dart';
import 'package:learn/features/auth/domain/auth_service.dart';

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
    
    // Si estamos en mobile
    if (!isDesktop) {
      return Scaffold(
        backgroundColor: nt.background,
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
          NavigationRail(
            backgroundColor: nt.surfaceCard.withValues(alpha: 0.8),
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: _goBranch,
            labelType: NavigationRailLabelType.all,
            selectedIconTheme: IconThemeData(color: nt.blueGoogle),
            selectedLabelTextStyle: TextStyle(color: nt.blueGoogle, fontWeight: FontWeight.bold),
            unselectedIconTheme: const IconThemeData(color: Colors.white54),
            unselectedLabelTextStyle: const TextStyle(color: Colors.white54),
            leading: Column(
              children: [
                const SizedBox(height: 20),
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
                IconButton(
                  icon: Icon(Icons.logout_rounded, color: nt.pink),
                  tooltip: 'Cerrar Sesión',
                  onPressed: () async {
                    await context.read<AuthService>().signOut();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_rounded),
                label: Text('Inicio'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.analytics_rounded),
                label: Text('Progreso'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_rounded),
                label: Text('Ajustes'),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1, color: nt.borderSubtle),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}

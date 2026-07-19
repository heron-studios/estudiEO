
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:learn/core/config/neural_design_system.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/providers/gamification_provider.dart';
import 'package:learn/features/settings/presentation/settings_screen.dart';
import 'package:learn/features/dashboard/presentation/tutor_analitico_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const _muted = NeuralDesignSystem.textSecondary;
  static const _blue = NeuralDesignSystem.blueGoogle;
  
  int _streakDays = 0;

  @override
  void initState() {
    super.initState();
    final storage = context.read<LocalStorageService>();
    final progress = storage.getPsicoProgress();
    setState(() {
      _streakDays = progress['streak'] ?? 0;
    });
  }


  Widget _buildUserBasicInfo(String userName, String userEmail, String targetSchool) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [_blue, Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: _blue.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : 'E',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit',
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            userName.isNotEmpty ? userName : 'Aspirante',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            userEmail,
            style: TextStyle(
              color: _muted.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _blue.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _blue.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              'Objetivo: $targetSchool',
              style: const TextStyle(
                color: _blue,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGamificationStats(GamificationProvider gamification) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.star_rounded,
            iconColor: const Color(0xFFF59E0B),
            title: 'Nivel',
            value: gamification.level.toString(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            icon: Icons.flash_on_rounded,
            iconColor: const Color(0xFF8B5CF6),
            title: 'Experiencia',
            value: '${gamification.xp} XP',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            icon: Icons.local_fire_department_rounded,
            iconColor: const Color(0xFFEF4444),
            title: 'Racha',
            value: '$_streakDays días',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final storage = context.read<LocalStorageService>();
    final auth = context.read<AuthService>();
    final gamification = context.watch<GamificationProvider>();
    
    final userName = storage.loadUserName();
    final userEmail = auth.currentUser?.email ?? 'Sin cuenta vinculada';
    final targetSchool = storage.loadTargetSchool();
    
    return Scaffold(
      backgroundColor: NeuralDesignSystem.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Perfil',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 900;
              
              if (isDesktop) {
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Columna Izquierda (Perfil, Ajustes)
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildUserBasicInfo(userName, userEmail, targetSchool),
                                const SizedBox(height: 32),
                                _buildGamificationStats(gamification),
                                const SizedBox(height: 32),
                                const SettingsView(),
                              ],
                            ),
                          ),
                          const SizedBox(width: 48),
                          // Columna Derecha (Tutor IA Analítico)
                          const Expanded(
                            flex: 7,
                            child: TutorAnaliticoView(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              // Diseño Móvil / Tablet Vertical
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildUserBasicInfo(userName, userEmail, targetSchool),
                        const SizedBox(height: 32),
                        _buildGamificationStats(gamification),
                        const SizedBox(height: 32),
                        const TutorAnaliticoView(),
                        const SizedBox(height: 16),
                        const SettingsView(),
                      ],
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

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: NeuralDesignSystem.surfaceCard.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: NeuralDesignSystem.textSecondary.withValues(alpha: 0.7),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

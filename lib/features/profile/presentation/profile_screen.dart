
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


  Widget _buildUserBasicInfo(String userName, String userEmail, String targetSchool, bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 32 : 24),
      decoration: BoxDecoration(
        color: NeuralDesignSystem.surfaceCard.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isDesktop ? CrossAxisAlignment.center : CrossAxisAlignment.center,
        children: [
          Container(
            width: isDesktop ? 100 : 120,
            height: isDesktop ? 100 : 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [_blue, Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: _blue.withValues(alpha: 0.4),
                  blurRadius: 25,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : 'E',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isDesktop ? 40 : 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit',
                ),
              ),
            ),
          ),
          SizedBox(width: isDesktop ? 32 : 0, height: isDesktop ? 0 : 24),
          Expanded(
            flex: isDesktop ? 1 : 0,
            child: Column(
              crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
              children: [
                Text(
                  userName.isNotEmpty ? userName : 'Aspirante',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isDesktop ? 32 : 28,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Outfit',
                    letterSpacing: -0.5,
                  ),
                  textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  userEmail,
                  style: TextStyle(
                    color: _muted.withValues(alpha: 0.9),
                    fontSize: 15,
                  ),
                  textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _blue.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _blue.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.flag_rounded, color: _blue, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'Objetivo: $targetSchool',
                        style: const TextStyle(
                          color: _blue,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                                _buildUserBasicInfo(userName, userEmail, targetSchool, isDesktop),
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
                        _buildUserBasicInfo(userName, userEmail, targetSchool, isDesktop),
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

class _StatCard extends StatefulWidget {
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
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCirc,
        transform: Matrix4.translationValues(0, _isHovered ? -4.0 : 0.0, 0),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        decoration: BoxDecoration(
          color: NeuralDesignSystem.surfaceCard.withValues(alpha: _isHovered ? 0.6 : 0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.iconColor.withValues(alpha: _isHovered ? 0.4 : 0.08),
            width: 1.0,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.iconColor.withValues(alpha: 0.2),
                    blurRadius: 20,
                    spreadRadius: -2,
                    offset: const Offset(0, 10),
                  )
                ]
              : [],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: widget.iconColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(widget.icon, color: widget.iconColor, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              widget.value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Outfit',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              widget.title,
              style: TextStyle(
                color: NeuralDesignSystem.textSecondary.withValues(alpha: 0.8),
                fontSize: 12,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

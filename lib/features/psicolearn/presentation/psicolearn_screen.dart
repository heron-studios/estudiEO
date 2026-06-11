import 'package:flutter/material.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:learn/features/psicolearn/presentation/psico_mission_screen.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';

class PsicoLearnScreen extends StatefulWidget {
  const PsicoLearnScreen({super.key});

  @override
  State<PsicoLearnScreen> createState() => _PsicoLearnScreenState();
}

class _PsicoLearnScreenState extends State<PsicoLearnScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _entryController;
  late Animation<double> _entryAnimation;

  String _diagnosis = 'PENDIENTE';
  int _streakDays = 0;
  bool _todayCompleted = false;
  int _failedCount = 0;
  int _totalMissions = 0;
  double _lastOverallScore = 0.0;
  Map<String, double> _lastScores = {};

  @override
  void initState() {
    super.initState();
    _loadProgress();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _pulseController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) _pulseController.forward(from: 0.0);
        });
      }
    });
    _pulseController.forward();
    _pulseAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOutSine),
    );

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _entryAnimation = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOut,
    );
    _entryController.forward();
  }

  void _loadProgress() {
    final storage = context.read<LocalStorageService>();
    final progress = storage.getPsicoProgress();
    final failedIds = storage.getFailedPsicoQuestionIds();
    setState(() {
      _streakDays = progress['streak'];
      _todayCompleted = progress['todayCompleted'];
      _failedCount = failedIds.length;
      
      _totalMissions = progress['totalMissions'] ?? 0;
      _lastOverallScore = progress['lastOverallScore'] ?? 0.0;
      _lastScores = Map<String, double>.from(progress['lastScores'] ?? {});
      
      if (_totalMissions == 0) {
        _diagnosis = 'PENDIENTE';
      } else if (_lastOverallScore >= 0.70) {
        _diagnosis = 'APTO';
      } else {
        _diagnosis = 'INAPTO';
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  void _showComingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.construction_rounded, color: Colors.amber),
            SizedBox(width: 8),
            Text('Módulo en construcción. ¡Próximamente!'),
          ],
        ),
        backgroundColor: const Color(0xFF1E1F20),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showAlreadyCompletedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final nt = NeuralTheme.of(context);
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: nt.surfaceCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                  color: nt.successGreen.withValues(alpha: 0.4), width: 1.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: nt.successGreen.withValues(alpha: 0.15),
                  ),
                  child: Icon(Icons.check_circle_rounded, color: nt.successGreen, size: 32),
                ),
                const SizedBox(height: 16),
                const Text(
                  '¡MISIÓN DIARIA COMPLETA!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    fontFamily: 'Outfit',
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Ya has completado tu misión psicométrica de hoy. Vuelve mañana para un nuevo desafío y seguir aumentando tu racha.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white60, fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: nt.blueGoogle,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('ENTENDIDO', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return NeuralBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            'PsicoLearn PRO',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
            ),
          ),
          centerTitle: true,
          actions: [
            if (_streakDays > 0)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6F00), Color(0xFFFF9100)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🔥', style: TextStyle(fontSize: 12)),
                        const SizedBox(width: 4),
                        Text(
                          '$_streakDays',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        body: FadeTransition(
          opacity: _entryAnimation,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 900;
              final bool isVerySmallHeight = constraints.maxHeight < 600;

              // En pantallas muy pequeñas de alto, permitimos scroll para no romper la UI.
              // En pantallas normales o grandes, forzamos todo en una sola pantalla.
              if (!isDesktop || isVerySmallHeight) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Column(
                        children: [
                          _buildHeader(nt),
                          const SizedBox(height: 12),
                          _buildStatsRow(),
                          const SizedBox(height: 16),
                          _buildDailyMission(nt),
                          _buildProfileCard(nt),
                          const SizedBox(height: 16),
                          _buildModulesGrid(),
                          const SizedBox(height: 16),
                          _buildTipCard(nt),
                          const SizedBox(height: 12),
                          _buildMedicalExamButton(nt),
                        ],
                      ),
                    ),
                  ),
                );
              }

              // ==========================================
              // DESKTOP LAYOUT (Una sola pantalla, sin scroll)
              // ==========================================
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Columna Izquierda: Header + Stats + Tip
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildHeader(nt),
                              const SizedBox(height: 16),
                              Expanded(
                                child: _buildStatsCol(),
                              ),
                              const SizedBox(height: 16),
                              _buildTipCard(nt),
                              const SizedBox(height: 12),
                              _buildMedicalExamButton(nt),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Columna Derecha: Misión Diaria + Perfil + Módulos
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildDailyMission(nt),
                              _buildProfileCard(nt),
                              const SizedBox(height: 16),
                              Expanded(
                                child: _buildModulesGridDesktop(),
                              ),
                            ],
                          ),
                        ),
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

  Widget _buildHeader(NeuralThemeData nt) {
    return StaticGlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      borderRadius: BorderRadius.circular(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: nt.blueGoogle.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: nt.blueGoogle.withValues(alpha: 0.4), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.psychology_rounded, color: nt.blueGoogle, size: 14),
                const SizedBox(width: 6),
                Text(
                  'Evaluación Psicométrica',
                  style: TextStyle(
                    color: nt.blueGoogle,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, _) {
              final baseColor = _diagnosis == 'APTO'
                  ? const Color(0xFF10B981)
                  : (_diagnosis == 'PENDIENTE'
                      ? const Color(0xFFF59E0B)
                      : const Color(0xFFEF4444));

              return ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    baseColor.withValues(alpha: 0.6),
                    baseColor,
                    Colors.white,
                    baseColor,
                    baseColor.withValues(alpha: 0.6),
                  ],
                  stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
                  begin: Alignment(_pulseAnimation.value - 1, 0),
                  end: Alignment(_pulseAnimation.value + 1, 0),
                ).createShader(bounds),
                child: Text(
                  'ESTADO: $_diagnosis',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                    fontFamily: 'Outfit',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 4),
          Text(
            'Completa misiones y simulacros para tu diagnóstico final',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 12,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.local_fire_department_rounded,
            iconColor: const Color(0xFFFF6F00),
            value: _streakDays > 0 ? '$_streakDays días' : 'Sin racha',
            label: 'Racha',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            icon: Icons.task_alt_rounded,
            iconColor: _todayCompleted
                ? const Color(0xFF4ADE80)
                : const Color(0xFFF59E0B),
            value: _todayCompleted ? 'Lista' : 'Pendiente',
            label: 'Misión',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            icon: Icons.replay_rounded,
            iconColor: _failedCount > 0
                ? const Color(0xFFEF4444)
                : const Color(0xFF4ADE80),
            value: _failedCount > 0 ? '$_failedCount error' : 'Limpio',
            label: 'Repaso',
          ),
        ),
      ],
    );
  }

  // Versión en columna para la izquierda de la pantalla desktop
  Widget _buildStatsCol() {
    return Column(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.local_fire_department_rounded,
            iconColor: const Color(0xFFFF6F00),
            value: _streakDays > 0 ? '$_streakDays días' : 'Sin racha',
            label: 'Racha Actual',
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.task_alt_rounded,
            iconColor: _todayCompleted
                ? const Color(0xFF4ADE80)
                : const Color(0xFFF59E0B),
            value: _todayCompleted ? 'Completada' : 'Pendiente',
            label: 'Misión de Hoy',
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.replay_rounded,
            iconColor: _failedCount > 0
                ? const Color(0xFFEF4444)
                : const Color(0xFF4ADE80),
            value: _failedCount > 0 ? '$_failedCount pendientes' : 'Todo limpio',
            label: 'Repaso',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return StaticGlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      borderRadius: BorderRadius.circular(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: iconColor.withValues(alpha: 0.3), width: 1),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  label,
                  style: const TextStyle(color: Colors.white54, fontSize: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(NeuralThemeData nt) {
    if (_totalMissions == 0 || _lastScores.isEmpty) return const SizedBox.shrink();

    // Encontrar la dimensión más débil para dar una recomendación útil
    String weakestDim = '';
    double lowestPct = 1.1;
    _lastScores.forEach((key, val) {
      if (val < lowestPct) {
        lowestPct = val;
        weakestDim = key;
      }
    });

    String recommendation = 'Tu perfil está equilibrado y apto para la PNP. ¡Sigue así!';
    if (_diagnosis != 'APTO' && weakestDim.isNotEmpty) {
      recommendation = 'Concéntrate en mejorar en la dimensión: $weakestDim.';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: StaticGlassContainer(
        padding: const EdgeInsets.all(18),
        borderRadius: BorderRadius.circular(20),
        borderColor: nt.blueGoogle.withValues(alpha: 0.25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.psychology_alt_rounded, color: nt.blueGoogle, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'PERFIL PSICOMÉTRICO ACTUAL',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    fontFamily: 'Outfit',
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: nt.blueGoogle.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: nt.blueGoogle.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    '$_totalMissions ${_totalMissions == 1 ? "misión" : "misiones"}',
                    style: TextStyle(
                      color: nt.blueGoogle,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ..._lastScores.entries.map((e) {
              final valP = e.value;
              final dimColor = valP >= 0.75
                  ? nt.successGreen
                  : (valP >= 0.60 ? nt.warningAmber : nt.pink);

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.key,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${(valP * 100).toInt()}%',
                          style: TextStyle(
                            color: dimColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: valP,
                        minHeight: 6,
                        backgroundColor: Colors.white.withValues(alpha: 0.08),
                        valueColor: AlwaysStoppedAnimation<Color>(dimColor),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: Row(
                children: [
                  Icon(
                    _diagnosis == 'APTO' ? Icons.check_circle_rounded : Icons.info_outline_rounded,
                    color: _diagnosis == 'APTO' ? nt.successGreen : nt.warningAmber,
                    size: 14,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      recommendation,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 11,
                        height: 1.3,
                      ),
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

  Widget _buildDailyMission(NeuralThemeData nt) {
    return HoverGlassCard(
      onTap: () async {
        if (_todayCompleted) {
          _showAlreadyCompletedDialog();
          return;
        }
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PsicoMissionScreen()),
        );
        if (mounted) _loadProgress();
      },
      hoverGradientBorder: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: nt.neuralGradient.scale(0.7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _todayCompleted ? Icons.check_circle_rounded : Icons.stars_rounded,
                color: _todayCompleted ? const Color(0xFF4ADE80) : Colors.amber,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'MISIÓN DIARIA',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        fontFamily: 'Outfit',
                        letterSpacing: 0.5),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _todayCompleted
                        ? '¡Misión de hoy completada! Vuelve mañana.'
                        : '20 preguntas psicométricas para mejorar tu perfil.',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.white, size: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModulesGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth >= 600 ? 2 : 1;
        double aspectRatio = constraints.maxWidth >= 600 ? 1.6 : 2.5;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: aspectRatio,
          children: _buildModuleCards(),
        );
      },
    );
  }

  Widget _buildModulesGridDesktop() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _buildModuleCards().map((card) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: card,
          ),
        );
      }).toList(),
    );
  }

  List<Widget> _buildModuleCards() {
    return [
      _buildModuleCard(
        title: 'SIMULADOR',
        subtitle: 'Simulacro oficial en tiempo real',
        icon: Icons.timer_rounded,
        color: const Color(0xFF3B82F6),
        badge: '100 PREG',
        badgeColor: const Color(0xFF3B82F6),
        onTap: () => context.push('/psicolearn/simulator'),
      ),
      _buildModuleCard(
        title: 'REPASAR',
        subtitle: 'Corrige los errores de tu misión',
        icon: Icons.history_edu_rounded,
        color: _failedCount > 0 ? const Color(0xFFEF4444) : const Color(0xFF10B981),
        badge: _failedCount > 0 ? '$_failedCount PEND' : 'AL DÍA',
        badgeColor: _failedCount > 0 ? const Color(0xFFEF4444) : const Color(0xFF10B981),
        onTap: () => context.push('/psicolearn/re-entrenamiento'),
      ),
      _buildModuleCard(
        title: 'RAZONAMIENTO',
        subtitle: 'Lógica deductiva y silogismos rápidos',
        icon: Icons.account_tree_rounded,
        color: const Color(0xFF14B8A6),
        badge: 'JUEGO',
        badgeColor: const Color(0xFF14B8A6),
        onTap: () => context.push('/psicolearn/razonamiento'),
      ),
      _buildModuleCard(
        title: 'ENTREVISTA',
        subtitle: 'Simulador de entrevista personal',
        icon: Icons.record_voice_over_rounded,
        color: Colors.pinkAccent,
        badge: 'TÁCTICO',
        badgeColor: Colors.pinkAccent,
        onTap: () => context.push('/psicolearn/entrevista'),
      ),
    ];
  }

  Widget _buildModuleCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String badge,
    required Color badgeColor,
    VoidCallback? onTap,
  }) {
    return HoverGlassCard(
      onTap: onTap ?? _showComingSoon,
      hoverGradientBorder: true,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: color.withValues(alpha: 0.3)),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: badgeColor.withValues(alpha: 0.4), width: 1),
                  ),
                  child: Text(
                    badge,
                    style: TextStyle(
                      color: badgeColor,
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.65),
                fontSize: 10,
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(NeuralThemeData nt) {
    return StaticGlassContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(16),
      borderColor: nt.purple.withValues(alpha: 0.3),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: nt.purple.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: nt.purple.withValues(alpha: 0.3), width: 1),
            ),
            child: Icon(Icons.tips_and_updates_rounded,
                color: nt.purple, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'CONSEJO PSICOMÉTRICO',
                  style: TextStyle(
                    color: nt.purple,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Responde con honestidad. Los perfiles con respuestas extremas pueden ser detectados por las escalas de sinceridad.',
                  style: TextStyle(
                      color: Colors.white70, fontSize: 11, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalExamButton(NeuralThemeData nt) {
    return HoverGlassCard(
      onTap: _showComingSoon,
      hoverGradientBorder: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: nt.pink.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: nt.pink.withValues(alpha: 0.3), width: 1),
              ),
              child: Icon(Icons.medical_services_rounded,
                  color: nt.pink, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'NUEVA FUNCIÓN',
                    style: TextStyle(
                      color: nt.pink,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'EXAMEN MEDICO PNP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit',
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.white, size: 14),
            ),
          ],
        ),
      ),
    );
  }
}

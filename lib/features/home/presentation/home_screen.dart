import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/learning_provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/providers/gamification_provider.dart';
import 'package:learn/models/learning_level.dart';
import 'package:learn/models/learning_session.dart';

import 'package:learn/core/widgets/premium_upgrade_dialog.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:learn/core/config/neural_theme.dart';

import 'package:learn/core/services/local_storage_service.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'play_store_invite_dialog.dart';
import 'package:learn/core/services/bible_service.dart';
import 'package:learn/core/services/limits_service.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/features/dashboard/domain/leaderboard_service.dart';
import 'package:learn/core/widgets/profile_setup_dialog.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:learn/core/widgets/animated_grid_bg.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  HomeScreen — Pantalla principal del dashboard neural
//
//  v3 cambios:
//  • Header muestra "EDUPOL  X  APTO/PENDIENTE/INAPTO" al costado del logo.
//  • Misión Diaria integrada directamente en el menú principal.
//  • Consejo psicométrico debajo del botón de misión diaria.
//  • PsicoLearnBanner eliminado; fallidos van a Repasar (SRS) integrado.
// ─────────────────────────────────────────────────────────────────────────────
class _PremiumFabButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color glowColor;
  final VoidCallback onPressed;

  const _PremiumFabButton({
    required this.icon,
    required this.tooltip,
    required this.glowColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: tooltip,
      child: Tooltip(
        message: tooltip,
        child: GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            onPressed();
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF0F172A).withValues(alpha: 0.6),
                  border: Border.all(
                    color: glowColor.withValues(alpha: 0.5),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: glowColor.withValues(alpha: 0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: glowColor,
                    size: 26,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  late AnimationController _warningLottieController;

  int _streakDays = 0;
  bool _todayCompleted = false;

  String? _dailyVerse;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _fabAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeInOut));

    _warningLottieController = AnimationController(vsync: this);

    _warningLottieController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        if (!mounted) return;
        await Future.delayed(const Duration(seconds: 10));
        if (mounted) {
          _warningLottieController.forward(from: 0.0);
        }
      }
    });

    _loadPsicoProgress();
    _loadDailyVerse();


    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ProfileSetupDialog.showIfNeeded(context);
      _checkPremiumStatus();
      _syncLeaderboard();
      _checkPlayStoreInvite();
    });
  }

  Future<void> _syncLeaderboard() async {
    final auth = context.read<AuthService>();
    final user = auth.currentUser;
    if (user == null) return;

    final storage = context.read<LocalStorageService>();
    final name = storage.loadUserName();
    final school = storage.loadTargetSchool();

    final gami = context.read<GamificationProvider>();
    final xp = gami.xp;

    final leaderboard = LeaderboardService();
    await leaderboard.syncUserScore(
      uid: user.uid,
      name: name,
      school: school,
      xp: xp,
    );
  }

  void _checkPremiumStatus() {
    if (!mounted) return;
    final auth = context.read<AuthService>();
    if (!auth.isPremium) {
      PremiumUpgradeDialog.show(context);
    }
  }

  Future<void> _loadDailyVerse() async {
    final verse = await BibleService.getDailyVerse();
    if (mounted) {
      setState(() {
        _dailyVerse = verse;
      });
    }
  }

  @override
  void dispose() {
    _fabController.dispose();
    _warningLottieController.dispose();
    super.dispose();
  }

  Future<void> _checkPlayStoreInvite() async {
    final auth = context.read<AuthService>();
    if (!auth.isPremium) return;

    final storage = context.read<LocalStorageService>();
    if (storage.loadHasSeenPlayStoreInvite()) return;

    if (!mounted) return;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const PlayStoreInviteDialog(),
    );
  }

  void _loadPsicoProgress() {
    final storage = context.read<LocalStorageService>();
    final progress = storage.getPsicoProgress();
    setState(() {
      _streakDays = progress['streak'];
      _todayCompleted = progress['todayCompleted'];
    });
  }

  void _showAlreadyCompletedDialog(BuildContext context, NeuralThemeData nt) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: nt.surfaceCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: nt.successGreen.withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: RepaintBoundary(
                    child: Lottie.asset(
                      'assets/lottie/trophy.json',
                      width: 140,
                      repeat: false,
                      fit: BoxFit.contain,
                    ),
                  ),
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
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 13,
                    height: 1.5,
                  ),
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'ENTENDIDO',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _startGuidedLearningFlow(BuildContext context) {
    final learningProvider = context.read<LearningProvider>();
    final sessionInfo = learningProvider.getLastActiveSessionInfo();
    final nt = NeuralTheme.of(context);

    if (sessionInfo != null) {
      final topicId = sessionInfo['topicId'] as String;
      final nivel = sessionInfo['nivel'] as Dificultad;
      final session = sessionInfo['session'] as LearningSession;

      final subjectProvider = context.read<SubjectProvider>();
      final topic = subjectProvider.getTopic(topicId);
      final subject = topic != null
          ? subjectProvider.getSubject(topic.subjectId)
          : null;
      final topicName = topic?.name ?? 'Tema';
      final subjectName = subject?.name ?? 'Materia';
      final currentQuestionNum = session.correctCount + 1;

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: nt.surfaceElevated,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: nt.borderSubtle),
          ),
          title: const Row(
            children: [
              Icon(Icons.school_rounded, color: Colors.orangeAccent),
              SizedBox(width: 10),
              Text(
                '¿Continuar Aprendiendo?',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tienes una sesión activa de aprendizaje guiado en:',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: nt.borderSubtle),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subjectName,
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topicName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: nivel.color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: nivel.color.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Text(
                            '${nivel.emoji} Nivel ${nivel.displayName}',
                            style: TextStyle(
                              color: nivel.color,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Pregunta $currentQuestionNum de 10',
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.push('/gallery', extra: {'mode': 'guided'});
              },
              child: Text(
                'Ir a materias',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                final subjectProvider = context.read<SubjectProvider>();
                subjectProvider.selectTopic(topicId);
                context.read<LearningProvider>().resumeSession(topicId, nivel);
                context.push(
                  '/learning-quiz',
                  extra: {'topicId': topicId, 'nivel': nivel},
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: nt.blueGoogle,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    } else {
      context.push('/gallery', extra: {'mode': 'guided'});
    }
  }

  Widget _buildSimulacroCard(
    BuildContext context,
    dynamic nt, {
    bool isSquare = false,
  }) {
    final storage = context.read<LocalStorageService>();
    final history = storage.getExamHistory();
    String subtitle = '100 preguntas · 3 horas';
    if (history.isNotEmpty) {
      final lastExam = history.first;
      final score = lastExam['score'] as int? ?? 0;
      final total = lastExam['total'] as int? ?? 100;
      final percent = (score / total) * 100;
      subtitle = isSquare
          ? 'Último: $score/$total'
          : 'Último: $score/$total (${percent.toInt()}%) · Nuevo';
    }

    Future<void> onTap() async {
      final auth = context.read<AuthService>();
      if (!auth.isPremium) {
        if (context.mounted) {
          PremiumUpgradeDialog.show(
            context,
            title: '¡Simulacro Premium!',
            message:
                'Los simulacros completos de 100 preguntas son exclusivos para usuarios Premium. ¡Accede por S/30 (antes S/60) — pago único de por vida!',
          );
        }
        return;
      }

      if (!context.mounted) return;

      final savedState = storage.getActiveExamState();
      if (savedState != null) {
        final List<dynamic> qList = savedState['questions'] as List? ?? [];
        final Map<dynamic, dynamic> ansMap =
            savedState['answers'] as Map? ?? {};
        final secondsLeft = savedState['secondsLeft'] as int? ?? 10800;

        final h = secondsLeft ~/ 3600;
        final m = (secondsLeft % 3600) ~/ 60;
        final timeStr = h > 0 ? '${h}h ${m}m' : '${m}m';

        final resume = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: const Color(0xFF1E293B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Simulacro en Progreso',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Tienes un simulacro guardado:\n'
              '· Respondidas: ${ansMap.length} de ${qList.length}\n'
              '· Tiempo restante: $timeStr\n\n'
              '¿Deseas reanudar tu examen anterior o iniciar uno nuevo?',
              style: const TextStyle(color: Color(0xFF94A3B8), height: 1.5),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text(
                  'Iniciar Nuevo',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Reanudar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );

        if (resume == true) {
          if (context.mounted) {
            context.push('/exam', extra: {'resume': true});
          }
        } else if (resume == false) {
          storage.clearActiveExamState();
          if (!auth.isPremium) await LimitsService.incrementSimulacroCount();
          if (context.mounted) {
            context.push('/exam', extra: {'resume': false});
          }
        }
      } else {
        if (!auth.isPremium) await LimitsService.incrementSimulacroCount();
        if (context.mounted) {
          context.push('/exam', extra: {'resume': false});
        }
      }
    }

    if (isSquare) {
      return _GlassTile(
        icon: Icons.timer_rounded,
        color: const Color(0xFFD96570),
        gradientColors: const [Color(0xFF3A1520), Color(0xFF220D13)],
        title: 'Simulacro',
        subtitle: subtitle,
        onTap: onTap,
      );
    }

    return HoverGlassCard(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2A1520), Color(0xFF1A0C14)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFD96570).withValues(alpha: 0.25),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD96570), Color(0xFFE91E63)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD96570).withValues(alpha: 0.4),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: const Icon(
                Icons.timer_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SIMULACRO',
                    style: TextStyle(
                      color: Color(0xFFD96570),
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Examen Oficial',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFD96570).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFFD96570),
                size: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstudiarTile(BuildContext context, dynamic nt) {
    return _GlassTile(
      icon: Icons.auto_stories_rounded,
      color: const Color(0xFF4285F4),
      gradientColors: const [Color(0xFF1A2A4A), Color(0xFF0F1E3D)],
      title: 'Estudiar',
      subtitle: 'Por asignatura',
      onTap: () => context.push('/gallery', extra: {'mode': 'quiz'}),
    );
  }

  Widget _buildTarjetasTile(BuildContext context, dynamic nt) {
    return _GlassTile(
      icon: Icons.style_rounded,
      color: const Color(0xFF9B72CB),
      gradientColors: const [Color(0xFF2A1A4A), Color(0xFF1A0F3D)],
      title: 'Tarjetas',
      subtitle: 'Memoria visual',
      isLocked: !context.read<AuthService>().isPremium,
      onTap: () {
        final auth = context.read<AuthService>();
        if (!auth.isPremium) {
          PremiumUpgradeDialog.show(
            context,
            title: 'Tarjetas Flashcard Premium',
            message: 'Las tarjetas de memoria visual son exclusivas para usuarios Premium. ¡Accede por S/30 (antes S/60)!',
          );
          return;
        }
        context.push('/flashcards');
      },
    );
  }

  Widget _buildAprendizajeTile(BuildContext context, dynamic nt) {
    return _GlassTile(
      icon: Icons.school_rounded,
      color: const Color(0xFFFBBF24),
      gradientColors: const [Color(0xFF2A2010), Color(0xFF1A1508)],
      title: 'Aprendizaje',
      subtitle: 'Modo guiado',
      isLocked: !context.read<AuthService>().isPremium,
      onTap: () {
        final auth = context.read<AuthService>();
        if (!auth.isPremium) {
          PremiumUpgradeDialog.show(
            context,
            title: 'Aprendizaje Guiado Premium',
            message: 'El modo de aprendizaje guiado por temas es exclusivo para usuarios Premium. ¡Accede por S/30 (antes S/60)!',
          );
          return;
        }
        _startGuidedLearningFlow(context);
      },
    );
  }




  /// Misión Diaria — card mejorada
  Widget _buildDailyMissionCard(BuildContext context, dynamic nt) {
    return HoverGlassCard(
      onTap: () async {
        if (_todayCompleted) {
          _showAlreadyCompletedDialog(context, nt);
          return;
        }
        await context.push('/psico-mission');
        if (mounted) _loadPsicoProgress();
      },
      hoverGradientBorder: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _todayCompleted
                ? [const Color(0xFF064E3B), const Color(0xFF065F46)]
                : [
                    const Color(0xFF1E3A8A),
                    const Color(0xFF7C3AED),
                    const Color(0xFFBE185D),
                  ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color:
                  (_todayCompleted
                          ? const Color(0xFF4ADE80)
                          : const Color(0xFF7C3AED))
                      .withValues(alpha: 0.25),
              blurRadius: 16,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            _todayCompleted
                ? Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF4ADE80),
                      size: 24,
                    ),
                  )
                : SizedBox(
                    width: 48,
                    height: 48,
                    child: RepaintBoundary(
                      child: Transform.scale(
                        scale: 1.4,
                        child: Lottie.asset(
                          'assets/lottie/warning_status.json',
                          controller: _warningLottieController,
                          onLoaded: (composition) {
                            _warningLottieController.duration =
                                composition.duration;
                            _warningLottieController.forward();
                          },
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Text(
                        'MISIÓN DIARIA',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          fontFamily: 'Outfit',
                          letterSpacing: 1.2,
                        ),
                      ),
                      if (_streakDays > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF6F00), Color(0xFFFF9100)],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFFFF6F00,
                                ).withValues(alpha: 0.4),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('🔥', style: TextStyle(fontSize: 10)),
                              const SizedBox(width: 3),
                              Text(
                                '$_streakDays',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _todayCompleted
                        ? '¡Completada! Vuelve mañana.'
                        : '20 preguntas psicométricas · Perfila tu candidatura',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 11.5,
                      height: 1.3,
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
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    final bool isLargeScreen = MediaQuery.of(context).size.width >= 800;

    // Greeting removido para mayor espacio en web móvil

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: isLargeScreen ? null : ExpandableFab.location,
      floatingActionButton: isLargeScreen ? null : Padding(
        padding: const EdgeInsets.only(bottom: 24.0, right: 8.0),
        child: ExpandableFab(
          distance: 76.0,
          type: ExpandableFabType.fan,
          fanAngle: 90, // Set to 90 degrees to ensure a perfect quarter-circle and avoid right-edge clipping
          openButtonBuilder: RotateFloatingActionButtonBuilder(
            child: const Icon(Icons.explore_rounded, size: 28),
            fabSize: ExpandableFabSize.regular,
            backgroundColor: const Color(0xFF1E293B),
            foregroundColor: const Color(0xFF60A5FA),
            shape: CircleBorder(
              side: BorderSide(
                color: const Color(0xFF60A5FA).withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
          ),
          closeButtonBuilder: DefaultFloatingActionButtonBuilder(
            child: const Icon(Icons.close_rounded, size: 28),
            fabSize: ExpandableFabSize.regular,
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: const Color(0xFFF43F5E),
            shape: CircleBorder(
              side: BorderSide(
                color: const Color(0xFFF43F5E).withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
          ),
          children: [
            _PremiumFabButton(
              tooltip: 'Ayuda',
              icon: Icons.help_outline_rounded,
              glowColor: Colors.white,
              onPressed: () => context.push('/roadmap'),
            ),
            _PremiumFabButton(
              tooltip: 'Configuración',
              icon: Icons.settings_rounded,
              glowColor: const Color(0xFF94A3B8),
              onPressed: () => context.push('/profile'),
            ),
            _PremiumFabButton(
              tooltip: 'Arena',
              icon: Icons.sports_esports_rounded,
              glowColor: const Color(0xFFF59E0B),
              onPressed: () {
                final auth = context.read<AuthService>();
                if (!auth.isPremium) {
                  PremiumUpgradeDialog.show(
                    context,
                    title: 'Modo Arena Premium',
                    message: 'La Arena competitiva multijugador es exclusiva para usuarios Premium. ¡Accede por S/30 (antes S/60)!',
                  );
                  return;
                }
                context.push('/arena');
              },
            ),
            _PremiumFabButton(
              tooltip: 'Tutor',
              icon: Icons.psychology_rounded,
              glowColor: const Color(0xFFC084FC),
              onPressed: () {
                final auth = context.read<AuthService>();
                if (!auth.isPremium) {
                  PremiumUpgradeDialog.show(
                    context,
                    title: 'Tutor IA Premium',
                    message: 'El Tutor con Inteligencia Artificial es exclusivo para usuarios Premium. ¡Accede por S/30 (antes S/60)!',
                  );
                  return;
                }
                context.push('/profile'); // o la ruta correspondiente al tutor
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isLargeScreen ? 24 : 16,
            vertical: isLargeScreen ? 16 : 8,
          ),
          child: Column(
            children: [
              // ── HEADER ──────────────────────────────────────────────────
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 12,
                spacing: 16,
                children: [
                  // Logo + Badge + Greeting
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final url = Uri.parse(
                                  'https://pnp-edu.github.io/POL-HUB/',
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                              child: ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      colors: [Colors.white, Color(0xFFB0C4FF)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ).createShader(bounds),
                                child: const Text(
                                  'EDUPOL',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.5,
                                    fontFamily: 'Outfit',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Badge PRO/FREE
                            Consumer<AuthService>(
                              builder: (context, auth, _) {
                                final isPro = auth.isPremium;
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: isPro
                                        ? const LinearGradient(
                                            colors: [
                                              Color(0xFF7C3AED),
                                              Color(0xFF9B72CB),
                                            ],
                                          )
                                        : null,
                                    color: isPro
                                        ? null
                                        : Colors.white.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: isPro
                                          ? Colors.transparent
                                          : Colors.white.withValues(alpha: 0.2),
                                    ),
                                    boxShadow: isPro
                                        ? [
                                            BoxShadow(
                                              color: const Color(
                                                0xFF7C3AED,
                                              ).withValues(alpha: 0.4),
                                              blurRadius: 8,
                                              spreadRadius: 0,
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Text(
                                    isPro ? 'PRO' : 'FREE',
                                    style: TextStyle(
                                      color: isPro
                                          ? Colors.white
                                          : Colors.white60,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                );
                              },
                            ),
                            if (isLargeScreen && _dailyVerse != null) ...[
                              const SizedBox(width: 16),
                              Container(
                                width: 1,
                                height: 18,
                                color: Colors.white.withValues(alpha: 0.2),
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.auto_stories_rounded,
                                color: Colors.white.withValues(alpha: 0.5),
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Tooltip(
                                  message: _dailyVerse!,
                                  child: Text(
                                    _dailyVerse!,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Inter',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  // Derecha: Gamificación, Hoja de Ruta y Ajustes
                  Consumer<GamificationProvider>(
                    builder: (context, gami, child) {
                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.end,
                        children: [
                          // Unified Gamification Stats Pill
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: nt.surfaceCard.withValues(alpha: 0.4), // Premium glass effect
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.15),
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Trophy (Leaderboard)
                                GestureDetector(
                                  onTap: () => _showLeaderboardDialog(context, nt),
                                  child: const BlinkingTrophyIcon(),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 12),
                                  width: 1,
                                  height: 16,
                                  color: Colors.white.withValues(alpha: 0.2),
                                ),
                                // Racha
                                const Icon(
                                  Icons.local_fire_department_rounded,
                                  color: Colors.orangeAccent,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${gami.streak}',
                                  style: const TextStyle(
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 12),
                                  width: 1,
                                  height: 16,
                                  color: Colors.white.withValues(alpha: 0.2),
                                ),
                                // Nivel
                                const Icon(
                                  Icons.star_rounded,
                                  color: Color(0xFFC084FC),
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Nvl ${gami.level}',
                                  style: const TextStyle(
                                    color: Color(0xFFC084FC),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isLargeScreen) ...[
                            // Hoja de Ruta (?)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.12),
                                ),
                              ),
                              child: IconButton(
                                onPressed: () => context.push('/roadmap'),
                                icon: const Icon(
                                  Icons.help_outline_rounded,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                tooltip: 'Hoja de Ruta',
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(),
                              ),
                            ),
                            // Perfil (👤)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.12),
                                ),
                              ),
                              child: IconButton(
                                onPressed: () => context.push('/profile'),
                                icon: const Icon(
                                  Icons.person_rounded,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                tooltip: 'Perfil',
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(),
                              ),
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                ],
              ),
              // ── BANNER DE DESCARGAS NATIVAS ──────────────────────────────────
              FadeTransition(
                opacity: _fabAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: HoverGlassCard(
                      onTap: () => context.push('/downloads'),
                      hoverGradientBorder: true,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.orangeAccent.withValues(alpha: 0.8),
                              Colors.orange.withValues(alpha: 0.4),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.install_mobile_rounded, color: Colors.white, size: 28),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '¡Instala la App Nativa!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: 'Outfit',
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Versión Android',
                                    style: TextStyle(color: Colors.white70, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ── BANNER DE REPASO (SRS) ──────────────────────────────────
              Consumer<SrsProvider>(
                builder: (context, srs, child) {
                  final count = srs.getReviewQueue().length;
                  if (count == 0) return const SizedBox.shrink();

                  return FadeTransition(
                    opacity: _fabAnimation,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 1000),
                        child: HoverGlassCard(
                          onTap: () => context.push('/srs-review'),
                          hoverGradientBorder: true,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  nt.successGreen.withValues(alpha: 0.8),
                                  nt.successGreen.withValues(alpha: 0.4),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.history_edu_rounded,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '🎯 ¡Tienes $count repaso${count > 1 ? 's' : ''} pendiente${count > 1 ? 's' : ''}!',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          fontFamily: 'Outfit',
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Refuerza tu memoria ahora',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 16,
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

              // ── CARDS — centradas verticalmente en el espacio restante ──
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (isLargeScreen) {
                            final totalWidth = constraints.maxWidth;
                            final colWidth3 = (totalWidth - 32) / 3;
                            final row3Height = colWidth3 / 1.25;

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildDailyMissionCard(context, nt),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildSimulacroCard(context, nt),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: colWidth3,
                                      height: row3Height,
                                      child: _buildEstudiarTile(context, nt),
                                    ),
                                    const SizedBox(width: 16),
                                    SizedBox(
                                      width: colWidth3,
                                      height: row3Height,
                                      child: _buildTarjetasTile(context, nt),
                                    ),
                                    const SizedBox(width: 16),
                                    SizedBox(
                                      width: colWidth3,
                                      height: row3Height,
                                      child: _buildAprendizajeTile(context, nt),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildDailyMissionCard(context, nt),
                                  const SizedBox(height: 12),
                                  // Fila 1: Estudiar + Tarjetas
                                  Row(
                                    children: [
                                      Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 1.45,
                                          child: _buildEstudiarTile(
                                            context,
                                            nt,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 1.45,
                                          child: _buildTarjetasTile(
                                            context,
                                            nt,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  // Fila 2: Aprendizaje + Simulacro
                                  Row(
                                    children: [
                                      Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 1.45,
                                          child: _buildAprendizajeTile(
                                            context,
                                            nt,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 1.45,
                                          child: _buildSimulacroCard(
                                            context,
                                            nt,
                                            isSquare: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLeaderboardDialog(BuildContext context, NeuralThemeData nt) {
    final storage = context.read<LocalStorageService>();
    final userSchool = storage.loadTargetSchool();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                  color: nt.surfaceCard,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 30,
                    ),
                  ],
                ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: AnimatedGridBackground(
                child: DefaultTabController(
                  length: 2,
                  initialIndex: userSchool == 'EETSPN' ? 1 : 0,
                  child: Column(
                    children: [
                    Container(
                      padding: const EdgeInsets.only(top: 24, bottom: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            nt.blueGoogle.withValues(alpha: 0.2),
                            Colors.transparent,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.emoji_events_rounded,
                            color: Colors.amber,
                            size: 40,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Ranking Global',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                            ),
                          ),
                          const SizedBox(height: 16),
                          TabBar(
                            indicatorColor: nt.blueGoogle,
                            labelColor: Colors.white,
                            unselectedLabelColor: nt.textSecondary,
                            tabs: const [
                              Tab(text: 'EO PNP'),
                              Tab(text: 'EETSPN'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildLeaderboardList(nt, 'EO PNP'),
                          _buildLeaderboardList(nt, 'EETSPN'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Cerrar',
                              style: TextStyle(color: nt.textSecondary),
                            ),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF59E0B),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              context.push('/arena');
                            },
                            icon: const Icon(Icons.sports_esports_rounded),
                            label: const Text(
                              'Entrar a la Arena',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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
  );
      },
    );
  }

  Widget _buildLeaderboardList(NeuralThemeData nt, String school) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: LeaderboardService().getTopRankings(school),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'Aún no hay datos para $school',
              style: TextStyle(color: nt.textSecondary),
            ),
          );
        }

        final users = snapshot.data!;
        
        // Podium for top 3
        final topUsers = users.take(3).toList();
        final restUsers = users.skip(3).toList();

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            if (topUsers.isNotEmpty)
              SliverToBoxAdapter(
                child: RepaintBoundary(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 32.0, left: 16, right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (topUsers.length > 1) _buildPodiumItem(nt, topUsers[1], 2, 120),
                        if (topUsers.isNotEmpty) _buildPodiumItem(nt, topUsers[0], 1, 160),
                        if (topUsers.length > 2) _buildPodiumItem(nt, topUsers[2], 3, 100),
                      ],
                    ),
                  ),
                ),
              ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final user = restUsers[index];
                    final rank = index + 4;
                    return _buildLeaderboardListItem(nt, user, rank);
                  },
                  childCount: restUsers.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        );
      },
    );
  }

  Widget _buildPodiumItem(NeuralThemeData nt, Map<String, dynamic> user, int rank, double height) {
    Color rankColor;
    if (rank == 1) {
      rankColor = const Color(0xFFFFD700);
    } else if (rank == 2) {
      rankColor = const Color(0xFFC0C0C0);
    } else {
      rankColor = const Color(0xFFCD7F32);
    }

    final name = user['name'] ?? 'Aspirante';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'A';

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: rank == 1 ? 28 : 22,
          backgroundColor: rankColor,
          child: Text(
            initial,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name.split(' ').first,
          style: TextStyle(
            color: Colors.white,
            fontWeight: rank == 1 ? FontWeight.bold : FontWeight.w600,
            fontSize: rank == 1 ? 14 : 12,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          '${user['xp']} XP',
          style: TextStyle(
            color: nt.blueGoogle,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                rankColor.withValues(alpha: 0.8),
                rankColor.withValues(alpha: 0.2),
                Colors.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            border: Border(
              top: BorderSide(color: rankColor, width: 2),
              left: BorderSide(color: rankColor.withValues(alpha: 0.5), width: 1),
              right: BorderSide(color: rankColor.withValues(alpha: 0.5), width: 1),
            ),
          ),
          child: Center(
            child: Text(
              '$rank',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: rank == 1 ? 40 : 32,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardListItem(NeuralThemeData nt, Map<String, dynamic> user, int rank) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: ListTile(
        leading: Text(
          '$rank',
          style: TextStyle(
            color: nt.textSecondary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        title: Text(
          user['name'] ?? 'Aspirante',
          style: TextStyle(
            color: nt.textPrimary,
          ),
        ),
        trailing: Text(
          '${user['xp']} XP',
          style: TextStyle(
            color: nt.blueGoogle,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  _GlassTile — tile cuadrado del grid con gradiente por color
// ─────────────────────────────────────────────────────────────────────────────
class _GlassTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final List<Color> gradientColors;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isLocked;

  const _GlassTile({
    required this.icon,
    required this.color,
    required this.gradientColors,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return HoverGlassCard(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isLocked
                    ? Colors.white.withValues(alpha: 0.08)
                    : color.withValues(alpha: 0.2),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon with glow
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        (isLocked ? Colors.white : color).withValues(alpha: isLocked ? 0.08 : 0.35),
                        (isLocked ? Colors.white : color).withValues(alpha: isLocked ? 0.04 : 0.15),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: (isLocked ? Colors.white : color).withValues(alpha: isLocked ? 0.1 : 0.4),
                    ),
                  ),
                  child: Icon(
                    isLocked ? Icons.lock_rounded : icon,
                    color: isLocked ? Colors.white.withValues(alpha: 0.3) : color,
                    size: 22,
                  ),
                ),
                const Spacer(),
                // Title
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isLocked
                          ? Colors.white.withValues(alpha: 0.35)
                          : Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                // Subtitle with accent color
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isLocked ? 'Solo Premium' : subtitle,
                    style: TextStyle(
                      color: isLocked
                          ? const Color(0xFFFFD700).withValues(alpha: 0.6)
                          : color.withValues(alpha: 0.7),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Lock badge
          if (isLocked)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 9),
                    SizedBox(width: 3),
                    Text(
                      'PRO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class BlinkingTrophyIcon extends StatefulWidget {
  const BlinkingTrophyIcon({super.key});

  @override
  State<BlinkingTrophyIcon> createState() => _BlinkingTrophyIconState();
}

class _BlinkingTrophyIconState extends State<BlinkingTrophyIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withValues(alpha: _animation.value * 0.6),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.emoji_events_rounded,
            color: Colors.amber,
            size: 20,
          ),
        );
      },
    );
  }
}

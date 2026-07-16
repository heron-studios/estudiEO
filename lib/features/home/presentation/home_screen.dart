import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/learning_provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/models/learning_level.dart';
import 'package:learn/models/learning_session.dart';

import 'package:learn/core/widgets/premium_upgrade_dialog.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:learn/core/config/neural_theme.dart';

import 'package:learn/core/services/local_storage_service.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/core/services/bible_service.dart';
import 'package:learn/core/services/limits_service.dart';
import 'package:learn/features/auth/domain/auth_service.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  HomeScreen — Pantalla principal del dashboard neural
//
//  v3 cambios:
//  • Header muestra "EstudiEO  X  APTO/PENDIENTE/INAPTO" al costado del logo.
//  • Misión Diaria integrada directamente en el menú principal.
//  • Consejo psicométrico debajo del botón de misión diaria.
//  • PsicoLearnBanner eliminado; fallidos van a Repasar (SRS) integrado.
// ─────────────────────────────────────────────────────────────────────────────
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPremiumStatus();
    });
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
                  child: Lottie.asset(
                    'assets/lottie/trophy.lottie',
                    repeat: false,
                    fit: BoxFit.contain,
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
        final canTake = await LimitsService.canTakeSimulacro();
        if (!canTake) {
          if (context.mounted) {
            PremiumUpgradeDialog.show(
              context,
              title: 'Límite Semanal Alcanzado',
              message:
                  'Solo puedes realizar 1 simulacro por semana en la versión gratuita. ¡Pásate a Premium para simulacros ilimitados!',
            );
          }
          return;
        }
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
      onTap: () => context.push('/flashcards'),
    );
  }

  Widget _buildAprendizajeTile(BuildContext context, dynamic nt) {
    return _GlassTile(
      icon: Icons.school_rounded,
      color: const Color(0xFFFBBF24),
      gradientColors: const [Color(0xFF2A2010), Color(0xFF1A1508)],
      title: 'Aprendizaje',
      subtitle: 'Modo guiado',
      onTap: () => _startGuidedLearningFlow(context),
    );
  }

  Widget _buildFitnessTile(BuildContext context, dynamic nt) {
    return _GlassTile(
      icon: Icons.directions_run_rounded,
      color: const Color(0xFFF97316),
      gradientColors: const [Color(0xFF2A1A0A), Color(0xFF1A0F05)],
      title: 'Apt. Física',
      subtitle: 'Calcula tu nota',
      onTap: () => context.push('/fitness-calculator'),
    );
  }

  Widget _buildMeritTile(BuildContext context, dynamic nt) {
    return _GlassTile(
      icon: Icons.leaderboard_rounded,
      color: const Color(0xFF6366F1),
      gradientColors: const [Color(0xFF1A1A35), Color(0xFF0F0F25)],
      title: 'Cuadro de\nMérito',
      subtitle: 'Nota ponderada',
      onTap: () => context.push('/merit-calculator'),
    );
  }

  Widget _buildRoadmapTile(BuildContext context, dynamic nt) {
    return _GlassTile(
      icon: Icons.map_rounded,
      color: const Color(0xFF10B981),
      gradientColors: const [Color(0xFF0A2010), Color(0xFF051508)],
      title: 'Hoja de\nRuta',
      subtitle: 'Proceso admisión',
      onTap: () => context.push('/roadmap'),
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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color:
                  (_todayCompleted
                          ? const Color(0xFF4ADE80)
                          : const Color(0xFF7C3AED))
                      .withValues(alpha: 0.25),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
              ),
              child: _todayCompleted
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF4ADE80),
                      size: 26,
                    )
                  : ClipOval(
                      child: Lottie.asset(
                        'assets/lottie/warning_status.lottie',
                        controller: _warningLottieController,
                        onLoaded: (composition) {
                          _warningLottieController.duration =
                              composition.duration;
                          _warningLottieController.forward();
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const SizedBox(width: 14),
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

    // Greeting dinámica
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? '¡Buenos días! ☀️'
        : hour < 18
        ? '¡Buenas tardes! 👋'
        : '¡Buenas noches! 🌙';

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // FAB SRS Repaso
          Consumer<SrsProvider>(
            builder: (context, srs, child) {
              final count = srs.getReviewQueue().length;
              if (count == 0) return const SizedBox.shrink();
              return FadeTransition(
                opacity: _fabAnimation,
                child: FloatingActionButton.extended(
                  heroTag: 'srs_fab',
                  onPressed: () => context.push('/srs-review'),
                  backgroundColor: nt.successGreen,
                  elevation: 8,
                  icon: const Icon(
                    Icons.history_edu_rounded,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Repasar ($count)',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo + Badge + Greeting
                  Expanded(
                    child: Column(
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
                        if (!isLargeScreen) ...[
                          const SizedBox(height: 2),
                          Text(
                            greeting,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Derecha: Botón Hoja de Ruta y Ajustes
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () => context.push('/settings'),
                          icon: const Icon(
                            Icons.settings_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                          tooltip: 'Ajustes',
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // ── CARDS — centradas verticalmente en el espacio restante ──
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 20),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (isLargeScreen) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _buildDailyMissionCard(context, nt),
                                      const SizedBox(height: 10),
                                      _buildSimulacroCard(context, nt),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  flex: 6,
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                    childAspectRatio: 1.15,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      _buildEstudiarTile(context, nt),
                                      _buildTarjetasTile(context, nt),
                                      _buildAprendizajeTile(context, nt),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildDailyMissionCard(context, nt),
                                  const SizedBox(height: 16),
                                  // Fila 1: Estudiar + Tarjetas
                                  Row(
                                    children: [
                                      Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 1.15,
                                          child: _buildEstudiarTile(
                                            context,
                                            nt,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 1.15,
                                          child: _buildTarjetasTile(
                                            context,
                                            nt,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  // Fila 2: Aprendizaje + Simulacro
                                  Row(
                                    children: [
                                      Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 1.15,
                                          child: _buildAprendizajeTile(
                                            context,
                                            nt,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 1.15,
                                          child: _buildSimulacroCard(
                                            context,
                                            nt,
                                            isSquare: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
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

  const _GlassTile({
    required this.icon,
    required this.color,
    required this.gradientColors,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HoverGlassCard(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: color.withValues(alpha: 0.2)),
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
                    color.withValues(alpha: 0.35),
                    color.withValues(alpha: 0.15),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: color.withValues(alpha: 0.4)),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const Spacer(),
            // Title
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
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
                subtitle,
                style: TextStyle(
                  color: color.withValues(alpha: 0.7),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

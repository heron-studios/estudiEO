import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/learning_provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/models/learning_level.dart';
import 'package:learn/models/learning_session.dart';
import 'package:learn/features/alipio/presentation/alipio_selector_screen.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/features/psicolearn/presentation/psico_mission_screen.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:go_router/go_router.dart';

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

class _HomeScreenState extends State<HomeScreen> {
  int _streakDays = 0;
  bool _todayCompleted = false;
  String _diagnosis = 'PENDIENTE';

  @override
  void initState() {
    super.initState();
    _loadPsicoProgress();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadPsicoProgress() {
    final storage = context.read<LocalStorageService>();
    final progress = storage.getPsicoProgress();
    setState(() {
      _streakDays = progress['streak'];
      _todayCompleted = progress['todayCompleted'];
      
      final totalMissions = progress['totalMissions'] ?? 0;
      final lastOverallScore = progress['lastOverallScore'] ?? 0.0;
      
      if (totalMissions == 0) {
        _diagnosis = 'PENDIENTE';
      } else if (lastOverallScore >= 0.70) {
        _diagnosis = 'APTO';
      } else {
        _diagnosis = 'INAPTO';
      }
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
      final subject =
          topic != null ? subjectProvider.getSubject(topic.subjectId) : null;
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
                context
                    .read<LearningProvider>()
                    .resumeSession(topicId, nivel);
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

  Widget _buildSimulacroCard(BuildContext context, dynamic nt) {
    return HoverGlassCard(
      borderRadius: BorderRadius.circular(20),
      onTap: () => context.push('/exam'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          children: [
            _IconBubble(icon: Icons.timer_rounded, color: nt.pink),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Simulacro de Examen',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  SizedBox(height: 2),
                  Text('100 preguntas • 3 horas',
                      style: TextStyle(color: Colors.white60, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white30, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildEstudiarTile(BuildContext context, dynamic nt) {
    return _GlassTile(
      icon: Icons.auto_stories_rounded,
      color: nt.blueGoogle,
      title: 'Estudiar',
      subtitle: 'Por asignatura',
      onTap: () => context.push('/gallery', extra: {'mode': 'quiz'}),
    );
  }

  Widget _buildRepasarTile(BuildContext context, dynamic nt) {
    return Consumer<SrsProvider>(
      builder: (context, srs, _) {
        final count = srs.getReviewQueue().length;
        return _GlassTile(
          icon: Icons.history_edu_rounded,
          color: nt.successGreen,
          title: 'Repasar',
          subtitle: count > 0 ? '$count pendientes' : 'Al día ✓',
          badge: count > 0 ? '$count' : null,
          onTap: () => context.push('/srs-review'),
        );
      },
    );
  }

  Widget _buildTarjetasTile(BuildContext context, dynamic nt) {
    return _GlassTile(
      icon: Icons.style_rounded,
      color: nt.purple,
      title: 'Tarjetas',
      subtitle: 'Memoria',
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AlipioSelectorScreen(),
        ),
      ),
    );
  }

  Widget _buildAprendizajeTile(BuildContext context, dynamic nt) {
    return _GlassTile(
      icon: Icons.school_rounded,
      color: nt.warningAmber,
      title: 'Aprendizaje',
      subtitle: 'Modo Guiado',
      onTap: () => _startGuidedLearningFlow(context),
    );
  }

  Widget _buildMiniAppsCard(BuildContext context, dynamic nt) {
    return HoverGlassCard(
      borderRadius: BorderRadius.circular(20),
      onTap: () => context.push('/miniapps'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          children: [
            _IconBubble(icon: Icons.extension_rounded, color: nt.pink),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mini Apps',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  SizedBox(height: 2),
                  Text('Juegos y Herramientas',
                      style: TextStyle(color: Colors.white60, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white30, size: 20),
          ],
        ),
      ),
    );
  }

  /// Botón de Misión Diaria para el menú principal
  Widget _buildDailyMissionCard(BuildContext context, dynamic nt) {
    return HoverGlassCard(
      onTap: () async {
        if (_todayCompleted) {
          _showAlreadyCompletedDialog(context, nt);
          return;
        }
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const PsicoMissionScreen()),
        );
        if (mounted) _loadPsicoProgress();
      },
      hoverGradientBorder: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          gradient: nt.neuralGradient.scale(0.7),
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
              child: Icon(
                _todayCompleted
                    ? Icons.check_circle_rounded
                    : Icons.stars_rounded,
                color:
                    _todayCompleted ? const Color(0xFF4ADE80) : Colors.amber,
                size: 24,
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
                          fontSize: 14,
                          fontFamily: 'Outfit',
                          letterSpacing: 0.5,
                        ),
                      ),
                      if (_streakDays > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF6F00), Color(0xFFFF9100)],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('🔥',
                                  style: TextStyle(fontSize: 10)),
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
                  const SizedBox(height: 2),
                  Text(
                    _todayCompleted
                        ? '¡Completada! Vuelve mañana.'
                        : '20 preguntas psicométricas para tu perfil.',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.white, size: 12),
            ),
          ],
        ),
      ),
    );
  }

  /// Botón de Examen Médico para el menú principal (reemplaza consejos psicométricos)
  Widget _buildMedicalStudyCard(BuildContext context, dynamic nt) {
    return HoverGlassCard(
      onTap: () {
        context.push('/medical');
      },
      hoverGradientBorder: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: nt.cyan.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: nt.cyan.withValues(alpha: 0.3), width: 1),
              ),
              child: Icon(Icons.health_and_safety_rounded,
                  color: nt.cyan, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        'ESTUDIAR EXAMEN MÉDICO',
                        style: TextStyle(
                          color: nt.cyan,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: nt.cyan.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'NUEVO',
                          style: TextStyle(
                            color: Color(0xFF22D3EE),
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Prepárate para la evaluación médica PNP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.white70, size: 10),
            ),
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    // Colores del estado de diagnóstico
    final diagnosisColor = _diagnosis == 'APTO'
        ? const Color(0xFF10B981)
        : (_diagnosis == 'PENDIENTE'
            ? const Color(0xFFF59E0B)
            : const Color(0xFFEF4444));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // ── HEADER ──────────────────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo + Estado al costado
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'EstudiEO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Separador visual
                            Container(
                              width: 1,
                              height: 18,
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            const SizedBox(width: 10),
                            // Badge de estado psicométrico
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color:
                                    diagnosisColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color:
                                      diagnosisColor.withValues(alpha: 0.5),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                _diagnosis,
                                style: TextStyle(
                                  color: diagnosisColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // No subtitle anymore, keeping it clean
                      ],
                    ),
                  ),
                ],
              ),

              // ── CARDS — centradas verticalmente en el espacio restante ──
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 800) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildDailyMissionCard(context, nt),
                                    const SizedBox(height: 12),
                                    _buildSimulacroCard(context, nt),
                                    const SizedBox(height: 12),
                                    _buildMiniAppsCard(context, nt),
                                    const SizedBox(height: 12),
                                    _buildMedicalStudyCard(context, nt),
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
                                    _buildRepasarTile(context, nt),
                                    _buildTarjetasTile(context, nt),
                                    _buildAprendizajeTile(context, nt),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: ConstrainedBox(
                              constraints:
                                  const BoxConstraints(maxWidth: 400),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildDailyMissionCard(context, nt),
                                  const SizedBox(height: 10),
                                  _buildSimulacroCard(context, nt),
                                  const SizedBox(height: 10),
                                  _buildMiniAppsCard(context, nt),
                                  const SizedBox(height: 10),
                                  _buildMedicalStudyCard(context, nt),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 120,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: _buildEstudiarTile(
                                                context, nt)),
                                        const SizedBox(width: 10),
                                        Expanded(
                                            child: _buildRepasarTile(
                                                context, nt)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 120,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: _buildTarjetasTile(
                                                context, nt)),
                                        const SizedBox(width: 10),
                                        Expanded(
                                            child: _buildAprendizajeTile(
                                                context, nt)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
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
//  _GlassTile — tile cuadrado del grid (Estudiar / Repasar / Tarjetas / etc.)
//  Usa HoverGlassCard para el hover animado.
// ─────────────────────────────────────────────────────────────────────────────
class _GlassTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String? badge;
  final VoidCallback onTap;

  const _GlassTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return HoverGlassCard(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _IconBubble(icon: icon, color: color),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style:
                      const TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ],
            ),
            if (badge != null)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badge!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  _IconBubble — burbuja de icono reusable
// ─────────────────────────────────────────────────────────────────────────────
class _IconBubble extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _IconBubble({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

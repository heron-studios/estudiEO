import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/learning_provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/models/learning_level.dart';
import 'package:learn/models/learning_session.dart';
import 'package:learn/screens/alipio_selector_screen.dart';
import 'package:learn/widgets/neural_background_wrapper.dart';
import 'package:learn/widgets/glass_card_widget.dart';
import 'package:learn/config/neural_theme.dart';
import 'package:learn/services/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  HomeScreen — Pantalla principal del dashboard neural
//
//  Cambios vs. v1:
//  • Todos los colores hardcodeados → NeuralTheme.of(context).*
//  • _GlassCard y _GlassTile → HoverGlassCard con hover animado real
//    (escala 1.018, borde rgba(255,255,255,0.22)), cero rebuilds al padre.
//  • MouseRegion implícito en HoverGlassCard con SystemMouseCursors.click.
//  • _PsicoLearnBanner sigue usando el gradiente neural del tema.
//  • El diálogo "¿Continuar?" usa surfaceElevated del tema.
// ─────────────────────────────────────────────────────────────────────────────
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _getPaternalSurname(String? fullName) {
    if (fullName == null || fullName.trim().isEmpty) return 'POSTULANTE';
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.length <= 1) return parts[0].toUpperCase();
    if (parts.length == 2) return parts[1].toUpperCase();
    return parts[parts.length - 2].toUpperCase();
  }

  void _showProfileSheet(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser;
    final userName = user?.displayName ?? 'Futuro Cadete';
    final userEmail = user?.email ?? 'EstudiEO PNP';
    final nt = NeuralTheme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: nt.surfaceCard.withValues(alpha: 0.85),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              border: Border.all(color: nt.borderSubtle),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userEmail,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _SheetItem(
                    icon: Icons.analytics_rounded,
                    color: nt.warningAmber,
                    label: 'Progreso y Estadísticas',
                    onTap: () {
                      Navigator.pop(ctx);
                      Navigator.pushNamed(context, '/dashboard');
                    },
                  ),
                  _SheetItem(
                    icon: Icons.settings_rounded,
                    color: Colors.white54,
                    label: 'Ajustes',
                    onTap: () {
                      Navigator.pop(ctx);
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                  _SheetItem(
                    icon: Icons.logout_rounded,
                    color: nt.pink,
                    label: 'Cerrar Sesión',
                    onTap: () async {
                      Navigator.pop(ctx);
                      await authService.signOut();
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
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
                Navigator.pushNamed(
                  context,
                  '/gallery',
                  arguments: {'mode': 'guided'},
                );
              },
              child: Text(
                'Ir a materias',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                subjectProvider.selectTopic(topicId);
                learningProvider.resumeSession(topicId, nivel);
                Navigator.pushNamed(
                  context,
                  '/learning-quiz',
                  arguments: {'topicId': topicId, 'nivel': nivel},
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
      Navigator.pushNamed(context, '/gallery', arguments: {'mode': 'guided'});
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final user = authService.currentUser;
    final userName = user?.displayName ?? '';
    final nt = NeuralTheme.of(context);

    return Scaffold(
      backgroundColor: nt.background,
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                // ── HEADER ──────────────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          const SizedBox(height: 2),
                          Text(
                            'Bienvenido postulante ${_getPaternalSurname(userName)}'
                                .trim(),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => _showProfileSheet(context),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.1),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white70,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // ── CARDS — centradas verticalmente en el espacio restante ──
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Simulacro de Examen
                          HoverGlassCard(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () =>
                                Navigator.pushNamed(context, '/exam'),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 14,
                              ),
                              child: Row(
                                children: [
                                  _IconBubble(
                                    icon: Icons.timer_rounded,
                                    color: nt.pink,
                                  ),
                                  const SizedBox(width: 14),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Simulacro de Examen',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          '100 preguntas • 3 horas',
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: Colors.white30,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Banner psicoLearn
                          const _PsicoLearnBanner(),
                          const SizedBox(height: 10),

                          // Row: Estudiar + Repasar
                          SizedBox(
                            height: 120,
                            child: Row(
                              children: [
                                Expanded(
                                  child: _GlassTile(
                                    icon: Icons.auto_stories_rounded,
                                    color: nt.blueGoogle,
                                    title: 'Estudiar',
                                    subtitle: 'Por asignatura',
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      '/gallery',
                                      arguments: {'mode': 'quiz'},
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Consumer<SrsProvider>(
                                    builder: (context, srs, _) {
                                      final count =
                                          srs.getReviewQueue().length;
                                      return _GlassTile(
                                        icon: Icons.history_edu_rounded,
                                        color: nt.successGreen,
                                        title: 'Repasar',
                                        subtitle: count > 0
                                            ? '$count pendientes'
                                            : 'Al día ✓',
                                        badge: count > 0 ? '$count' : null,
                                        onTap: () => Navigator.pushNamed(
                                          context,
                                          '/srs-review',
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Row: Tarjetas + Aprendizaje Guiado
                          SizedBox(
                            height: 120,
                            child: Row(
                              children: [
                                Expanded(
                                  child: _GlassTile(
                                    icon: Icons.style_rounded,
                                    color: nt.purple,
                                    title: 'Tarjetas',
                                    subtitle: 'Memoria',
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const AlipioSelectorScreen(),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _GlassTile(
                                    icon: Icons.school_rounded,
                                    color: nt.warningAmber,
                                    title: 'Aprendizaje',
                                    subtitle: 'Modo Guiado',
                                    badge: 'NUEVO',
                                    onTap: () =>
                                        _startGuidedLearningFlow(context),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  _SheetItem — ítem del bottom sheet de perfil
// ─────────────────────────────────────────────────────────────────────────────
class _SheetItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _SheetItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, color: Colors.white24, size: 20),
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
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
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

// ─────────────────────────────────────────────────────────────────────────────
//  _PsicoLearnBanner — banner de módulo psicoLearn
//  Nota: Este componente actúa como punto de entrada al módulo psicotécnico.
//  El contenido de problemas psicotécnicos (matrices SVG, rotaciones, etc.)
//  debe enviarse a PsicoLearnSvgContainer (glass_card_widget.dart) dentro de
//  la vista de detalle que se abra desde aquí.
// ─────────────────────────────────────────────────────────────────────────────
class _PsicoLearnBanner extends StatelessWidget {
  const _PsicoLearnBanner();

  Future<void> _launchPsicoLearn() async {
    final Uri url = Uri.parse('https://pnp-edu.github.io/PsicoLearn/');
    if (!await launchUrl(url, webOnlyWindowName: '_self')) {
      debugPrint('No se pudo abrir $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: nt.neuralGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: nt.blueGoogle.withValues(alpha: 0.30),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _launchPsicoLearn,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Ícono del módulo psicoLearn
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.psychology_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'psicoLearn',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'PRO',
                              style: TextStyle(
                                color: nt.blueGoogle,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Prepárate para tus exámenes psicométricos y médicos.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white70,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

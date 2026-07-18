import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/models/topic.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/providers/learning_provider.dart';
import 'package:learn/models/learning_level.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/config/neural_design_system.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/services/limits_service.dart';
import 'package:learn/core/widgets/premium_upgrade_dialog.dart';

class TopicGalleryScreen extends StatelessWidget {
  final String subjectId;
  final String mode;

  const TopicGalleryScreen({
    super.key,
    required this.subjectId,
    this.mode = 'quiz',
  });

  @override
  Widget build(BuildContext context) {
    final subjectProvider = context.read<SubjectProvider>();
    final subject = subjectProvider.getSubject(subjectId);
    final topics = subjectProvider.getTopicsBySubject(subjectId);

    return Scaffold(
      backgroundColor: NeuralDesignSystem.background,
      appBar: AppBar(
        title: Text(
          subject?.name ?? 'Temas',
          style: const TextStyle(
            fontFamily: 'Outfit',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: NeuralBackgroundWrapper(
        child: topics.isEmpty
            ? const Center(
                child: Text(
                  'No hay temas disponibles',
                  style: TextStyle(color: Colors.white60),
                ),
              )
            : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    itemCount: topics.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return _TopicTile(
                        topic: topics[index],
                        subjectId: subjectId,
                        index: index,
                        mode: mode,
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}

class _TopicTile extends StatelessWidget {
  final Topic topic;
  final String subjectId;
  final int index;
  final String mode;

  const _TopicTile({
    required this.topic,
    required this.subjectId,
    required this.index,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final bool isPremium =
        authService.currentUser != null && authService.isAuthorized;

    // Usar la cantidad real de preguntas según si es premium o no
    final int dynamicQuestionCount = topic.questionCount;

    final learningProvider = context.read<LearningProvider>();
    final currentLevel = learningProvider.getCurrentLevel(topic.id);
    final allCompleted = Dificultad.values.every(
      (d) => learningProvider.isLevelCompleted(topic.id, d),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: NeuralDesignSystem.surfaceCard.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: () async {
              if (!isPremium) {
                final canAnswer = await LimitsService.canAnswerQuestion();
                if (!canAnswer) {
                  if (context.mounted) {
                    PremiumUpgradeDialog.show(
                      context,
                      title: 'Límite Diario Alcanzado',
                      message:
                          'Has respondido tus 10 preguntas gratuitas de hoy. ¡Vuelve mañana o hazte Premium para estudiar sin límites!',
                    );
                  }
                  return;
                }
              }

              if (mode == 'guided') {
                if (topic.theoryByLevel != null) {
                  if (context.mounted) _startGuidedLearning(context, topic);
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          '¡Próximamente! Estamos preparando el contenido guiado para este tema.',
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }
              } else {
                if (context.mounted) _startQuickQuiz(context, topic);
              }
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: NeuralDesignSystem.blueGoogle.withValues(alpha: 0.2),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  // Index badge
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: NeuralDesignSystem.background.withValues(
                        alpha: 0.8,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: NeuralDesignSystem.blueGoogle,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Name + description
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                topic.name,
                                style: const TextStyle(
                                  color: NeuralDesignSystem.textPrimary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                            if (topic.theoryByLevel != null) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: NeuralDesignSystem.pink.withValues(
                                    alpha: 0.15,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: NeuralDesignSystem.pink.withValues(
                                      alpha: 0.6,
                                    ),
                                    width: 0.8,
                                  ),
                                ),
                                child: const Text(
                                  'NUEVO',
                                  style: TextStyle(
                                    color: NeuralDesignSystem.pink,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (topic.description.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Text(
                            topic.description,
                            style: TextStyle(
                              color: NeuralDesignSystem.textSecondary
                                  .withValues(alpha: 0.7),
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        if (mode == 'guided') ...[
                          const SizedBox(height: 5),
                          _LevelProgressIndicator(
                            topicId: topic.id,
                            allCompleted: allCompleted,
                            currentLevel: currentLevel,
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$dynamicQuestionCount',
                        style: const TextStyle(
                          color: NeuralDesignSystem.blueGoogle,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Outfit',
                        ),
                      ),
                      Text(
                        'preguntas',
                        style: TextStyle(
                          color: NeuralDesignSystem.textSecondary.withValues(
                            alpha: 0.6,
                          ),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.white.withValues(alpha: 0.2),
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _startGuidedLearning(BuildContext context, Topic topic) {
    context.read<SubjectProvider>().selectTopic(topic.id);
    final lp = context.read<LearningProvider>();

    // Check if there is any pending session on any level for this topic
    final pendingLevel = lp.getPendingSessionLevel(topic.id);

    if (pendingLevel != null) {
      final session = lp.getPendingSession(topic.id, pendingLevel);
      final currentQuestionNum = (session?.correctCount ?? 0) + 1;

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF1E1F20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.white12),
          ),
          title: const Row(
            children: [
              Icon(Icons.pending_actions_rounded, color: Colors.orangeAccent),
              SizedBox(width: 10),
              Text(
                'Sesión en Progreso',
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
                'Tienes una práctica pendiente para este tema:',
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
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.name,
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
                            color: pendingLevel.color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: pendingLevel.color.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Text(
                            '${pendingLevel.emoji} Nivel ${pendingLevel.displayName}',
                            style: TextStyle(
                              color: pendingLevel.color,
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
          actionsAlignment: MainAxisAlignment.end,
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          actions: [
            // Botón de Reiniciar
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                lp.resetTopicProgress(topic.id);
                // Iniciar nueva sesión
                context.push(
                  '/learning-theory',
                  extra: {'topicId': topic.id, 'nivel': pendingLevel},
                );
              },
              child: const Text(
                'Reiniciar',
                style: TextStyle(color: Color(0xFFEF4444), fontSize: 13),
              ),
            ),
            // Botón de Ver Teoría
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.push(
                  '/learning-theory',
                  extra: {'topicId': topic.id, 'nivel': pendingLevel},
                );
              },
              child: Text(
                'Ver Teoría',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 13,
                ),
              ),
            ),
            // Botón de Continuar
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                lp.resumeSession(topic.id, pendingLevel);
                context.push(
                  '/learning-quiz',
                  extra: {'topicId': topic.id, 'nivel': pendingLevel},
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ],
        ),
      );
    } else {
      final currentLevel = lp.getCurrentLevel(topic.id);
      context.push(
        '/learning-theory',
        extra: {'topicId': topic.id, 'nivel': currentLevel},
      );
    }
  }

  void _startQuickQuiz(BuildContext context, Topic topic) {
    context.read<SubjectProvider>().selectTopic(topic.id);
    final quizProvider = context.read<QuizProvider>();

    if (quizProvider.hasPendingSessionForTopic(topic.id)) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: const Text(
            'Sesión Pendiente',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Tienes un quiz sin terminar. ¿Qué deseas hacer?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                final allQuestions = context
                    .read<SubjectProvider>()
                    .getAllQuestionsByTopicShuffled(topic.id);
                if (allQuestions.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No hay preguntas para este tema.'),
                    ),
                  );
                  return;
                }
                quizProvider.createSession(
                  topic.id,
                  allQuestions.map((q) => q.id).toList(),
                );
                context.push('/quiz');
              },
              child: const Text(
                'Empezar de nuevo',
                style: TextStyle(color: Color(0xFFF87171)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                quizProvider.resumeSession(topic.id);
                context.push('/quiz');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
              ),
              child: const Text(
                'Continuar respondiendo',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } else {
      final allQuestions = context
          .read<SubjectProvider>()
          .getAllQuestionsByTopicShuffled(topic.id);
      if (allQuestions.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No hay preguntas para este tema.')),
        );
        return;
      }

      final questionIds = allQuestions.map((q) => q.id).toList();
      quizProvider.createSession(topic.id, questionIds);
      context.push('/quiz');
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Widgets de soporte
// ─────────────────────────────────────────────────────────────────────────────

/// Indicador compacto de progreso de niveles del Modo Aprendizaje Guiado.
class _LevelProgressIndicator extends StatelessWidget {
  final String topicId;
  final bool allCompleted;
  final Dificultad currentLevel;

  const _LevelProgressIndicator({
    required this.topicId,
    required this.allCompleted,
    required this.currentLevel,
  });

  @override
  Widget build(BuildContext context) {
    final lp = context.watch<LearningProvider>();

    if (allCompleted) {
      return const Row(
        children: [
          Icon(Icons.star_rounded, color: Color(0xFFFBBF24), size: 13),
          SizedBox(width: 4),
          Text(
            'Maestría alcanzada',
            style: TextStyle(
              color: Color(0xFFFBBF24),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    return Row(
      children: Dificultad.values.map((d) {
        final completed = lp.isLevelCompleted(topicId, d);
        final isCurrent = d == currentLevel && !completed;
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Container(
            width: 20,
            height: 5,
            decoration: BoxDecoration(
              color: completed
                  ? d.color
                  : isCurrent
                  ? d.color.withValues(alpha: 0.4)
                  : const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );
      }).toList(),
    );
  }
}

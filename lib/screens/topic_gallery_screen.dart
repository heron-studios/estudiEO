import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/models/topic.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/providers/learning_provider.dart';
import 'package:learn/models/learning_level.dart';
import 'package:learn/config/app_config.dart';

class TopicGalleryScreen extends StatelessWidget {
  final String subjectId;

  const TopicGalleryScreen({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context) {
    final subjectProvider = context.read<SubjectProvider>();
    final subject = subjectProvider.getSubject(subjectId);
    final topics = subjectProvider.getTopicsBySubject(subjectId);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: Text(
          subject?.name ?? 'Temas',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: topics.isEmpty
          ? const Center(
              child: Text('No hay temas disponibles', style: TextStyle(color: Colors.white60)),
            )
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  itemCount: topics.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return _TopicTile(
                      topic: topics[index],
                      subjectId: subjectId,
                      index: index,
                    );
                  },
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

  const _TopicTile({
    required this.topic,
    required this.subjectId,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // En modo demo, solo el primer tema (index 0) está desbloqueado
    final bool isLocked = AppConfig.isDemoMode && index > 0;
    
    // Usar la cantidad real de preguntas en demo mode
    final int dynamicQuestionCount = AppConfig.isDemoMode 
        ? context.read<SubjectProvider>().getQuestionsByTopic(topic.id).length 
        : topic.questionCount;

    final learningProvider = context.read<LearningProvider>();
    final currentLevel = learningProvider.getCurrentLevel(topic.id);
    final allCompleted = Dificultad.values
        .every((d) => learningProvider.isLevelCompleted(topic.id, d));

    return Material(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () {
          if (isLocked) {
            Navigator.pushNamed(context, '/premium');
            return;
          }
          _showModeSelectionSheet(context, topic, dynamicQuestionCount);
        },
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Index badge
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: isLocked 
                    ? const Icon(Icons.lock, color: Color(0xFF64748B), size: 18)
                    : Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Color(0xFF3B82F6),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
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
                            style: TextStyle(
                              color: isLocked ? Colors.white54 : Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (topic.id == 'cta_materia_energia') ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: const Color(0xFFEF4444), width: 0.8),
                            ),
                            child: const Text(
                              'NUEVO',
                              style: TextStyle(
                                color: Color(0xFFEF4444),
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
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
                        style: const TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    // Indicador de progreso del modo guiado
                    if (!isLocked) ...[
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

              // Question count or lock
              const SizedBox(width: 12),
              if (isLocked)
                 const Column(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: [
                     Icon(Icons.lock_person_rounded, color: Color(0xFFFBBF24), size: 24),
                     Text(
                       'Premium',
                       style: TextStyle(color: Color(0xFFFBBF24), fontSize: 10, fontWeight: FontWeight.bold),
                     ),
                   ],
                 )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$dynamicQuestionCount',
                      style: const TextStyle(
                        color: Color(0xFF3B82F6),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'preguntas',
                      style: TextStyle(color: Color(0xFF64748B), fontSize: 10),
                    ),
                  ],
                ),
              
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: isLocked ? Colors.transparent : const Color(0xFF334155), size: 22),
            ],
          ),
        ),
      ),
    );
  }

  /// Muestra el BottomSheet de selección de modo de estudio.
  void _showModeSelectionSheet(
      BuildContext context, Topic topic, int questionCount) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _ModeSelectionSheet(
        topic: topic,
        questionCount: questionCount,
        onGuidedLearning: () {
          Navigator.pop(ctx);
          _startGuidedLearning(context, topic);
        },
        onQuickQuiz: () {
          Navigator.pop(ctx);
          _startQuickQuiz(context, topic);
        },
      ),
    );
  }

  void _startGuidedLearning(BuildContext context, Topic topic) {
    context.read<SubjectProvider>().selectTopic(topic.id);
    final lp = context.read<LearningProvider>();
    final currentLevel = lp.getCurrentLevel(topic.id);

    Navigator.pushNamed(
      context,
      '/learning-theory',
      arguments: {'topicId': topic.id, 'nivel': currentLevel},
    );
  }

  void _startQuickQuiz(BuildContext context, Topic topic) {
    context.read<SubjectProvider>().selectTopic(topic.id);
    final quizProvider = context.read<QuizProvider>();
    
    if (quizProvider.hasPendingSessionForTopic(topic.id)) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: const Text('Sesión Pendiente', style: TextStyle(color: Colors.white)),
          content: const Text('Tienes un quiz sin terminar. ¿Qué deseas hacer?', style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                final allQuestions = context.read<SubjectProvider>().getAllQuestionsByTopicShuffled(topic.id);
                if (allQuestions.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No hay preguntas para este tema.')));
                  return;
                }
                quizProvider.createSession(topic.id, allQuestions.map((q) => q.id).toList());
                Navigator.pushNamed(context, '/quiz');
              },
              child: const Text('Empezar de nuevo', style: TextStyle(color: Color(0xFFF87171))),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                quizProvider.resumeSession(topic.id);
                Navigator.pushNamed(context, '/quiz');
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
              child: const Text('Continuar respondiendo', style: TextStyle(color: Colors.white)),
            ),
          ],
        )
      );
    } else {
      final allQuestions = context.read<SubjectProvider>().getAllQuestionsByTopicShuffled(topic.id);
      if (allQuestions.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No hay preguntas para este tema.')),
        );
        return;
      }
      
      final questionIds = allQuestions.map((q) => q.id).toList();
      quizProvider.createSession(topic.id, questionIds);
      Navigator.pushNamed(context, '/quiz');
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

/// BottomSheet de selección de modo: Aprendizaje Guiado vs Quiz Rápido.
class _ModeSelectionSheet extends StatelessWidget {
  final Topic topic;
  final int questionCount;
  final VoidCallback onGuidedLearning;
  final VoidCallback onQuickQuiz;

  const _ModeSelectionSheet({
    required this.topic,
    required this.questionCount,
    required this.onGuidedLearning,
    required this.onQuickQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF111827),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Título
          Text(
            topic.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          const Text(
            '¿Cómo quieres estudiar este tema?',
            style: TextStyle(color: Colors.white38, fontSize: 13),
          ),

          const SizedBox(height: 24),

          // Opción 1: Aprendizaje Guiado
          _ModeCard(
            icon: '🎯',
            title: 'Aprendizaje Guiado',
            description: topic.id == 'cta_materia_energia'
                ? 'Lee la teoría, responde 10 preguntas por nivel y avanza de Fácil a Extremo.'
                : 'Próximamente más áreas y temas en este modo.',
            badgeText: topic.id == 'cta_materia_energia' ? 'NUEVO / EXPERIMENTAL' : 'PRÓXIMAMENTE',
            badgeColor: topic.id == 'cta_materia_energia' ? const Color(0xFF3B82F6) : const Color(0xFF64748B),
            borderColor: topic.id == 'cta_materia_energia' ? const Color(0xFF3B82F6) : const Color(0xFF1F2937),
            bgColor: topic.id == 'cta_materia_energia'
                ? const Color(0xFF1E3A8A).withValues(alpha: 0.3)
                : const Color(0xFF1F2937).withValues(alpha: 0.15),
            onTap: topic.id == 'cta_materia_energia'
                ? onGuidedLearning
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('¡Próximamente! Estamos preparando el contenido guiado para este tema.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
          ),

          const SizedBox(height: 12),

          // Opción 2: Quiz Rápido
          _ModeCard(
            icon: '⚡',
            title: 'Quiz Rápido',
            description:
                '$questionCount preguntas aleatorias sin restricciones de nivel.',
            badgeText: null,
            badgeColor: Colors.transparent,
            borderColor: const Color(0xFF1F2937),
            bgColor: const Color(0xFF0F172A),
            onTap: onQuickQuiz,
          ),
        ],
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final String? badgeText;
  final Color badgeColor;
  final Color borderColor;
  final Color bgColor;
  final VoidCallback onTap;

  const _ModeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.badgeText,
    required this.badgeColor,
    required this.borderColor,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (badgeText != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: badgeColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              badgeText!,
                              style: TextStyle(
                                color: badgeColor,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios,
                  color: Colors.white24, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

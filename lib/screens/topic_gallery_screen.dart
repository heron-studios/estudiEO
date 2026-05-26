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
                      mode: mode,
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
  final String mode;

  const _TopicTile({
    required this.topic,
    required this.subjectId,
    required this.index,
    required this.mode,
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
          if (mode == 'guided') {
            if (topic.id == 'cta_materia_energia' ||
                topic.id == 'cta_sistema_solar' ||
                topic.id == 'cta_tabla_periodica' ||
                topic.id == 'cta_vegetales_fotosintesis' ||
                topic.id == 'cta_fenomenos_cambioclimatico' ||
                topic.id == 'pfrh_persona_familia' ||
                topic.id == 'pfrh_derechos_humanos' ||
                topic.id == 'pfrh_identidad_normas') {
              _startGuidedLearning(context, topic);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('¡Próximamente! Estamos preparando el contenido guiado para este tema.'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          } else {
            _startQuickQuiz(context, topic);
          }
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
                        if (topic.id == 'cta_materia_energia' ||
                            topic.id == 'cta_sistema_solar' ||
                            topic.id == 'cta_tabla_periodica' ||
                            topic.id == 'cta_vegetales_fotosintesis' ||
                            topic.id == 'cta_fenomenos_cambioclimatico' ||
                            topic.id == 'pfrh_persona_familia' ||
                            topic.id == 'pfrh_derechos_humanos' ||
                            topic.id == 'pfrh_identidad_normas') ...[
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


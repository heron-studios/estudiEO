import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/models/topic.dart';
import 'package:learn/data/subjects_repository.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/config/app_config.dart';

class TopicGalleryScreen extends StatelessWidget {
  final String subjectId;

  const TopicGalleryScreen({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context) {
    final subject = SubjectsRepository.getSubject(subjectId);
    final topics = SubjectsRepository.getTopicsBySubject(subjectId);

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
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
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
        ? SubjectsRepository.getQuestionsByTopic(topic.id).length 
        : topic.questionCount;

    return Material(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () {
          if (isLocked) {
            Navigator.pushNamed(context, '/premium');
            return;
          }

          context.read<SubjectProvider>().selectTopic(topic.id);
          
          final allQuestions = SubjectsRepository.getAllQuestionsByTopicShuffled(topic.id);
          if (allQuestions.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No hay preguntas para este tema.')),
            );
            return;
          }
          
          final questionIds = allQuestions.map((q) => q.id).toList();
          context.read<QuizProvider>().createSession(topic.id, questionIds);
          
          Navigator.pushNamed(context, '/quiz');
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
                    Text(
                      topic.name,
                      style: TextStyle(
                        color: isLocked ? Colors.white54 : Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
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
}

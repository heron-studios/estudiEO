import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/services/export_service.dart';
import 'package:learn/models/question.dart';
import 'package:learn/data/repository/subjects_repository.dart';

class _SubjectStats {
  final String name;
  final String icon;
  final String color;
  int total = 0;
  int correct = 0;
  int incorrect = 0;
  int omitted = 0;

  _SubjectStats({required this.name, required this.icon, required this.color});
}

class _TopicStats {
  final String name;
  final String subjectName;
  int total = 0;
  int correct = 0;
  int incorrect = 0;

  _TopicStats({required this.name, required this.subjectName});
}

class ExamResultsScreen extends StatefulWidget {
  final Map<String, dynamic> args;

  const ExamResultsScreen({super.key, this.args = const {}});

  @override
  State<ExamResultsScreen> createState() => _ExamResultsScreenState();
}

class _ExamResultsScreenState extends State<ExamResultsScreen> {
  late ConfettiController _confettiController;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = widget.args.isNotEmpty ? widget.args : (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? 
                 GoRouterState.of(context).extra as Map<String, dynamic>? ?? {});
    final score = args['score'] as int? ?? 0;
    final total = args['total'] as int? ?? 1;
    final timeSpent = args['timeSpent'] as int? ?? 0;
    final questions = args['questions'] as List<Question>? ?? [];
    final answers = args['answers'] as Map<String, int>? ?? {};

    final percentage = (score / total) * 100;
    
    if (!_initialized && percentage >= 60) {
      _initialized = true;
      _confettiController.play();
    }
    
    // Format time
    final h = timeSpent ~/ 3600;
    final m = (timeSpent % 3600) ~/ 60;
    final s = timeSpent % 60;
    
    String timeStr = '';
    if (h > 0) timeStr += '${h}h ';
    if (m > 0 || h > 0) timeStr += '${m}m ';
    timeStr += '${s}s';

    Color scoreColor = Colors.redAccent;
    String feedback = 'Debes estudiar más';
    if (percentage >= 80) {
      scoreColor = const Color(0xFF4ADE80);
      feedback = '¡Excelente trabajo!';
    } else if (percentage >= 60) {
      scoreColor = const Color(0xFFFBBF24);
      feedback = 'Aprobado, pero puedes mejorar';
    }

    // Calculate breakdowns
    final Map<String, _SubjectStats> subjectStatsMap = {};
    final Map<String, _TopicStats> topicStatsMap = {};

    for (var q in questions) {
      final topic = SubjectsRepository.getTopic(q.topicId);
      final subjectId = topic?.subjectId ?? 'otro';
      final subject = topic != null ? SubjectsRepository.getSubject(subjectId) : null;
      final subjectName = subject?.name ?? 'Otros';
      final subjectColor = subject?.color ?? '#94A3B8';
      final subjectIcon = subject?.icon ?? '📚';

      final selected = answers[q.id] ?? -1;
      final isCorrect = selected == q.correctAnswer;
      final isOmitted = selected == -1;

      // Subject stats
      subjectStatsMap.putIfAbsent(
        subjectId,
        () => _SubjectStats(name: subjectName, icon: subjectIcon, color: subjectColor),
      );
      subjectStatsMap[subjectId]!.total++;
      if (isCorrect) {
        subjectStatsMap[subjectId]!.correct++;
      } else if (isOmitted) {
        subjectStatsMap[subjectId]!.omitted++;
      } else {
        subjectStatsMap[subjectId]!.incorrect++;
      }

      // Topic stats
      if (topic != null) {
        topicStatsMap.putIfAbsent(
          q.topicId,
          () => _TopicStats(name: topic.name, subjectName: subjectName),
        );
        topicStatsMap[q.topicId]!.total++;
        if (isCorrect) {
          topicStatsMap[q.topicId]!.correct++;
        } else {
          topicStatsMap[q.topicId]!.incorrect++;
        }
      }
    }

    final failedTopics = topicStatsMap.values
        .where((t) => t.incorrect > 0)
        .toList();
    // Sort failedTopics by failure rate (incorrect / total) desc
    failedTopics.sort((a, b) {
      final rateA = a.incorrect / a.total;
      final rateB = b.incorrect / b.total;
      return rateB.compareTo(rateA);
    });

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 550),
                  child: Column(
                    children: [
                      const Text(
                        'RESULTADOS DEL SIMULACRO',
                        style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w800, letterSpacing: 1.5, fontSize: 13),
                      ),
                      const SizedBox(height: 24),
                      
                      // Círculo de puntaje
                      Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: scoreColor.withValues(alpha: 0.1),
                          border: Border.all(color: scoreColor.withValues(alpha: 0.3), width: 8),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$score',
                                style: TextStyle(color: scoreColor, fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'de $total',
                                style: TextStyle(color: scoreColor.withValues(alpha: 0.8), fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Text(
                        feedback,
                        style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      
                      // Tarjeta de tiempo utilizado
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF334155)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.timer, color: Color(0xFF94A3B8), size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Tiempo utilizado: $timeStr',
                              style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Desglose por Materias
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Rendimiento por Materia',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),

                      ...subjectStatsMap.entries.map((entry) {
                        final stats = entry.value;
                        final percent = (stats.correct / stats.total) * 100;
                        final subjectColorHex = stats.color;
                        final colorVal = int.tryParse(subjectColorHex.replaceAll('#', ''), radix: 16) ?? 0xFF3B82F6;
                        final color = Color(colorVal | 0xFF000000);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E293B),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFF334155)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(stats.icon, style: const TextStyle(fontSize: 16)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        stats.name,
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                      ),
                                    ),
                                    Text(
                                      '${stats.correct}/${stats.total}',
                                      style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: stats.total == 0 ? 0 : stats.correct / stats.total,
                                    backgroundColor: const Color(0xFF0F172A),
                                    valueColor: AlwaysStoppedAnimation<Color>(color),
                                    minHeight: 5,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Efectividad: ${percent.toInt()}%',
                                      style: const TextStyle(color: Color(0xFF64748B), fontSize: 11),
                                    ),
                                    Text(
                                      'Correctas: ${stats.correct} | Incorrectas: ${stats.incorrect} | Omitidas: ${stats.omitted}',
                                      style: const TextStyle(color: Color(0xFF64748B), fontSize: 11),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 16),

                      // Desglose de Temas a Reforzar
                      if (failedTopics.isNotEmpty) ...[
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Temas recomendados para reforzar',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7F1D1D).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.info_outline, color: Colors.redAccent, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Prioridades de estudio',
                                    style: TextStyle(color: Colors.red[300], fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ...failedTopics.take(4).map((topic) {
                                final totalFailed = topic.incorrect;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('• ', style: TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.bold)),
                                      Expanded(
                                        child: Text(
                                          '${topic.name} (${topic.subjectName})',
                                          style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 13),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Falladas: $totalFailed de ${topic.total}',
                                        style: const TextStyle(color: Color(0xFFEF4444), fontSize: 13, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Botones de Exportar
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: OutlinedButton.icon(
                                onPressed: () => ExportService.exportExamToPdf(
                                  context,
                                  score: score,
                                  total: total,
                                  timeSpent: timeSpent,
                                  questions: questions,
                                  answers: answers,
                                ),
                                icon: const Icon(Icons.picture_as_pdf_rounded, color: Colors.redAccent, size: 20),
                                label: const Text('PDF', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.white24),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: OutlinedButton.icon(
                                onPressed: () => ExportService.exportExamToWord(
                                  context,
                                  score: score,
                                  total: total,
                                  timeSpent: timeSpent,
                                  questions: questions,
                                  answers: answers,
                                ),
                                icon: const Icon(Icons.description_rounded, color: Colors.blueAccent, size: 20),
                                label: const Text('Word', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.white24),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Botón para revisar respuestas
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.push('/exam-review', extra: {
                              'questions': questions,
                              'answers': answers,
                            });
                          },
                          icon: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 20),
                          label: const Text('Revisar Respuestas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Botón Volver al Inicio
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton.icon(
                          onPressed: () => context.go('/home'),
                          icon: const Icon(Icons.home, size: 20),
                          label: const Text('Volver al Inicio', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3B82F6),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
                numberOfParticles: 50,
                gravity: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

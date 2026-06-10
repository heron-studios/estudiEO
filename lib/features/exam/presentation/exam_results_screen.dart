import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/services/export_service.dart';
import 'package:learn/models/question.dart';

class ExamResultsScreen extends StatefulWidget {
  const ExamResultsScreen({super.key});

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
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? 
                 GoRouterState.of(context).extra as Map<String, dynamic>? ?? {};
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

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'RESULTADOS DEL SIMULACRO',
                    style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w800, letterSpacing: 1.5),
                  ),
                  const SizedBox(height: 32),
                  
                  // Círculo de puntaje
                  Container(
                    width: 180,
                    height: 180,
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
                            style: TextStyle(color: scoreColor, fontSize: 56, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'de $total',
                            style: TextStyle(color: scoreColor.withValues(alpha: 0.8), fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  Text(
                    feedback,
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  
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
                        const Icon(Icons.timer, color: Color(0xFF94A3B8)),
                        const SizedBox(width: 8),
                        Text(
                          'Tiempo utilizado: $timeStr',
                          style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 16),
                        ),
                      ],
                    ),
                  ),
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
                            icon: const Icon(Icons.picture_as_pdf_rounded, color: Colors.redAccent),
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
                            icon: const Icon(Icons.description_rounded, color: Colors.blueAccent),
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
    
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => context.go('/home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Volver al Inicio', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

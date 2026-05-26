import 'package:flutter/material.dart';

class ExamResultsScreen extends StatelessWidget {
  const ExamResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final score = args['score'] as int;
    final total = args['total'] as int;
    final timeSpent = args['timeSpent'] as int;

    final percentage = (score / total) * 100;
    
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
        child: Center(
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
                  const SizedBox(height: 48),
    
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false),
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
      ),
    );
  }
}

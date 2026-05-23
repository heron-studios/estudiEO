import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/data/subjects_repository.dart';

class QuizResultsScreen extends StatelessWidget {
  const QuizResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = context.read<QuizProvider>().sessions;
    final last = sessions.isNotEmpty ? sessions.last : null;

    if (last == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        appBar: AppBar(
          title: const Text('Resultados', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const Center(
          child: Text('No hay resultados', style: TextStyle(color: Colors.white60)),
        ),
      );
    }

    final pct = last.percentage;
    final correct = last.correctCount;
    final total = last.totalQuestions;
    final wrong = total - correct;
    final isGood = pct >= 60;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Column(
          children: [
            // Top header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                children: [
                  // Result emoji
                  Text(
                    isGood ? '🎉' : '📖',
                    style: const TextStyle(fontSize: 64),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${pct.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w900,
                      color: isGood ? const Color(0xFF4ADE80) : const Color(0xFFFB923C),
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isGood ? '¡Buen trabajo!' : 'Sigue practicando',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Stats row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _StatBox(label: 'Correctas', value: '$correct', color: const Color(0xFF4ADE80)),
                  const SizedBox(width: 12),
                  _StatBox(label: 'Incorrectas', value: '$wrong', color: const Color(0xFFF87171)),
                  const SizedBox(width: 12),
                  _StatBox(label: 'Total', value: '$total', color: const Color(0xFF60A5FA)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Progress bar visual
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Precisión', style: TextStyle(color: Colors.white60, fontSize: 13)),
                      Text(
                        '${correct}/${total}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: pct / 100,
                      backgroundColor: const Color(0xFF1E293B),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isGood ? const Color(0xFF4ADE80) : const Color(0xFFFB923C),
                      ),
                      minHeight: 10,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Action buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/gallery', (_) => false),
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Estudiar otro tema',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false),
                      icon: const Icon(Icons.home_rounded),
                      label: const Text('Inicio', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white70,
                        side: const BorderSide(color: Color(0xFF334155), width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatBox({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(color: color, fontSize: 26, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

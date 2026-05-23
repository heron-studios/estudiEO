import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/gamification_provider.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/data/subjects_repository.dart';
import 'package:learn/services/local_storage_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const _bg = Color(0xFF0F172A);
  static const _cardBg = Color(0xFF1E293B);
  static const _border = Color(0xFF334155);
  static const _text = Color(0xFFF1F5F9);
  static const _muted = Color(0xFF94A3B8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Mi Progreso',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resumen SRS
            const Text(
              'REPASO ESPACIADO',
              style: TextStyle(
                color: _muted,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _GeneralStats(),
            const SizedBox(height: 28),

            // Por asignatura
            const Text(
              'POR ASIGNATURA',
              style: TextStyle(
                color: _muted,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _SubjectStats(),
          ],
        ),
      ),
    );
  }
}

class _GeneralStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SrsProvider>(
      builder: (context, srs, _) {
        final stats = srs.globalStats;
        
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B), // _cardBg
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF334155)), // _border
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _StatsRow(
                label: 'Total de tarjetas',
                value: '${stats['total'] ?? 0}',
                color: const Color(0xFF3B82F6), // blue
              ),
              const Divider(color: Color(0xFF334155), height: 20),
              _StatsRow(
                label: 'Nuevas',
                value: '${stats['new'] ?? 0}',
                color: const Color(0xFF60A5FA),
              ),
              _StatsRow(
                label: 'Aprendiendo',
                value: '${stats['learning'] ?? 0}',
                color: const Color(0xFFFBBF24), // amber
              ),
              _StatsRow(
                label: 'Dominadas',
                value: '${stats['mastered'] ?? 0}',
                color: const Color(0xFF4ADE80), // green
              ),
              _StatsRow(
                label: 'Por revisar',
                value: '${stats['overdue'] ?? 0}',
                color: const Color(0xFFF87171), // red
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatsRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatsRow({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFFCBD5E1),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubjectStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quiz, _) {
        final storage = context.read<LocalStorageService>();
        final hiddenSubjects = storage.loadHiddenSubjects();
        final subjects = SubjectsRepository.getAllSubjects()
            .where((s) => !hiddenSubjects.contains(s.id))
            .toList();

        if (subjects.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'No hay asignaturas visibles.\nVe a Ajustes para habilitarlas.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF94A3B8)),
              ),
            ),
          );
        }

        return Column(
          children: subjects.map((subject) {
            final stats = quiz.getTopicStats(subject.id);
            final avg = stats['averagePercentage'] as double? ?? 0;
            final total = stats['totalSessions'] as int? ?? 0;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                border: Border.all(color: const Color(0xFF334155)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(subject.icon, style: const TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject.name,
                          style: const TextStyle(
                              color: Color(0xFFF1F5F9),
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$total quizzes hechos',
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF94A3B8)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4ADE80).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${avg.toStringAsFixed(1)}%',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4ADE80),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

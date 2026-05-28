import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/widgets/neural_background_wrapper.dart';
import 'package:learn/config/neural_design_system.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeuralDesignSystem.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Mi Progreso',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: NeuralBackgroundWrapper(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Repaso espaciado
                    Text(
                      'REPASO ESPACIADO',
                      style: TextStyle(
                        color: NeuralDesignSystem.textSecondary.withValues(alpha: 0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 12),
                    _GeneralStats(),
                    const SizedBox(height: 28),

                    // Por asignatura
                    Text(
                      'POR ASIGNATURA',
                      style: TextStyle(
                        color: NeuralDesignSystem.textSecondary.withValues(alpha: 0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 12),
                    _SubjectStats(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
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

        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                color: NeuralDesignSystem.surfaceCard.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _StatsRow(
                    label: 'Total de tarjetas',
                    value: '${stats['total'] ?? 0}',
                    color: NeuralDesignSystem.blueGoogle,
                  ),
                  Divider(color: Colors.white.withValues(alpha: 0.07), height: 24),
                  _StatsRow(
                    label: 'Nuevas',
                    value: '${stats['new'] ?? 0}',
                    color: NeuralDesignSystem.cyan,
                  ),
                  _StatsRow(
                    label: 'Aprendiendo',
                    value: '${stats['learning'] ?? 0}',
                    color: const Color(0xFFFBBF24),
                  ),
                  _StatsRow(
                    label: 'Dominadas',
                    value: '${stats['mastered'] ?? 0}',
                    color: const Color(0xFF4ADE80),
                  ),
                  _StatsRow(
                    label: 'Por revisar',
                    value: '${stats['overdue'] ?? 0}',
                    color: NeuralDesignSystem.pink,
                  ),
                ],
              ),
            ),
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
      padding: const EdgeInsets.symmetric(vertical: 7),
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
                  color: NeuralDesignSystem.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 13,
                fontFamily: 'Outfit',
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
        final subjects = context.watch<SubjectProvider>().subjects;

        if (subjects.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'No hay asignaturas visibles.\nVe a Ajustes para habilitarlas.',
                textAlign: TextAlign.center,
                style: TextStyle(color: NeuralDesignSystem.textSecondary),
              ),
            ),
          );
        }

        return Column(
          children: subjects.map((subject) {
            final stats = quiz.getSubjectStats(subject.topicIds);
            final avg = stats['averagePercentage'] as double? ?? 0;
            final total = stats['totalSessions'] as int? ?? 0;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: NeuralDesignSystem.surfaceCard.withValues(alpha: 0.55),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: NeuralDesignSystem.blueGoogle.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: NeuralDesignSystem.blueGoogle.withValues(alpha: 0.25)),
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
                                  color: NeuralDesignSystem.textPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'Outfit',
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '$total quizzes hechos',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: NeuralDesignSystem.textSecondary.withValues(alpha: 0.7),
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4ADE80).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xFF4ADE80).withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            '${avg.toStringAsFixed(1)}%',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4ADE80),
                              fontFamily: 'Outfit',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

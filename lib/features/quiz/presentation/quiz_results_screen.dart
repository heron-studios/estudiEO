import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/config/neural_design_system.dart';
import 'package:learn/core/services/export_service.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/models/question.dart';

class QuizResultsScreen extends StatelessWidget {
  const QuizResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = context.read<QuizProvider>().sessions;
    final last = sessions.isNotEmpty ? sessions.last : null;

    if (last == null) {
      return Scaffold(
        backgroundColor: NeuralDesignSystem.background,
        appBar: AppBar(
          title: const Text(
            'Resultados',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const NeuralBackgroundWrapper(
          child: Center(
            child: Text(
              'No hay resultados',
              style: TextStyle(color: Colors.white60),
            ),
          ),
        ),
      );
    }

    final pct = last.percentage;
    final correct = last.correctCount;
    final total = last.totalQuestions;
    final wrong = total - correct;
    final isGood = pct >= 60;

    return Scaffold(
      backgroundColor: NeuralDesignSystem.background,
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  // Top header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                    child: Column(
                      children: [
                        Text(
                          isGood ? '🎉' : '📚',
                          style: const TextStyle(fontSize: 72),
                        ),
                        const SizedBox(height: 16),
                        ShaderMask(
                          shaderCallback: (bounds) => NeuralDesignSystem
                              .neuralGradient
                              .createShader(bounds),
                          child: Text(
                            '${pct.toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontSize: 72,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontFamily: 'Outfit',
                              height: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isGood ? '¡Buen trabajo!' : 'Sigue practicando',
                          style: const TextStyle(
                            color: NeuralDesignSystem.textSecondary,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
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
                        _StatBox(
                          label: 'Correctas',
                          value: '$correct',
                          color: const Color(0xFF4ADE80),
                        ),
                        const SizedBox(width: 12),
                        _StatBox(
                          label: 'Incorrectas',
                          value: '$wrong',
                          color: NeuralDesignSystem.pink,
                        ),
                        const SizedBox(width: 12),
                        _StatBox(
                          label: 'Total',
                          value: '$total',
                          color: NeuralDesignSystem.blueGoogle,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Progress bar visual
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: NeuralDesignSystem.surfaceCard.withValues(
                              alpha: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.08),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Precisión',
                                    style: TextStyle(
                                      color: NeuralDesignSystem.textSecondary
                                          .withValues(alpha: 0.7),
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    '$correct/$total',
                                    style: const TextStyle(
                                      color: NeuralDesignSystem.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      fontFamily: 'Outfit',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: pct / 100,
                                  backgroundColor: NeuralDesignSystem.background
                                      .withValues(alpha: 0.6),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    isGood
                                        ? const Color(0xFF4ADE80)
                                        : const Color(0xFFFB923C),
                                  ),
                                  minHeight: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Action buttons
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: OutlinedButton.icon(
                                  onPressed: () async {
                                    final subjectProvider = context.read<SubjectProvider>();
                                    final questions = last.questionIds
                                        .map((id) => subjectProvider.getQuestion(id))
                                        .whereType<Question>()
                                        .toList();
                                    await ExportService.exportQuizToPdf(context, last, questions);
                                  },
                                  icon: const Icon(Icons.picture_as_pdf_rounded, color: Colors.redAccent),
                                  label: const Text('Exportar PDF', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
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
                                  onPressed: () async {
                                    final subjectProvider = context.read<SubjectProvider>();
                                    final questions = last.questionIds
                                        .map((id) => subjectProvider.getQuestion(id))
                                        .whereType<Question>()
                                        .toList();
                                    await ExportService.exportQuizToWord(context, last, questions);
                                  },
                                  icon: const Icon(Icons.description_rounded, color: Colors.blueAccent),
                                  label: const Text('Exportar Word', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
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
                          height: 54,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: NeuralDesignSystem.neuralGradient,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: NeuralDesignSystem.blueGoogle
                                      .withValues(alpha: 0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/gallery',
                                    (_) => false,
                                  ),
                              icon: const Icon(
                                Icons.refresh_rounded,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Estudiar otro tema',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Outfit',
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/home',
                              (_) => false,
                            ),
                            icon: const Icon(Icons.home_rounded),
                            label: const Text(
                              'Inicio',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Outfit',
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: NeuralDesignSystem.textSecondary,
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.15),
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ],
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

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatBox({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: NeuralDesignSystem.surfaceCard.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withValues(alpha: 0.35)),
            ),
            child: Column(
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Outfit',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: NeuralDesignSystem.textSecondary.withValues(
                      alpha: 0.7,
                    ),
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

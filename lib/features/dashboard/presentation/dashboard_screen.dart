// dart:ui no requerido directamente — StaticGlassContainer y HoverGlassCard lo encapsulan.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:learn/core/config/neural_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  DashboardScreen — "Mi Progreso"
//
//  Navegación / Scroll retention:
//  • El SingleChildScrollView usa PageStorageKey('dashboard_scroll') para que
//    Flutter restaure exactamente la posición al volver de rutas internas.
//
//  Rendimiento:
//  • Las tarjetas de estadística usan StaticGlassContainer (sin hover ni
//    AnimationController). El BackdropFilter sólo se renderiza una vez.
//  • Consumer<SrsProvider> y Consumer<QuizProvider> están al nivel más bajo
//    posible para minimizar el área de rebuild.
// ─────────────────────────────────────────────────────────────────────────────
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return Scaffold(
      backgroundColor: nt.background,
      appBar: AppBar(
        title: const Text('Mi Progreso'),
      ),
      body: NeuralBackgroundWrapper(
        child: SingleChildScrollView(
          // PageStorageKey garantiza que la posición de scroll se conserve
          // cuando el usuario navega a una vista de estudio y regresa.
          key: const PageStorageKey<String>('dashboard_scroll'),
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionLabel('REPASO ESPACIADO'),
                    SizedBox(height: 12),
                    _GeneralStats(),
                    SizedBox(height: 28),
                    _SectionLabel('POR ASIGNATURA'),
                    SizedBox(height: 12),
                    _SubjectStats(),
                    SizedBox(height: 32),
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

// ─────────────────────────────────────────────────────────────────────────────
//  _SectionLabel
// ─────────────────────────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    return Text(
      text,
      style: TextStyle(
        color: nt.textSecondary.withValues(alpha: 0.7),
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
        fontFamily: 'Outfit',
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  _GeneralStats — estadísticas globales SRS
// ─────────────────────────────────────────────────────────────────────────────
class _GeneralStats extends StatelessWidget {
  const _GeneralStats();

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return Consumer<SrsProvider>(
      builder: (context, srs, _) {
        final stats = srs.globalStats;
        return StaticGlassContainer(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              _StatRow(
                label: 'Total de tarjetas',
                value: '${stats['total'] ?? 0}',
                color: nt.blueGoogle,
              ),
              Divider(color: Colors.white.withValues(alpha: 0.07), height: 24),
              _StatRow(
                label: 'Nuevas',
                value: '${stats['new'] ?? 0}',
                color: nt.cyan,
              ),
              _StatRow(
                label: 'Aprendiendo',
                value: '${stats['learning'] ?? 0}',
                color: nt.warningAmber,
              ),
              _StatRow(
                label: 'Dominadas',
                value: '${stats['mastered'] ?? 0}',
                color: nt.successGreen,
              ),
              _StatRow(
                label: 'Por revisar',
                value: '${stats['overdue'] ?? 0}',
                color: nt.pink,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  _StatRow — fila de estadística con dot de color
// ─────────────────────────────────────────────────────────────────────────────
class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatRow({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

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
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: nt.textSecondary,
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

// ─────────────────────────────────────────────────────────────────────────────
//  _SubjectStats — progreso por asignatura
//  Usa HoverGlassCard para el efecto hover de escala + borde iluminado.
// ─────────────────────────────────────────────────────────────────────────────
class _SubjectStats extends StatelessWidget {
  const _SubjectStats();

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return Consumer<QuizProvider>(
      builder: (context, quiz, _) {
        final subjects = context.watch<SubjectProvider>().subjects;

        if (subjects.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'No hay asignaturas visibles.\nVe a Ajustes para habilitarlas.',
                textAlign: TextAlign.center,
                style: TextStyle(color: nt.textSecondary),
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
              child: HoverGlassCard(
                borderRadius: BorderRadius.circular(18),
                blur: 12,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Ícono de asignatura
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: nt.blueGoogle.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: nt.blueGoogle.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Text(
                          subject.icon,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Nombre + sesiones
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subject.name,
                              style: TextStyle(
                                color: nt.textPrimary,
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
                                color: nt.textSecondary.withValues(alpha: 0.7),
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Badge de porcentaje
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: nt.successGreen.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: nt.successGreen.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          '${avg.toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: nt.successGreen,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ),
                    ],
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

// dart:ui no requerido directamente — StaticGlassContainer y HoverGlassCard lo encapsulan.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/services/gemini_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:learn/core/services/export_service.dart';

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

  static Future<void> _exportProgress(BuildContext context, {required bool asPdf}) async {
    // Show a loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final srs = context.read<SrsProvider>();
      final quiz = context.read<QuizProvider>();
      final subjectProvider = context.read<SubjectProvider>();

      final stats = srs.globalStats;
      // Get AI advice
      String advice = 'Alipio está descansando. ¡Sigue estudiando duro!';
      try {
        advice = await GeminiService.darConsejoPersonalizado(stats);
      } catch (e) {
        // Fallback
      }

      // Format subject stats
      final List<Map<String, dynamic>> subjectStatsList = [];
      for (final subject in subjectProvider.subjects) {
        final subStats = quiz.getSubjectStats(subject.topicIds);
        final avg = subStats['averagePercentage'] as double? ?? 0.0;
        final total = subStats['totalSessions'] as int? ?? 0;
        subjectStatsList.add({
          'name': subject.name,
          'icon': subject.icon,
          'totalSessions': total,
          'averagePercentage': avg,
        });
      }

      // Close loading dialog
      if (context.mounted) {
        Navigator.pop(context);

        if (asPdf) {
          await ExportService.exportDashboardToPdf(
            context,
            globalStats: stats,
            alipioAdvice: advice,
            subjectStats: subjectStatsList,
          );
        } else {
          await ExportService.exportDashboardToWord(
            context,
            globalStats: stats,
            alipioAdvice: advice,
            subjectStats: subjectStatsList,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context); // Close loading dialog if open
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al exportar: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Mi Progreso'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_rounded, color: Colors.redAccent),
            tooltip: 'Exportar PDF',
            onPressed: () => _exportProgress(context, asPdf: true),
          ),
          IconButton(
            icon: const Icon(Icons.description_rounded, color: Colors.blueAccent),
            tooltip: 'Exportar Word',
            onPressed: () => _exportProgress(context, asPdf: false),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
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
                    _SectionLabel('CONSEJO DE ALIPIO'),
                    SizedBox(height: 12),
                    _AlipioAdviceSection(),
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
        final int total = stats['total'] ?? 0;
        final int nuevos = stats['new'] ?? 0;
        final int aprendiendo = stats['learning'] ?? 0;
        final int dominadas = stats['mastered'] ?? 0;
        final int porRevisar = stats['overdue'] ?? 0;

        return StaticGlassContainer(
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _StatRow(
                  label: 'Total de tarjetas',
                  value: '$total',
                  color: nt.blueGoogle,
                ),
                Divider(color: Colors.white.withValues(alpha: 0.07), height: 24),
                if (total > 0) ...[
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: [
                          if (nuevos > 0)
                            PieChartSectionData(
                              color: nt.cyan,
                              value: nuevos.toDouble(),
                              title: '$nuevos',
                              radius: 40,
                              titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          if (aprendiendo > 0)
                            PieChartSectionData(
                              color: nt.warningAmber,
                              value: aprendiendo.toDouble(),
                              title: '$aprendiendo',
                              radius: 40,
                              titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          if (dominadas > 0)
                            PieChartSectionData(
                              color: nt.successGreen,
                              value: dominadas.toDouble(),
                              title: '$dominadas',
                              radius: 40,
                              titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          if (porRevisar > 0)
                            PieChartSectionData(
                              color: nt.pink,
                              value: porRevisar.toDouble(),
                              title: '$porRevisar',
                              radius: 45,
                              titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                _StatRow(label: 'Nuevas', value: '$nuevos', color: nt.cyan),
                _StatRow(label: 'Aprendiendo', value: '$aprendiendo', color: nt.warningAmber),
                _StatRow(label: 'Dominadas', value: '$dominadas', color: nt.successGreen),
                _StatRow(label: 'Por revisar', value: '$porRevisar', color: nt.pink),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  _AlipioAdviceSection — Consejo IA dinámico
// ─────────────────────────────────────────────────────────────────────────────
class _AlipioAdviceSection extends StatefulWidget {
  const _AlipioAdviceSection();

  @override
  State<_AlipioAdviceSection> createState() => _AlipioAdviceSectionState();
}

class _AlipioAdviceSectionState extends State<_AlipioAdviceSection> {
  String _advice = 'Cargando consejo...';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAdvice();
  }

  Future<void> _fetchAdvice() async {
    final srs = context.read<SrsProvider>();
    final stats = srs.globalStats;
    try {
      final advice = await GeminiService.darConsejoPersonalizado(stats);
      if (mounted) {
        setState(() {
          _advice = advice;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _advice = 'Alipio está descansando. ¡Sigue estudiando duro!';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    
    return StaticGlassContainer(
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('🤖', style: TextStyle(fontSize: 32)),
            const SizedBox(width: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      _advice,
                      style: TextStyle(
                        color: nt.textPrimary,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                      ),
                    ),
            ),
          ],
        ),
      ),
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

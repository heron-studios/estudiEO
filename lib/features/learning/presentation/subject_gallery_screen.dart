import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/models/subject.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/config/neural_design_system.dart';
import 'package:go_router/go_router.dart';

class SubjectGalleryScreen extends StatelessWidget {
  final String mode;

  const SubjectGalleryScreen({super.key, this.mode = 'quiz'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeuralDesignSystem.background,
      appBar: AppBar(
        title: const Text(
          'Materias',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: NeuralBackgroundWrapper(
        child: Consumer<SubjectProvider>(
          builder: (context, provider, _) {
            final hiddenSubjects = context
                .read<LocalStorageService>()
                .loadHiddenSubjects();
            // En modo guiado, ocultar subjects que no tengan ningún tema con teoría
            final subjects = provider.subjects.where((s) {
              if (hiddenSubjects.contains(s.id)) return false;

              if (mode == 'guided') {
                final subjectTopics = provider.getTopicsBySubject(s.id);
                final hasTheory = subjectTopics.any(
                  (t) => t.theoryByLevel != null,
                );
                if (!hasTheory) return false;
              }

              return true;
            }).toList();

            final screenWidth = MediaQuery.of(context).size.width;

            int crossAxisCount = 2;
            double maxContainerWidth = double.infinity;
            double childAspectRatio = 1.15;

            if (screenWidth > 1200) {
              crossAxisCount = 4;
              maxContainerWidth = 1000;
            } else if (screenWidth > 850) {
              crossAxisCount = 3;
              maxContainerWidth = 800;
              childAspectRatio = 1.25;
            } else if (screenWidth > 600) {
              crossAxisCount = 3;
              childAspectRatio = 1.15;
            }

            return SafeArea(
              top: false,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxContainerWidth),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    child: Builder(
                      builder: (context) {
                        final showMedical = mode == 'quiz';
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.menu_book_rounded,
                                    color: Colors.white70,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Asignaturas',
                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.9,
                                      ),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Outfit',
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16,
                                        childAspectRatio: childAspectRatio,
                                      ),
                                  itemCount: subjects.length,
                                  itemBuilder: (context, index) {
                                    return _SubjectCard(
                                      subject: subjects[index],
                                      mode: mode,
                                    );
                                  },
                                ),
                              ),
                            ),
                            if (showMedical) ...[
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: _MedicalExamBanner(),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final Subject subject;
  final String mode;

  const _SubjectCard({required this.subject, required this.mode});

  @override
  Widget build(BuildContext context) {
    final color = _parseColor(subject.color);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: NeuralDesignSystem.surfaceCard.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(24),
          child: InkWell(
            onTap: () {
              context.read<SubjectProvider>().selectSubject(subject.id);
              context.push(
                '/topics',
                extra: {'subjectId': subject.id, 'mode': mode},
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 1.0,
                ),
                gradient: LinearGradient(
                  colors: [color.withValues(alpha: 0.12), Colors.transparent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ícono simple y elegante
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color.withValues(alpha: 0.15),
                      ),
                      child: Center(
                        child: Text(
                          subject.icon,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        subject.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: color.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Text(
                        '${subject.topicIds.length} temas',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: color.withValues(alpha: 0.8),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _parseColor(String s) {
    final hex = s.replaceAll('#', '');
    if (hex.length == 6) return Color(int.parse('FF$hex', radix: 16));
    return Colors.blue;
  }
}

class _MedicalExamBanner extends StatelessWidget {
  const _MedicalExamBanner();

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF0EA5E9);
    const colorDark = Color(0xFF0284C7);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Material(
          color: NeuralDesignSystem.surfaceCard.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(24),
          child: InkWell(
            onTap: () => context.push('/medical'),
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: color.withValues(alpha: 0.5),
                  width: 1.5,
                ),
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.15),
                    colorDark.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.1),
                    blurRadius: 20,
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Ícono circular
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0EA5E9), Color(0xFF0284C7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0EA5E9).withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.health_and_safety_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Textos (Título y subtítulo)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            const Text(
                              'Examen Médico',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.3,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                '¡IMPORTANTE!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Evaluación obligatoria previa',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Botón / Badge "Simular"
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Iniciar',
                          style: TextStyle(
                            color: Color(0xFF38BDF8),
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.play_arrow_rounded,
                          color: Color(0xFF38BDF8),
                          size: 14,
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

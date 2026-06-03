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
          style: TextStyle(fontFamily: 'Outfit', color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: NeuralBackgroundWrapper(
        child: Consumer<SubjectProvider>(
          builder: (context, provider, _) {
            final hiddenSubjects = context.read<LocalStorageService>().loadHiddenSubjects();
            // En modo guiado, ocultar subjects que no tengan ningún tema con teoría
            final subjects = provider.subjects.where((s) {
              if (hiddenSubjects.contains(s.id)) return false;
              
              if (mode == 'guided') {
                final subjectTopics = provider.getTopicsBySubject(s.id);
                final hasTheory = subjectTopics.any((t) => t.theoryByLevel != null);
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
                    child: GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemCount: subjects.length,
                      itemBuilder: (context, index) {
                        return _SubjectCard(subject: subjects[index], mode: mode);
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
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Material(
          color: NeuralDesignSystem.surfaceCard.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: () {
              context.read<SubjectProvider>().selectSubject(subject.id);
              context.push('/topics', extra: {
                  'subjectId': subject.id,
                  'mode': mode,
                },
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withValues(alpha: 0.35), width: 1.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(subject.icon, style: const TextStyle(fontSize: 26)),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${subject.topicIds.length} temas',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: color.withValues(alpha: 0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
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

  Color _parseColor(String s) {
    final hex = s.replaceAll('#', '');
    if (hex.length == 6) return Color(int.parse('FF$hex', radix: 16));
    return Colors.blue;
  }
}

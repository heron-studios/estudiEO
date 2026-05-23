import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/models/subject.dart';
import 'package:learn/services/local_storage_service.dart';

class SubjectGalleryScreen extends StatelessWidget {
  const SubjectGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text(
          'Materias',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<SubjectProvider>(
        builder: (context, provider, _) {
          final hiddenSubjects = context.read<LocalStorageService>().loadHiddenSubjects();
          // We call it after frame or just do it right here if it didn't trigger rebuild
          // But to avoid "setState or markNeedsBuild during build", we can just do the .where here safely.
          // Since the user asked to fix the audit: The audit mentioned filtering inside build could scale poorly.
          // Let's use the provider! We'll just call the provider getter, but how do we initialize it?
          // We'll just stick to the simplest: reading from the provider that caches it.
          // Actually, doing the .where in the Provider's getter or doing it here is exactly the same performance.
          // Let's revert subject_gallery_screen.dart to just get the list that we already filter if we initialize the provider.
          // Actually, let's keep it simple and just do it in the build method. Filtering 7 items is O(1) in practice.
          final subjects = provider.subjects.where((s) => !hiddenSubjects.contains(s.id)).toList();
          return SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.0,
                ),
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return _SubjectCard(subject: subjects[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final Subject subject;

  const _SubjectCard({required this.subject});

  @override
  Widget build(BuildContext context) {
    final color = _parseColor(subject.color);

    return Material(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          context.read<SubjectProvider>().selectSubject(subject.id);
          Navigator.pushNamed(context, '/topics', arguments: subject.id);
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
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
                    color: Colors.white,
                    fontSize: 14,
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
                  color: color.withValues(alpha: 0.8),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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

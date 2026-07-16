import 'package:flutter/material.dart';
import 'package:learn/core/widgets/animated_grid_bg.dart';
import 'package:learn/core/services/bible_service.dart';

class ProfessionalSplash extends StatelessWidget {
  const ProfessionalSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: AnimatedGridBackground(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gradient App Name
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF60A5FA), Color(0xFFC084FC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    'EDUPOL',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Professional Loading Bar
                const SizedBox(
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      color: Color(0xFF3B82F6),
                      backgroundColor: Color(0xFF1E293B),
                      minHeight: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Subtitle
                Text(
                  'Cargando tu preparación académica...',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 48),

                // Bible Verse
                FutureBuilder<String?>(
                  future: BibleService.getDailyVerse(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(height: 60);
                    }
                    if (snapshot.hasData && snapshot.data != null) {
                      final text = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          text,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

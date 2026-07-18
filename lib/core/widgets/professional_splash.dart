import 'package:flutter/material.dart';
import 'package:learn/core/services/bible_service.dart';
import 'package:learn/core/widgets/animated_grid_bg.dart';
import 'dart:ui';

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
                // Logo & Loader entry animation
                RepaintBoundary(
                  child: Semantics(
                    label: 'Pantalla de carga de EDUPOL',
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOutExpo,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 0.9 + (0.1 * value),
                          child: Opacity(
                            opacity: value,
                            child: child,
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F172A).withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.15),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF60A5FA).withValues(alpha: 0.15),
                                  blurRadius: 60,
                                  spreadRadius: -5,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Glowing App Name
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFC084FC).withValues(alpha: 0.3),
                                        blurRadius: 30,
                                        spreadRadius: -10,
                                      ),
                                    ],
                                  ),
                                  child: ShaderMask(
                                    shaderCallback: (bounds) => const LinearGradient(
                                      colors: [Color(0xFF60A5FA), Color(0xFFC084FC)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ).createShader(bounds),
                                    child: const Text(
                                      'EDUPOL',
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        letterSpacing: 6,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 48),
                                
                                // Premium Glass Loading Bar
                                Semantics(
                                  label: 'Cargando contenido',
                                  child: Container(
                                    width: 180,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0F172A).withValues(alpha: 0.6),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: 0.2),
                                        width: 1,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: const ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                      child: LinearProgressIndicator(
                                        color: Color(0xFF60A5FA),
                                        backgroundColor: Colors.transparent,
                                        minHeight: 8,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                
                                // Subtitle
                                Text(
                                  'Preparando tu entorno...',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    fontSize: 14,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 60),

                // Bible Verse with subtle fade
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: child,
                    );
                  },
                  child: FutureBuilder<String?>(
                    future: BibleService.getDailyVerse(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(height: 60);
                      }
                      if (snapshot.hasData && snapshot.data != null) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 40),
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F172A).withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  width: 1.0,
                                ),
                              ),
                              child: Text(
                                snapshot.data!,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  height: 1.6,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
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

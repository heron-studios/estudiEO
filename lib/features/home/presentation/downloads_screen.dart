import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/animated_grid_bg.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    
    return Scaffold(
      backgroundColor: nt.background,
      body: AnimatedGridBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white70),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'Descargas Nativas',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Lleva EDUPOL RADAR al siguiente nivel',
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Instala nuestras aplicaciones nativas para obtener un rendimiento superior, notificaciones push reales y un entorno sin distracciones.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      _buildDownloadCard(
                        nt: nt,
                        icon: Icons.android_rounded,
                        color: const Color(0xFF3DDC84),
                        title: 'Android APK (Universal)',
                        subtitle: 'Instalador directo compatible con cualquier celular Android. No requiere Play Store.',
                        size: '~35 MB',
                        url: 'https://github.com/pnp-edu/estudiEO/releases/download/v1.0.0-release/app-release.apk',
                      ),
                      
                      const SizedBox(height: 20),
                      
                      _buildDownloadCard(
                        nt: nt,
                        icon: Icons.shop_rounded,
                        color: const Color(0xFF4285F4),
                        title: 'Android App Bundle (AAB)',
                        subtitle: 'Formato optimizado para publicación. Si deseas subirlo tú mismo o probar la versión bundle.',
                        size: '~38 MB',
                        url: 'https://github.com/pnp-edu/estudiEO/releases/download/v1.0.0-release/app-release.aab',
                      ),
                      
                      const SizedBox(height: 20),
                      
                      _buildDownloadCard(
                        nt: nt,
                        icon: Icons.laptop_mac_rounded,
                        color: const Color(0xFFA2AAAD),
                        title: 'macOS Desktop',
                        subtitle: 'Aplicación nativa para Mac (Intel y Apple Silicon).',
                        size: '~60 MB',
                        url: 'https://github.com/pnp-edu/estudiEO/releases/download/v1.0.0-release/estudiEO-macOS.zip',
                      ),
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadCard({
    required NeuralThemeData nt,
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String size,
    required String url,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: nt.surfaceElevated.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _launchUrl(url),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: color.withValues(alpha: 0.5)),
                      ),
                      child: Icon(icon, color: color, size: 32),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Outfit',
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  size,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(Icons.download_rounded, color: color, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                'Descargar Archivo',
                                style: TextStyle(
                                  color: color,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/animated_grid_bg.dart';

/// Pantalla premium para descargas nativas de EDUPOL (Windows, macOS, Android APK).
class DownloadsScreen extends StatefulWidget {
  final bool showBackButton;

  const DownloadsScreen({
    super.key,
    this.showBackButton = true,
  });

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  // URLs de descarga configurables (listas para recibir los enlaces del usuario)
  static const String? _windowsUrl = null;
  static const String? _macUrl = null;
  static const String? _androidUrl = null;

  Future<void> _handleDownload(String platformName, String? url) async {
    if (url != null && url.isNotEmpty) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return;
      }
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF1E293B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
        ),
        margin: const EdgeInsets.all(20),
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.hourglass_top_rounded,
                color: Colors.blueAccent,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enlace para $platformName en preparación',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'El instalador oficial se habilitará en breve.',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    final isDesktop = MediaQuery.sizeOf(context).width > 900;

    return Scaffold(
      backgroundColor: nt.background,
      body: AnimatedGridBackground(
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── Header Bar ──────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      if (widget.showBackButton && context.canPop()) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.12),
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                onPressed: () => context.pop(),
                                tooltip: 'Volver',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                      // Logo & Breadcrumb
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'EDUPOL',
                                style: TextStyle(
                                  color: nt.textPrimary,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'OFICIAL',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Centro de Descargas Multiplataforma',
                            style: TextStyle(
                              color: nt.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // ── Hero Section ─────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF1E1B4B).withValues(alpha: 0.7),
                              const Color(0xFF0F172A).withValues(alpha: 0.85),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.purpleAccent.withValues(alpha: 0.25),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purpleAccent.withValues(alpha: 0.12),
                              blurRadius: 32,
                              spreadRadius: 0,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.purpleAccent.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.purpleAccent.withValues(alpha: 0.35),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.devices_rounded,
                                    color: Colors.purpleAccent,
                                    size: 16,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'APLICACIÓN NATIVA 100% OPTIMIZADA',
                                    style: TextStyle(
                                      color: Colors.purpleAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Instala EDUPOL en todos tus dispositivos',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Outfit',
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Disfruta de máxima velocidad, cero latencia, atajos de teclado y funcionamiento sin interrupciones. Elige tu sistema operativo y lleva tu preparación policial al nivel más alto.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ── Platform Cards (Windows, Mac, Android) ────────────────────
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: isDesktop
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _buildWindowsCard(context, nt),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildMacCard(context, nt),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildAndroidCard(context, nt),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _buildWindowsCard(context, nt),
                                const SizedBox(height: 16),
                                _buildMacCard(context, nt),
                                const SizedBox(height: 16),
                                _buildAndroidCard(context, nt),
                              ],
                            ),
                    ),
                  ),
                ),
              ),

              // ── Quick Guide & Features Section ───────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A).withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.lightbulb_rounded,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Instrucciones de Instalación Rápida',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: 'Outfit',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildInstructionRow(
                              icon: Icons.window_rounded,
                              color: const Color(0xFF00A4EF),
                              platform: 'Windows:',
                              text:
                                  'Descarga el instalador .exe. Si aparece "Windows protegió su PC", presiona "Más información" y luego "Ejecutar de todas formas".',
                            ),
                            const Divider(color: Colors.white10, height: 24),
                            _buildInstructionRow(
                              icon: Icons.laptop_mac_rounded,
                              color: const Color(0xFF9CA3AF),
                              platform: 'macOS:',
                              text:
                                  'Abre el archivo descargado y arrastra EDUPOL a tu carpeta de Aplicaciones. Si macOS bloquea la apertura, ve a Preferencias > Seguridad y haz clic en "Abrir de todos modos".',
                            ),
                            const Divider(color: Colors.white10, height: 24),
                            _buildInstructionRow(
                              icon: Icons.android_rounded,
                              color: const Color(0xFF22C55E),
                              platform: 'Android APK:',
                              text:
                                  'Descarga el archivo APK universal en tu celular. Al abrirlo, habilita "Permitir desde esta fuente" en los ajustes de seguridad de tu navegador para completar la instalación.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Card de Windows ────────────────────────────────────────────────────────
  Widget _buildWindowsCard(BuildContext context, NeuralThemeData nt) {
    return _DownloadCardLayout(
      accentColor: const Color(0xFF0078D7),
      icon: Icons.window_rounded,
      tag: 'PC DESKTOP',
      title: 'Windows',
      subtitle: 'Windows 10 / 11 · 64-bit',
      fileType: 'Instalador (.exe)',
      bullets: const [
        'Rendimiento ultra fluido nativo',
        'Atajos de teclado tácticos',
        'Soporte completo sin navegador',
      ],
      buttonLabel: 'Descargar para Windows',
      buttonIcon: Icons.download_rounded,
      onPressed: () => _handleDownload('Windows', _windowsUrl),
    );
  }

  // ── Card de macOS ──────────────────────────────────────────────────────────
  Widget _buildMacCard(BuildContext context, NeuralThemeData nt) {
    return _DownloadCardLayout(
      accentColor: const Color(0xFFA1A1AA),
      icon: Icons.laptop_mac_rounded,
      tag: 'MAC DESKTOP',
      title: 'macOS',
      subtitle: 'Apple Silicon & Intel',
      fileType: 'Paquete Universal (.dmg / .zip)',
      bullets: const [
        'Optimizado para chips M1, M2, M3 y M4',
        'Integración con gestos de Mac',
        'Diseño visual Retina de alta fidelidad',
      ],
      buttonLabel: 'Descargar para Mac',
      buttonIcon: Icons.download_rounded,
      onPressed: () => _handleDownload('macOS', _macUrl),
    );
  }

  // ── Card de Android ────────────────────────────────────────────────────────
  Widget _buildAndroidCard(BuildContext context, NeuralThemeData nt) {
    return _DownloadCardLayout(
      accentColor: const Color(0xFF22C55E),
      icon: Icons.android_rounded,
      tag: 'MÓVIL & TABLET',
      title: 'Android APK',
      subtitle: 'Android 8.0 o superior',
      fileType: 'APK Directa Universal',
      isPromoted: true,
      bullets: const [
        'Estudia en cualquier momento y lugar',
        'Misión Diaria con recordatorios tácticos',
        'Instalación directa sin depender de tiendas',
      ],
      buttonLabel: 'Descargar APK Android',
      buttonIcon: Icons.android_rounded,
      onPressed: () => _handleDownload('Android', _androidUrl),
    );
  }

  Widget _buildInstructionRow({
    required IconData icon,
    required Color color,
    required String platform,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: '$platform ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: text),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Componente modular reutilizable para cada tarjeta de plataforma
class _DownloadCardLayout extends StatelessWidget {
  final Color accentColor;
  final IconData icon;
  final String tag;
  final String title;
  final String subtitle;
  final String fileType;
  final List<String> bullets;
  final String buttonLabel;
  final IconData buttonIcon;
  final VoidCallback onPressed;
  final bool isPromoted;

  const _DownloadCardLayout({
    required this.accentColor,
    required this.icon,
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.fileType,
    required this.bullets,
    required this.buttonLabel,
    required this.buttonIcon,
    required this.onPressed,
    this.isPromoted = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B).withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isPromoted
                  ? accentColor.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.12),
              width: isPromoted ? 1.8 : 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(alpha: isPromoted ? 0.2 : 0.08),
                blurRadius: 28,
                spreadRadius: 0,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Icon + Tag
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          accentColor.withValues(alpha: 0.25),
                          accentColor.withValues(alpha: 0.08),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Icon(icon, color: accentColor, size: 30),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Title & Subtitle
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Outfit',
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 12),

              // File format chip
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  fileType,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Bullets
              ...bullets.map(
                (bullet) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        color: accentColor,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          bullet,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Action Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: onPressed,
                  icon: Icon(buttonIcon, size: 18),
                  label: Text(
                    buttonLabel,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPromoted
                        ? accentColor
                        : Colors.white.withValues(alpha: 0.1),
                    foregroundColor: Colors.white,
                    elevation: isPromoted ? 6 : 0,
                    shadowColor: accentColor.withValues(alpha: 0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(
                        color: isPromoted
                            ? Colors.transparent
                            : Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

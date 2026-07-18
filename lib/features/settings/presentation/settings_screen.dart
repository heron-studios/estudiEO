import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/gamification_provider.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/core/config/neural_design_system.dart';
import 'package:learn/core/config/app_config.dart';
import 'package:learn/features/dashboard/domain/leaderboard_service.dart';
import 'package:learn/core/services/audio_service.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Neural design tokens (via NeuralDesignSystem)
  static const _cardBg = NeuralDesignSystem.surfaceCard;
  static const _text = NeuralDesignSystem.textPrimary;
  static const _muted = NeuralDesignSystem.textSecondary;
  static const _blue = NeuralDesignSystem.blueGoogle;

  late List<String> _hiddenSubjects;
  @override
  void initState() {
    super.initState();
    final storage = context.read<LocalStorageService>();
    _hiddenSubjects = storage.loadHiddenSubjects();
  }

  Future<void> _launchWhatsApp() async {
    final urlStr =
        'https://wa.me/${AppConfig.whatsappNumber}?text=${Uri.encodeComponent("Hola, necesito soporte con la plataforma EDUPOL.")}';
    final uri = Uri.parse(urlStr);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _toggleSubject(String subjectId, bool isVisible) {
    setState(() {
      if (!isVisible) {
        if (!_hiddenSubjects.contains(subjectId)) {
          _hiddenSubjects.add(subjectId);
        }
      } else {
        _hiddenSubjects.remove(subjectId);
      }
    });
    context.read<LocalStorageService>().saveHiddenSubjects(_hiddenSubjects);
    context.read<SubjectProvider>().updateVisibleSubjects();
  }

  void _exportProgress() {
    final storage = context.read<LocalStorageService>();
    final bundle = storage.getDataBundle();
    final jsonString = jsonEncode(bundle);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: NeuralDesignSystem.surfaceCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Exportar Progreso',
          style: TextStyle(
            color: _text,
            fontFamily: 'Outfit',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Copia este código de seguridad y guárdalo en un lugar seguro. Podrás usarlo para restaurar tu progreso más tarde.',
              style: TextStyle(
                color: _muted.withValues(alpha: 0.8),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              constraints: const BoxConstraints(maxHeight: 120),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: NeuralDesignSystem.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: SingleChildScrollView(
                child: Text(
                  jsonString,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontFamily: 'monospace',
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cerrar', style: TextStyle(color: _muted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: jsonString));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Código de progreso copiado al portapapeles.',
                  ),
                  backgroundColor: _blue,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            child: const Text(
              'Copiar Código',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _importProgress() {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: NeuralDesignSystem.surfaceCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Importar Progreso',
          style: TextStyle(
            color: _text,
            fontFamily: 'Outfit',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pega el código de progreso que exportaste anteriormente para restaurar tus datos.',
              style: TextStyle(
                color: _muted.withValues(alpha: 0.8),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: textController,
              maxLines: 4,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
              decoration: InputDecoration(
                hintText: 'Pega tu código aquí...',
                hintStyle: const TextStyle(color: Colors.white30),
                fillColor: NeuralDesignSystem.background,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: _blue),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar', style: TextStyle(color: _muted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF16A34A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              final jsonString = textController.text.trim();
              if (jsonString.isEmpty) return;

              try {
                final bundle = jsonDecode(jsonString) as Map<String, dynamic>;
                context.read<LocalStorageService>().applyDataBundle(bundle);

                context.read<SrsProvider>().resetAll();
                context.read<GamificationProvider>().reset();
                context.read<QuizProvider>().clearSessions();
                context.read<SubjectProvider>().reload();

                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Progreso restaurado correctamente.'),
                    backgroundColor: const Color(0xFF16A34A),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Error al importar. Código inválido.'),
                    backgroundColor: NeuralDesignSystem.pink,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }
            },
            child: const Text(
              'Importar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allSubjects = context.watch<SubjectProvider>().allSubjects;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Ajustes',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Section: Perfil
              Text(
                'PERFIL DEL ASPIRANTE',
                style: TextStyle(
                  color: _muted.withValues(alpha: 0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  fontFamily: 'Outfit',
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _cardBg.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.person, color: _blue),
                      title: const Text('Editar Perfil y Escuela', style: TextStyle(color: _text)),
                      subtitle: const Text('Actualiza tu nombre y escuela objetivo', style: TextStyle(color: _muted, fontSize: 12)),
                      trailing: const Icon(Icons.chevron_right, color: _muted),
                      onTap: _showEditProfileDialog,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Section: Asignaturas
              Text(
                'VISIBILIDAD DE ASIGNATURAS',
                style: TextStyle(
                  color: _muted.withValues(alpha: 0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  fontFamily: 'Outfit',
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _cardBg.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Column(
                      children: allSubjects.map((subject) {
                        final isVisible = !_hiddenSubjects.contains(subject.id);
                        return SwitchListTile(
                          title: Row(
                            children: [
                              Text(
                                subject.icon,
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  subject.name,
                                  style: const TextStyle(
                                    color: _text,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          value: isVisible,
                          onChanged: (val) => _toggleSubject(subject.id, val),
                          activeThumbColor: _blue,
                          activeTrackColor: _blue.withValues(alpha: 0.3),
                          inactiveThumbColor: _muted,
                          inactiveTrackColor: NeuralDesignSystem.background,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Section: Preferencias
              Text(
                'PREFERENCIAS',
                style: TextStyle(
                  color: _muted.withValues(alpha: 0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  fontFamily: 'Outfit',
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _cardBg.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Consumer<AudioService>(
                      builder: (context, audioService, _) {
                        return SwitchListTile(
                          title: const Row(
                            children: [
                              Icon(
                                Icons.volume_up_rounded,
                                size: 20,
                                color: _text,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Efectos de sonido (SFX)',
                                  style: TextStyle(
                                    color: _text,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          value: !audioService.isMuted,
                          onChanged: (_) => audioService.toggleMute(),
                          activeThumbColor: _blue,
                          activeTrackColor: _blue.withValues(alpha: 0.3),
                          inactiveThumbColor: _muted,
                          inactiveTrackColor: NeuralDesignSystem.background,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Section: Datos
              Text(
                'DATOS',
                style: TextStyle(
                  color: _muted.withValues(alpha: 0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  fontFamily: 'Outfit',
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _cardBg.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: _exportProgress,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _blue.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _blue.withValues(alpha: 0.25),
                              ),
                            ),
                            child: const Icon(
                              Icons.download_rounded,
                              color: _blue,
                              size: 22,
                            ),
                          ),
                          title: const Text(
                            'Exportar progreso',
                            style: TextStyle(
                              color: _text,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Inter',
                            ),
                          ),
                          subtitle: Text(
                            'Copia de seguridad del progreso',
                            style: TextStyle(
                              color: _muted.withValues(alpha: 0.7),
                              fontSize: 13,
                            ),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: _muted.withValues(alpha: 0.5),
                          ),
                        ),
                        Divider(
                          color: Colors.white.withValues(alpha: 0.06),
                          height: 1,
                        ),
                        ListTile(
                          onTap: _importProgress,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF16A34A,
                              ).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(
                                  0xFF16A34A,
                                ).withValues(alpha: 0.25),
                              ),
                            ),
                            child: const Icon(
                              Icons.upload_rounded,
                              color: Color(0xFF4ADE80),
                              size: 22,
                            ),
                          ),
                          title: const Text(
                            'Importar progreso',
                            style: TextStyle(
                              color: _text,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Inter',
                            ),
                          ),
                          subtitle: Text(
                            'Restaurar copia de seguridad',
                            style: TextStyle(
                              color: _muted.withValues(alpha: 0.7),
                              fontSize: 13,
                            ),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: _muted.withValues(alpha: 0.5),
                          ),
                        ),
                        Divider(
                          color: Colors.white.withValues(alpha: 0.06),
                          height: 1,
                        ),
                        ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                backgroundColor: NeuralDesignSystem.surfaceCard,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: const Text(
                                  'Borrar todo el progreso',
                                  style: TextStyle(
                                    color: _text,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(
                                  'Esto eliminará tu racha, historial de tarjetas (SRS) y estadísticas. ¿Estás seguro?',
                                  style: TextStyle(
                                    color: _muted.withValues(alpha: 0.8),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text(
                                      'Cancelar',
                                      style: TextStyle(color: _muted),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<LocalStorageService>()
                                          .clearAll();
                                      context.read<SrsProvider>().resetAll();
                                      context
                                          .read<GamificationProvider>()
                                          .reset();
                                      context
                                          .read<QuizProvider>()
                                          .clearSessions();
                                      context.read<SubjectProvider>().reload();
                                      Navigator.pop(ctx);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                            'Progreso borrado.',
                                          ),
                                          backgroundColor:
                                              NeuralDesignSystem.pink,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Borrar',
                                      style: TextStyle(
                                        color: NeuralDesignSystem.pink,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: NeuralDesignSystem.pink.withValues(
                                alpha: 0.12,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: NeuralDesignSystem.pink.withValues(
                                  alpha: 0.25,
                                ),
                              ),
                            ),
                            child: const Icon(
                              Icons.delete_forever_rounded,
                              color: NeuralDesignSystem.pink,
                              size: 22,
                            ),
                          ),
                          title: const Text(
                            'Borrar progreso',
                            style: TextStyle(
                              color: _text,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Inter',
                            ),
                          ),
                          subtitle: Text(
                            'Rachas, niveles y tarjetas',
                            style: TextStyle(
                              color: _muted.withValues(alpha: 0.7),
                              fontSize: 13,
                            ),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: _muted.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Section: Cuenta
              Text(
                'CUENTA',
                style: TextStyle(
                  color: _muted.withValues(alpha: 0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  fontFamily: 'Outfit',
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _cardBg.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: _launchWhatsApp,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF25D366,
                              ).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(
                                  0xFF25D366,
                                ).withValues(alpha: 0.25),
                              ),
                            ),
                            child: const Icon(
                              Icons.support_agent_rounded,
                              color: Color(0xFF25D366),
                              size: 22,
                            ),
                          ),
                          title: const Text(
                            'Soporte Técnico',
                            style: TextStyle(
                              color: _text,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Inter',
                            ),
                          ),
                          subtitle: Text(
                            'Contáctanos por WhatsApp',
                            style: TextStyle(
                              color: _muted.withValues(alpha: 0.7),
                              fontSize: 13,
                            ),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: _muted.withValues(alpha: 0.5),
                          ),
                        ),
                        Divider(
                          color: Colors.white.withValues(alpha: 0.06),
                          height: 1,
                        ),
                        ListTile(
                          onTap: () async {
                            final authService = context.read<AuthService>();
                            Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst);
                            await authService.signOut();
                          },
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: NeuralDesignSystem.pink.withValues(
                                alpha: 0.12,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: NeuralDesignSystem.pink.withValues(
                                  alpha: 0.25,
                                ),
                              ),
                            ),
                            child: const Icon(
                              Icons.logout_rounded,
                              color: NeuralDesignSystem.pink,
                              size: 22,
                            ),
                          ),
                          title: const Text(
                            'Cerrar sesión',
                            style: TextStyle(
                              color: _text,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Inter',
                            ),
                          ),
                          subtitle: Text(
                            'Salir de tu cuenta de Google',
                            style: TextStyle(
                              color: _muted.withValues(alpha: 0.7),
                              fontSize: 13,
                            ),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: _muted.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditProfileDialog() {
    final storage = context.read<LocalStorageService>();
    final nameController = TextEditingController(text: storage.loadUserName());
    String selectedSchool = storage.loadTargetSchool();
    bool isLoading = false;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: _cardBg,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Text('Editar Perfil', style: TextStyle(color: _text, fontFamily: 'Outfit', fontWeight: FontWeight.bold)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tu nombre o alias', style: TextStyle(color: _muted, fontSize: 14)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: _text),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black26,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Escuela a la que postulas', style: TextStyle(color: _muted, fontSize: 14)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedSchool,
                    dropdownColor: _cardBg,
                    style: const TextStyle(color: _text),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black26,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                    ),
                    items: const [
                      DropdownMenuItem<String>(value: 'EO PNP', child: Text('EO PNP')),
                      DropdownMenuItem<String>(value: 'EETSPN', child: Text('EETSPN')),
                    ],
                    onChanged: (newValue) {
                      setState(() {
                        selectedSchool = newValue!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
                else
                  ElevatedButton(
                    onPressed: () async {
                      if (nameController.text.trim().isEmpty) return;
                      setState(() => isLoading = true);
                      
                      await storage.saveUserName(nameController.text.trim());
                      await storage.saveTargetSchool(selectedSchool);
                      
                      final leaderboard = LeaderboardService();
                      await leaderboard.registerApplicant(selectedSchool);
                      
                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Perfil actualizado')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Guardar', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
              ],
            );
          },
        );
      }
    );
  }
}

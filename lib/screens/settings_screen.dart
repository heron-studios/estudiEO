import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:learn/services/local_storage_service.dart';
import 'package:learn/services/auth_service.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/gamification_provider.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/providers/subject_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const _bg = Color(0xFF0F172A);
  static const _cardBg = Color(0xFF1E293B);
  static const _border = Color(0xFF334155);
  static const _text = Color(0xFFF1F5F9);
  static const _muted = Color(0xFF94A3B8);
  static const _blue = Color(0xFF3B82F6);

  late List<String> _hiddenSubjects;

  @override
  void initState() {
    super.initState();
    final storage = context.read<LocalStorageService>();
    _hiddenSubjects = storage.loadHiddenSubjects();
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
        backgroundColor: _cardBg,
        title: const Text('Exportar Progreso', style: TextStyle(color: _text)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Copia este código de seguridad y guárdalo en un lugar seguro. Podrás usarlo para restaurar tu progreso más tarde.',
              style: TextStyle(color: _muted, fontSize: 13),
            ),
            const SizedBox(height: 16),
            Container(
              constraints: const BoxConstraints(maxHeight: 120),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _border),
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
            child: const Text('Cerrar', style: TextStyle(color: _text)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: _blue),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: jsonString));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Código de progreso copiado al portapapeles.'),
                  backgroundColor: _blue,
                ),
              );
            },
            child: const Text('Copiar Código', style: TextStyle(color: Colors.white)),
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
        backgroundColor: _cardBg,
        title: const Text('Importar Progreso', style: TextStyle(color: _text)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pega el código de progreso que exportaste anteriormente para restaurar tus datos.',
              style: TextStyle(color: _muted, fontSize: 13),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: textController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'monospace'),
              decoration: InputDecoration(
                hintText: 'Pega tu código aquí...',
                hintStyle: const TextStyle(color: Colors.white30),
                fillColor: _bg,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: _border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: _blue),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar', style: TextStyle(color: _text)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
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
                  const SnackBar(
                    content: Text('Progreso restaurado correctamente.'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Error al importar. Código inválido.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Importar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allSubjects = context.watch<SubjectProvider>().allSubjects;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Ajustes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
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
              const Text(
                'VISIBILIDAD DE ASIGNATURAS',
                style: TextStyle(
                  color: _muted,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _border),
                ),
                child: Column(
                  children: allSubjects.map((subject) {
                    final isVisible = !_hiddenSubjects.contains(subject.id);
                    return SwitchListTile(
                      title: Row(
                        children: [
                          Text(subject.icon, style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              subject.name,
                              style: const TextStyle(
                                  color: _text,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      value: isVisible,
                      onChanged: (val) => _toggleSubject(subject.id, val),
                      activeThumbColor: _blue,
                      activeTrackColor: _blue.withValues(alpha: 0.3),
                      inactiveThumbColor: _muted,
                      inactiveTrackColor: _bg,
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'DATOS',
                style: TextStyle(
                  color: _muted,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _border),
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: _exportProgress,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _blue.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.download_rounded,
                            color: _blue, size: 24),
                      ),
                      title: const Text('Exportar progreso',
                          style: TextStyle(
                              color: _text, fontWeight: FontWeight.bold, fontSize: 16)),
                      subtitle: const Text('Copia de seguridad del progreso',
                          style: TextStyle(color: _muted, fontSize: 13)),
                      trailing: const Icon(Icons.chevron_right, color: _muted),
                    ),
                    const Divider(color: _border, height: 1),
                    ListTile(
                      onTap: _importProgress,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.upload_rounded,
                            color: Colors.green, size: 24),
                      ),
                      title: const Text('Importar progreso',
                          style: TextStyle(
                              color: _text, fontWeight: FontWeight.bold, fontSize: 16)),
                      subtitle: const Text('Restaurar copia de seguridad',
                          style: TextStyle(color: _muted, fontSize: 13)),
                      trailing: const Icon(Icons.chevron_right, color: _muted),
                    ),
                    const Divider(color: _border, height: 1),
                    ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: _cardBg,
                            title: const Text('Borrar todo el progreso',
                                style: TextStyle(color: _text)),
                            content: const Text(
                                'Esto eliminará tu racha, historial de tarjetas (SRS) y estadísticas. ¿Estás seguro?',
                                style: TextStyle(color: _muted)),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Cancelar',
                                    style: TextStyle(color: _text)),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Wipes disk storage
                                  context.read<LocalStorageService>().clearAll();
                                  // Wipes in-memory providers
                                  context.read<SrsProvider>().resetAll();
                                  context.read<GamificationProvider>().reset();
                                  context.read<QuizProvider>().clearSessions();
                                  context.read<SubjectProvider>().reload();
                                  
                                  Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Progreso borrado.'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                },
                                child: const Text('Borrar',
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                      },
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.delete_forever_rounded,
                            color: Colors.redAccent, size: 24),
                      ),
                      title: const Text('Borrar progreso',
                          style: TextStyle(
                              color: _text, fontWeight: FontWeight.bold, fontSize: 16)),
                      subtitle: const Text('Rachas, niveles y tarjetas',
                          style: TextStyle(color: _muted, fontSize: 13)),
                      trailing: const Icon(Icons.chevron_right, color: _muted),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'CUENTA',
                style: TextStyle(
                  color: _muted,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _border),
                ),
                child: ListTile(
                  onTap: () async {
                    final authService = context.read<AuthService>();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    await authService.signOut();
                  },
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.logout_rounded,
                        color: Colors.redAccent, size: 24),
                  ),
                  title: const Text('Cerrar sesión',
                      style: TextStyle(
                          color: _text, fontWeight: FontWeight.bold, fontSize: 16)),
                  subtitle: const Text('Salir de tu cuenta de Google',
                      style: TextStyle(color: _muted, fontSize: 13)),
                  trailing: const Icon(Icons.chevron_right, color: _muted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

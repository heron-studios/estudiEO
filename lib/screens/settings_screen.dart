import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/services/local_storage_service.dart';
import 'package:learn/data/subjects_repository.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final allSubjects = SubjectsRepository.getAllSubjects();

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
      body: ListView(
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
                  activeColor: _blue,
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
            child: ListTile(
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
                          context.read<LocalStorageService>().clearAll();
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
          ),
        ],
      ),
    );
  }
}

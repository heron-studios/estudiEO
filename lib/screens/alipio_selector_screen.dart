import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/models/subject.dart';
import 'package:learn/models/topic.dart';
import 'package:learn/screens/alipio_screen.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/widgets/neural_background_wrapper.dart';


/// Pantalla de selección de tema para entrar a Alipio (tarjetas + IA).
/// Muestra primero materias en chips horizontales y luego los temas en lista.
/// Sin scroll vertical — todo cabe en pantalla.
class AlipioSelectorScreen extends StatefulWidget {
  const AlipioSelectorScreen({super.key});

  @override
  State<AlipioSelectorScreen> createState() => _AlipioSelectorScreenState();
}

class _AlipioSelectorScreenState extends State<AlipioSelectorScreen> {
  late List<Subject> _subjects;
  late Subject _selected;
  late List<Topic> _topics;
  bool _isSelectionInitialized = false;

  static const _card = Color(0xFF1E293B);
  static const _border = Color(0xFF334155);
  static const _purple = Color(0xFF7C3AED);
  static const _purpleLight = Color(0xFFA78BFA);
  static const _muted = Color(0xFF94A3B8);

  @override
  void initState() {
    super.initState();
    // We will initialize _subjects in didChangeDependencies
    // to access context safely.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = context.watch<SubjectProvider>();
    _subjects = provider.subjects.where((s) => 
      s.name != 'Matemáticas' && 
      s.name != 'Matemática' && 
      s.name != 'Razonamiento Matemático'
    ).toList();
    if (_subjects.isNotEmpty) {
      if (!_isSelectionInitialized) {
        _selected = _subjects.first;
        _isSelectionInitialized = true;
      } else {
        if (!_subjects.any((s) => s.id == _selected.id)) {
          _selected = _subjects.first;
        }
      }
      _topics = provider.getTopicsBySubject(_selected.id);
    } else {
      _topics = [];
    }
  }

  void _selectSubject(Subject s) {
    setState(() {
      _selected = s;
      _topics = context.read<SubjectProvider>().getTopicsBySubject(s.id);
    });
  }

  void _openAlipio(Topic t) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AlipioScreen(topicId: t.id, topicName: t.name),
      ),
    );
  }

  Color _parseColor(String s) {
    final hex = s.replaceAll('#', '');
    if (hex.length == 6) return Color(int.parse('FF$hex', radix: 16));
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text('Tarjetas de Memoria',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── SUBTITLE ──
              Text(
                'Elige una materia y un tema para estudiar con tarjetas.',
                style: TextStyle(color: _muted.withValues(alpha: 0.8), fontSize: 13),
              ),
              const SizedBox(height: 14),

              // ── SUBJECT CHIPS (horizontal) ──
              if (_subjects.isEmpty)
                const Center(
                    child: Text('No hay asignaturas visibles',
                        style: TextStyle(color: Colors.white54)))
              else
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                  itemCount: _subjects.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final s = _subjects[i];
                    final isSelected = s.id == _selected.id;
                    final color = _parseColor(s.color);
                    return GestureDetector(
                      onTap: () => _selectSubject(s),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? color.withValues(alpha: 0.25)
                              : _card,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? color
                                : _border,
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(s.icon,
                                style: const TextStyle(fontSize: 14)),
                            const SizedBox(width: 6),
                            Text(
                              s.name.split(' ').take(2).join(' '),
                              style: TextStyle(
                                color: isSelected ? color : _muted,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // ── TOPIC LABEL ──
              if (_subjects.isNotEmpty) ...[
                Row(
                  children: [
                    Text(
                      '${_selected.icon}  Temas de ${_selected.name}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    const Spacer(),
                    Text(
                      '${_topics.length} temas',
                      style: const TextStyle(color: _muted, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],

              // ── TOPIC LIST (expanded, no outer scroll) ──
              Expanded(
                child: _topics.isEmpty
                    ? const Center(
                        child: Text('Sin temas disponibles',
                            style: TextStyle(color: Colors.white38)))
                    : ListView.separated(
                        itemCount: _topics.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 6),
                        itemBuilder: (context, i) {
                          final t = _topics[i];
                          return Material(
                            color: _card,
                            borderRadius: BorderRadius.circular(14),
                            child: InkWell(
                              onTap: () => _openAlipio(t),
                              borderRadius: BorderRadius.circular(14),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                      color: _border, width: 1),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: _purple
                                            .withValues(alpha: 0.12),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${i + 1}',
                                          style: const TextStyle(
                                              color: _purpleLight,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(t.name,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14)),
                                          Text(
                                            '${t.questionCount} tarjetas',
                                            style: const TextStyle(
                                                color: _muted,
                                                fontSize: 11),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                        Icons.auto_awesome_rounded,
                                        color: _purple,
                                        size: 18),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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

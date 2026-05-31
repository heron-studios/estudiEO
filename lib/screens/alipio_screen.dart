import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/models/question.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/widgets/neural_background_wrapper.dart';
import 'package:go_router/go_router.dart';

class AlipioScreen extends StatefulWidget {
  final String topicId;
  final String topicName;

  const AlipioScreen({
    super.key,
    required this.topicId,
    required this.topicName,
  });

  @override
  State<AlipioScreen> createState() => _AlipioScreenState();
}

class _AlipioScreenState extends State<AlipioScreen>
    with SingleTickerProviderStateMixin {
  late List<Question> _cards;
  int _index = 0;
  bool _showAnswer = false;
  late AnimationController _flipController;
  late Animation<double> _flipAnim;
  bool _isFront = true;

  static const _bg = Color(0xFF0F172A);
  static const _card = Color(0xFF1E293B);
  static const _blue = Color(0xFF3B82F6);
  static const _muted = Color(0xFF94A3B8);

  @override
  void initState() {
    super.initState();
    _cards = context.read<SubjectProvider>().getQuestionsByTopic(widget.topicId)..shuffle();

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _flipAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  Question get _current => _cards[_index];

  final Set<String> _allTimeFlipped = {};
  final List<String> _batchQuestionIds = [];

  void _flip() {
    if (_isFront) {
      _flipController.forward();
      
      if (!_allTimeFlipped.contains(_current.id)) {
        _allTimeFlipped.add(_current.id);
        _batchQuestionIds.add(_current.id);
        
        if (_batchQuestionIds.length == 20 || _allTimeFlipped.length == _cards.length) {
          if (_batchQuestionIds.isNotEmpty) {
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) _showMiniQuizPrompt();
            });
          }
        }
      }
    } else {
      _flipController.reverse();
    }
    setState(() {
      _isFront = !_isFront;
      _showAnswer = !_showAnswer;
    });
  }

  void _showMiniQuizPrompt() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: _card,
          title: const Text('¡Tarjetas completadas!', style: TextStyle(color: Colors.white)),
          content: const Text('Probemos si te las aprendiste. ¿Listo para un quiz rápido?', style: TextStyle(color: Colors.white70)),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                final batch = List<String>.from(_batchQuestionIds);
                _batchQuestionIds.clear();
                
                context.push('/srs-mini-quiz', extra: batch,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4ADE80), foregroundColor: _bg),
              child: const Text('Realizar quiz rápido', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _batchQuestionIds.clear();
              },
              child: const Text('Ahora no', style: TextStyle(color: Colors.white54)),
            ),
          ],
        );
      }
    );
  }

  void _goTo(int newIndex) {
    _flipController.reset();
    setState(() {
      _index = newIndex;
      _isFront = true;
      _showAnswer = false;
    });
  }

  void _prev() {
    if (_index > 0) _goTo(_index - 1);
  }

  void _next() {
    if (_index < _cards.length - 1) _goTo(_index + 1);
  }

  @override
  Widget build(BuildContext context) {
    if (_cards.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(),
        body: const NeuralBackgroundWrapper(
          child: Center(
            child: Text('No hay tarjetas disponibles',
                style: TextStyle(color: Colors.white60)),
          ),
        ),
      );
    }
   
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildProgress(),
                    const SizedBox(height: 12),
                    Expanded(
                      flex: 8,
                      child: GestureDetector(
                        onTap: _flip,
                        child: AnimatedBuilder(
                          animation: _flipAnim,
                          builder: (context, child) {
                            final angle = _flipAnim.value * math.pi;
                            final isFrontVisible = _flipAnim.value < 0.5;
                            return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(isFrontVisible ? angle : angle - math.pi),
                              child: isFrontVisible ? _buildFront() : _buildBack(),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildNavRow(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('TARJETAS',
              style: TextStyle(
                  color: _blue, fontSize: 12, fontWeight: FontWeight.w600)),
          Text(
            widget.topicName,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildProgress() {
    final progress = (_index + 1) / _cards.length;
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: _card,
              valueColor: const AlwaysStoppedAnimation<Color>(_blue),
              minHeight: 5,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '${_index + 1}/${_cards.length}',
          style: const TextStyle(
              color: _muted, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildFront() {
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _blue.withValues(alpha: 0.4), width: 1.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _blue.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('PREGUNTA',
                style: TextStyle(
                    color: _blue,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5)),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Text(
                  _current.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1.5),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.touch_app, color: _muted, size: 14),
              SizedBox(width: 4),
              Text('Toca para ver respuesta',
                  style: TextStyle(color: _muted, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBack() {
    String answer = "Error: Respuesta no encontrada.";
    if (_current.options.isNotEmpty && _current.correctAnswer >= 0 && _current.correctAnswer < _current.options.length) {
      answer = _current.options[_current.correctAnswer];
    } else {
      // Si entra aquí, es porque la app sigue usando los datos antiguos en memoria.
      answer = "Por favor, reinicia la app por completo (Hot Restart) para cargar los nuevos datos.";
    }
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF052E16),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: const Color(0xFF16A34A).withValues(alpha: 0.6), width: 1.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF16A34A).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('RESPUESTA',
                style: TextStyle(
                    color: Color(0xFF4ADE80),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5)),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Text(
                  answer,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color(0xFF86EFAC),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1.5),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.touch_app, color: Color(0xFF4ADE80), size: 14),
              SizedBox(width: 4),
              Text('Toca para voltear',
                  style: TextStyle(color: Color(0xFF4ADE80), fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavRow() {
    return Row(
      children: [
        _NavBtn(
          icon: Icons.arrow_back_ios_rounded,
          label: 'Anterior',
          enabled: _index > 0,
          onTap: _prev,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: _flip,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: _blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.flip_rounded, color: Colors.white, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    _showAnswer ? 'Ver pregunta' : 'Ver respuesta',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _NavBtn(
          icon: Icons.arrow_forward_ios_rounded,
          label: 'Siguiente',
          enabled: _index < _cards.length - 1,
          onTap: _next,
        ),
      ],
    );
  }
}

class _NavBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool enabled;
  final VoidCallback onTap;

  const _NavBtn({
    required this.icon,
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedOpacity(
        opacity: enabled ? 1.0 : 0.3,
        duration: const Duration(milliseconds: 150),
        child: Container(
          width: 72,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF334155)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white70, size: 16),
              const SizedBox(height: 2),
              Text(label,
                  style: const TextStyle(color: Colors.white54, fontSize: 9)),
            ],
          ),
        ),
      ),
    );
  }
}

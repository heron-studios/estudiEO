import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/data/subjects_repository.dart';
import 'package:learn/models/question.dart';

class SrsReviewScreen extends StatefulWidget {
  const SrsReviewScreen({super.key});

  @override
  State<SrsReviewScreen> createState() => _SrsReviewScreenState();
}

class _SrsReviewScreenState extends State<SrsReviewScreen> {
  late List<String> _reviewQueue = [];
  int _currentIndex = 0;
  bool _answered = false;
  int? _selectedIndex;

  static const _bg = Color(0xFF0F172A);
  static const _cardBg = Color(0xFF1E293B);
  static const _border = Color(0xFF334155);
  static const _text = Color(0xFFF1F5F9);
  static const _muted = Color(0xFF94A3B8);
  static const _green = Color(0xFF4ADE80);
  static const _red = Color(0xFFF87171);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_reviewQueue.isEmpty) {
      _initializeQueue();
    }
  }

  void _initializeQueue() {
    final srs = context.read<SrsProvider>();
    final queue = srs.getReviewQueue();
    // Copy the queue so it doesn't shift under us while answering
    setState(() {
      _reviewQueue = queue.map((card) => card.questionId).toList();
    });
  }

  void _onOptionSelected(int index, Question question) async {
    if (_answered) return;

    setState(() {
      _answered = true;
      _selectedIndex = index;
    });

    final isCorrect = index == question.correctAnswer;
    
    // Process answer in background
    context.read<SrsProvider>().processAnswer(
      question.id,
      question.topicId,
      isCorrect,
    );

    // Wait a moment so the user sees the correct/incorrect color
    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;

    if (_currentIndex < _reviewQueue.length - 1) {
      setState(() {
        _currentIndex++;
        _answered = false;
        _selectedIndex = null;
      });
    } else {
      _showCompletion();
    }
  }

  void _showCompletion() {
    Navigator.pop(context); // Go back to Home
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('¡Revisión completada! Has repasado tus tarjetas.',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: _green.withValues(alpha: 0.9),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_reviewQueue.isEmpty) {
      return Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🎉', style: TextStyle(fontSize: 60)),
              SizedBox(height: 16),
              Text(
                '¡Al día!',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: _text),
              ),
              SizedBox(height: 8),
              Text('No tienes tarjetas pendientes de repaso.',
                  style: TextStyle(color: _muted)),
            ],
          ),
        ),
      );
    }

    final questionId = _reviewQueue[_currentIndex];
    final question = SubjectsRepository.getQuestion(questionId);

    if (question == null) {
      return Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const Center(
          child: Text('Error cargando la pregunta.',
              style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          children: [
            const Text(
              'REPASO ESPACIADO',
              style: TextStyle(
                  color: _green, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.5),
            ),
            Text(
              '${_currentIndex + 1} de ${_reviewQueue.length}',
              style: const TextStyle(
                  color: _text, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (_currentIndex + 1) / _reviewQueue.length,
                  backgroundColor: _cardBg,
                  valueColor: const AlwaysStoppedAnimation<Color>(_green),
                  minHeight: 4,
                ),
              ),
              const SizedBox(height: 24),

              // Question Text
              Expanded(
                flex: 3,
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      question.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: _text,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Options
              Expanded(
                flex: 6,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: question.options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final isCorrect = index == question.correctAnswer;
                    final isSelected = index == _selectedIndex;

                    Color tileColor = _cardBg;
                    Color borderColor = _border;
                    Color textColor = _text;

                    if (_answered) {
                      if (isCorrect) {
                        tileColor = _green.withValues(alpha: 0.15);
                        borderColor = _green;
                        textColor = _green;
                      } else if (isSelected && !isCorrect) {
                        tileColor = _red.withValues(alpha: 0.15);
                        borderColor = _red;
                        textColor = _red;
                      }
                    }

                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _onOptionSelected(index, question),
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: tileColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: borderColor, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: _answered
                                      ? (isCorrect
                                          ? _green
                                          : (isSelected ? _red : _cardBg))
                                      : _cardBg,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _answered
                                        ? (isCorrect
                                            ? _green
                                            : (isSelected ? _red : _border))
                                        : _border,
                                  ),
                                ),
                                child: Center(
                                  child: _answered && (isCorrect || isSelected)
                                      ? Icon(
                                          isCorrect
                                              ? Icons.check
                                              : Icons.close,
                                          size: 16,
                                          color: _bg,
                                        )
                                      : Text(
                                          String.fromCharCode(65 + index), // A, B, C...
                                          style: TextStyle(
                                            color: _muted,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  question.options[index],
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
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
    );
  }
}

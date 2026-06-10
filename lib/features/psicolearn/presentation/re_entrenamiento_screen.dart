import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/features/psicolearn/domain/models/psico_question.dart';
import 'package:learn/features/psicolearn/domain/services/psico_service.dart';
import 'package:learn/core/services/audio_service.dart';
import 'package:learn/core/services/local_storage_service.dart';

class ReEntrenamientoScreen extends StatefulWidget {
  const ReEntrenamientoScreen({super.key});

  @override
  State<ReEntrenamientoScreen> createState() => _ReEntrenamientoScreenState();
}

class _ReEntrenamientoScreenState extends State<ReEntrenamientoScreen>
    with TickerProviderStateMixin {
  final PsicoService _service = PsicoService();
  List<PsicoQuestion>? _questions;
  int _currentIndex = 0;
  bool _showingFeedback = false;
  bool _selectedIsCorrect = false;
  String? _selectedOptionKey;
  bool _isLoading = true;
  int _correctedCount = 0; // cuántas respondimos correctamente en esta sesión

  late AnimationController _feedbackController;
  late Animation<double> _feedbackAnimation;

  @override
  void initState() {
    super.initState();
    _feedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _feedbackAnimation = CurvedAnimation(
      parent: _feedbackController,
      curve: Curves.easeOut,
    );
    _loadQuestions();
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _loadQuestions() async {
    final ids =
        context.read<LocalStorageService>().getFailedPsicoQuestionIds();
    if (ids.isEmpty) {
      if (!mounted) return;
      setState(() {
        _questions = [];
        _isLoading = false;
      });
      return;
    }

    final questions = await _service.getQuestionsByIds(ids);
    if (!mounted) return;
    setState(() {
      _questions = questions;
      _isLoading = false;
    });
  }

  void _onOptionSelected(String optionKey) {
    if (_questions == null || _showingFeedback || _questions!.isEmpty) return;

    final question = _questions![_currentIndex];
    final isCorrect = optionKey == question.correctAnswer;

    if (isCorrect) {
      context.read<AudioService>().playCorrectSound();
      context.read<LocalStorageService>().removeFailedPsicoQuestion(question.id);
      _correctedCount++;
    } else {
      context.read<AudioService>().playIncorrectSound();
    }

    setState(() {
      _selectedOptionKey = optionKey;
      _selectedIsCorrect = isCorrect;
      _showingFeedback = true;
    });

    _feedbackController.forward(from: 0);

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) _nextQuestion();
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions!.length - 1) {
      _feedbackController.reset();
      setState(() {
        _currentIndex++;
        _showingFeedback = false;
        _selectedOptionKey = null;
      });
    } else {
      _showFinishDialog();
    }
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final nt = NeuralTheme.of(context);
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: nt.surfaceCard,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                  color: nt.successGreen.withValues(alpha: 0.4), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: nt.successGreen.withValues(alpha: 0.1),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: nt.successGreen.withValues(alpha: 0.15),
                    border: Border.all(
                        color: nt.successGreen.withValues(alpha: 0.4),
                        width: 2),
                  ),
                  child:
                      Icon(Icons.school_rounded, color: nt.successGreen, size: 36),
                ),
                const SizedBox(height: 20),
                Text(
                  '¡ENTRENAMIENTO COMPLETADO!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: nt.successGreen,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: 1,
                    fontFamily: 'Outfit',
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_rounded,
                              color: nt.successGreen, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            '$_correctedCount correctas esta sesión',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Las preguntas que respondiste correctamente han sido eliminadas de la lista de repaso. Si te equivocaste en algunas, seguirán pendientes para tu próxima sesión.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white60, fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.pop();
                    },
                    icon: const Icon(Icons.home_rounded),
                    label: const Text('VOLVER',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: nt.blueGoogle,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    if (_isLoading) {
      return NeuralBackgroundWrapper(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: nt.blueGoogle),
                const SizedBox(height: 16),
                const Text('Cargando errores pendientes...',
                    style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
      );
    }

    // Pantalla sin errores pendientes
    if (_questions != null && _questions!.isEmpty) {
      return NeuralBackgroundWrapper(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon:
                  const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white60),
              onPressed: () => context.pop(),
            ),
            title: const Text('Re Entrenamiento',
                style: TextStyle(color: Colors.white, fontFamily: 'Outfit')),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: nt.successGreen.withValues(alpha: 0.1),
                      border: Border.all(
                          color: nt.successGreen.withValues(alpha: 0.4),
                          width: 2),
                    ),
                    child:
                        Icon(Icons.check_circle_outline_rounded, size: 60, color: nt.successGreen),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    '¡TODO LIMPIO!',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Outfit',
                        letterSpacing: 1),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'No tienes errores pendientes de repaso.\nTus conocimientos están al máximo nivel.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white70, fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 36),
                  ElevatedButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.home_rounded),
                    label: const Text('VOLVER AL INICIO',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: nt.blueGoogle,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final question = _questions![_currentIndex];
    final totalCount = _questions!.length;

    return NeuralBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white60),
            onPressed: () => context.pop(),
          ),
          title: Column(
            children: [
              const Text('Re Entrenamiento',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.bold)),
              Text(
                'Error ${_currentIndex + 1} de $totalCount',
                style:
                    const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Barra de progreso
              ClipRRect(
                child: LinearProgressIndicator(
                  value: (_currentIndex + 1) / totalCount,
                  backgroundColor: Colors.white10,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(nt.warningAmber),
                  minHeight: 3,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 4),

                          // Badge de error / dimensión
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: nt.warningAmber.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color:
                                          nt.warningAmber.withValues(alpha: 0.4)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.replay_rounded,
                                        color: nt.warningAmber, size: 12),
                                    const SizedBox(width: 4),
                                    Text(
                                      'REPASO',
                                      style: TextStyle(
                                        color: nt.warningAmber,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (question.dimension.isNotEmpty &&
                                  question.dimension != 'General') ...[
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    question.displayDimension,
                                    style: const TextStyle(
                                        color: Colors.white54, fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Pregunta
                          StaticGlassContainer(
                            padding: const EdgeInsets.all(22),
                            borderRadius: BorderRadius.circular(20),
                            child: Text(
                              question.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Opciones (renderizadas dinámicamente)
                          ...question.options.entries
                              .toList()
                              .asMap()
                              .entries
                              .map((indexedEntry) {
                            final idx = indexedEntry.key;
                            final entry = indexedEntry.value;
                            final labels = ['A', 'B', 'C', 'D', 'E'];
                            final label =
                                idx < labels.length ? labels[idx] : entry.key;
                            final isSelected = _selectedOptionKey == entry.key;
                            final isCorrectAnswer =
                                entry.key == question.correctAnswer;

                            Color borderColor = Colors.white10;
                            Color bgColor = nt.surfaceCard;
                            Color textColor = Colors.white70;
                            Color circleColor = Colors.white10;
                            Widget? trailingIcon;

                            if (_showingFeedback) {
                              if (isCorrectAnswer) {
                                borderColor = nt.successGreen;
                                bgColor = nt.successGreen.withValues(alpha: 0.12);
                                textColor = Colors.white;
                                circleColor = nt.successGreen;
                                trailingIcon = Icon(Icons.check_circle_rounded,
                                    color: nt.successGreen);
                              } else if (isSelected) {
                                borderColor = nt.pink;
                                bgColor = nt.pink.withValues(alpha: 0.12);
                                textColor = Colors.white;
                                circleColor = nt.pink;
                                trailingIcon = Icon(Icons.cancel_rounded,
                                    color: nt.pink);
                              }
                            } else if (isSelected) {
                              borderColor = nt.blueGoogle;
                              bgColor =
                                  nt.blueGoogle.withValues(alpha: 0.12);
                            }

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: borderColor,
                                      width:
                                          _showingFeedback && (isCorrectAnswer || isSelected)
                                              ? 1.5
                                              : 1),
                                ),
                                child: InkWell(
                                  onTap: _showingFeedback
                                      ? null
                                      : () => _onOptionSelected(entry.key),
                                  borderRadius: BorderRadius.circular(16),
                                  child: Row(
                                    children: [
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: circleColor,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          label,
                                          style: TextStyle(
                                            color: _showingFeedback &&
                                                    (isCorrectAnswer || isSelected)
                                                ? Colors.white
                                                : Colors.white54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Text(
                                          entry.value,
                                          style: TextStyle(
                                              color: textColor, fontSize: 15, height: 1.3),
                                        ),
                                      ),
                                      if (trailingIcon != null)
                                        trailingIcon,
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),

                          // Panel de hint si es incorrecta
                          if (_showingFeedback && !_selectedIsCorrect) ...[
                            const SizedBox(height: 12),
                            FadeTransition(
                              opacity: _feedbackAnimation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 0.3),
                                  end: Offset.zero,
                                ).animate(_feedbackAnimation),
                                child: StaticGlassContainer(
                                  padding: const EdgeInsets.all(16),
                                  borderRadius: BorderRadius.circular(16),
                                  borderColor:
                                      nt.warningAmber.withValues(alpha: 0.4),
                                  child: Row(
                                    children: [
                                      Icon(Icons.lightbulb_outline_rounded,
                                          color: nt.warningAmber, size: 22),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Orientación',
                                              style: TextStyle(
                                                color: nt.warningAmber,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              question.hint.isNotEmpty
                                                  ? question.hint
                                                  : 'Revisa bien las opciones. La respuesta correcta refleja mayor equilibrio o resiliencia.',
                                              style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 13,
                                                  height: 1.4),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],

                          // Si es correcto, mensaje motivacional
                          if (_showingFeedback && _selectedIsCorrect) ...[
                            const SizedBox(height: 12),
                            FadeTransition(
                              opacity: _feedbackAnimation,
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: nt.successGreen.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color:
                                          nt.successGreen.withValues(alpha: 0.3)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check_circle_rounded,
                                        color: nt.successGreen, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      '¡Correcto! Eliminado del repaso.',
                                      style: TextStyle(
                                          color: nt.successGreen,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],

                          const SizedBox(height: 20),
                        ],
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

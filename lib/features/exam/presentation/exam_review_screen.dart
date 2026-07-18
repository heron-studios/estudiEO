import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:learn/models/question.dart';
import 'package:learn/models/subject.dart';
import 'package:learn/data/repository/subjects_repository.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/screens/entrevista_simulator/puter_service.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/core/services/limits_service.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ExamReviewScreen extends StatefulWidget {
  final List<Question> questions;
  final Map<String, int> answers;

  const ExamReviewScreen({
    super.key,
    required this.questions,
    required this.answers,
  });

  @override
  State<ExamReviewScreen> createState() => _ExamReviewScreenState();
}

class _ExamReviewScreenState extends State<ExamReviewScreen> {
  int _currentIndex = 0; // Index in _filteredIndices
  String _filter = 'all'; // all, correct, incorrect, omitted
  final List<int> _filteredIndices = [];

  late final PuterService _puterService;
  final Map<String, String> _aiExplanations = {};
  final Map<String, bool> _isLoadingAi = {};

  @override
  void initState() {
    super.initState();
    _puterService = PuterService();
    _applyFilter();
  }

  Future<void> _requestAIExplanation(
    Question q,
    int selectedOptionIndex,
    bool isCorrect,
  ) async {
    final auth = context.read<AuthService>();
    final canUseIA = await LimitsService.canUseTutorIA(auth.isPremium);

    if (!canUseIA) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Límite diario de consultas al Tutor IA alcanzado. Vuelve mañana o hazte Premium.',
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      return;
    }

    setState(() {
      _isLoadingAi[q.id] = true;
    });

    final String selectedAnswerText =
        selectedOptionIndex >= 0 && selectedOptionIndex < q.options.length
        ? q.options[selectedOptionIndex]
        : 'Ninguna (Omitida)';

    final String correctAnswerText =
        q.correctAnswer >= 0 && q.correctAnswer < q.options.length
        ? q.options[q.correctAnswer]
        : 'Desconocida';

    final String systemPrompt =
        '''
Actúa como un profesor experto y empático de una academia pre-policial. 
El alumno está revisando su simulacro de examen y necesita entender una pregunta.
Pregunta: "${q.text}"
Opciones:
${q.options.asMap().entries.map((e) => "${String.fromCharCode(65 + e.key)}) ${e.value}").join('\n')}

El alumno marcó: "$selectedAnswerText"
La respuesta correcta es: "$correctAnswerText"

Explica brevemente y paso a paso por qué la respuesta correcta es la correcta y por qué la opción del alumno es incorrecta (si se equivocó). Usa un tono motivador y claro. Formatea tu respuesta en Markdown.
''';

    await LimitsService.incrementTutorIACount();
    final response = await _puterService.chat(systemPrompt);

    if (mounted) {
      setState(() {
        _aiExplanations[q.id] = response;
        _isLoadingAi[q.id] = false;
      });
    }
  }

  void _applyFilter() {
    _filteredIndices.clear();
    for (int i = 0; i < widget.questions.length; i++) {
      final q = widget.questions[i];
      final selected = widget.answers[q.id] ?? -1;
      final isCorrect = selected == q.correctAnswer;
      final isOmitted = selected == -1;

      if (_filter == 'all') {
        _filteredIndices.add(i);
      } else if (_filter == 'correct' && isCorrect && !isOmitted) {
        _filteredIndices.add(i);
      } else if (_filter == 'incorrect' && !isCorrect && !isOmitted) {
        _filteredIndices.add(i);
      } else if (_filter == 'omitted' && isOmitted) {
        _filteredIndices.add(i);
      }
    }

    // Reset index to 0 if out of bounds
    if (_currentIndex >= _filteredIndices.length) {
      _currentIndex = 0;
    }
  }

  Subject? _getCurrentSubject(Question q) {
    final topic = SubjectsRepository.getTopic(q.topicId);
    if (topic == null) return null;
    return SubjectsRepository.getSubject(topic.subjectId);
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
        ),
      ],
    );
  }

  void _showNavigationGrid() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF334155),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        'Revisión - Mapa de Preguntas',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white70),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildLegendItem(const Color(0xFF10B981), 'Correcta'),
                      _buildLegendItem(const Color(0xFFEF4444), 'Incorrecta'),
                      _buildLegendItem(const Color(0xFF475569), 'Omitida'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      controller: scrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemCount: widget.questions.length,
                      itemBuilder: (context, idx) {
                        final q = widget.questions[idx];
                        final selected = widget.answers[q.id] ?? -1;
                        final isCorrect = selected == q.correctAnswer;
                        final isOmitted = selected == -1;

                        Color bgColor = const Color(0xFF475569);
                        Color textColor = Colors.white;

                        if (!isOmitted) {
                          bgColor = isCorrect
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444);
                        }

                        final originalIndexInFiltered = _filteredIndices
                            .indexOf(idx);
                        final isSelectedInReview =
                            originalIndexInFiltered == _currentIndex;

                        Border? border;
                        if (isSelectedInReview) {
                          border = Border.all(color: Colors.white, width: 2.5);
                        }

                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(ctx);
                            if (originalIndexInFiltered != -1) {
                              setState(() {
                                _currentIndex = originalIndexInFiltered;
                              });
                            } else {
                              // If not in current filtered list, switch filter to 'all' and jump
                              setState(() {
                                _filter = 'all';
                                _applyFilter();
                                _currentIndex = idx;
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(10),
                              border: border,
                            ),
                            child: Center(
                              child: Text(
                                '${idx + 1}',
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSidebarGrid() {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(left: 20, top: 16, bottom: 16, right: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mapa de Preguntas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLegendItem(const Color(0xFF10B981), 'Correcta'),
              _buildLegendItem(const Color(0xFFEF4444), 'Errónea'),
              _buildLegendItem(const Color(0xFF475569), 'Omitida'),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: widget.questions.length,
              itemBuilder: (context, idx) {
                final q = widget.questions[idx];
                final selected = widget.answers[q.id] ?? -1;
                final isCorrect = selected == q.correctAnswer;
                final isOmitted = selected == -1;

                Color bgColor = const Color(0xFF475569);
                Color textColor = Colors.white;

                if (!isOmitted) {
                  bgColor = isCorrect
                      ? const Color(0xFF10B981)
                      : const Color(0xFFEF4444);
                }

                final originalIndexInFiltered = _filteredIndices.indexOf(idx);
                final isSelectedInReview =
                    originalIndexInFiltered == _currentIndex;

                Border? border;
                if (isSelectedInReview) {
                  border = Border.all(color: Colors.white, width: 2.5);
                }

                return GestureDetector(
                  onTap: () {
                    if (originalIndexInFiltered != -1) {
                      setState(() {
                        _currentIndex = originalIndexInFiltered;
                      });
                    } else {
                      setState(() {
                        _filter = 'all';
                        _applyFilter();
                        _currentIndex = idx;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(8),
                      border: border,
                    ),
                    child: Center(
                      child: Text(
                        '${idx + 1}',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainReviewColumn(
    bool isLargeScreen,
    int originalIndex,
    Question question,
    int selectedAnswer,
    bool isCorrect,
    bool isOmitted,
    String subjectIcon,
    Color subjectColor,
    Subject? currentSubject,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isLargeScreen ? double.infinity : 650,
        ),
        child: Column(
          children: [
            _buildHeaderBar(isLargeScreen),
            _buildFilterRow(),

            // Question and details
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Navigation Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: _currentIndex > 0
                              ? () => setState(() => _currentIndex--)
                              : null,
                          icon: const Icon(Icons.arrow_back_ios, size: 18),
                          color: Colors.white,
                          disabledColor: Colors.white24,
                        ),
                        Text(
                          'Pregunta ${originalIndex + 1} de ${widget.questions.length}',
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                          onPressed: _currentIndex < _filteredIndices.length - 1
                              ? () => setState(() => _currentIndex++)
                              : null,
                          icon: const Icon(Icons.arrow_forward_ios, size: 18),
                          color: Colors.white,
                          disabledColor: Colors.white24,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Subject and Status row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: subjectColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: subjectColor.withValues(alpha: 0.4),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                subjectIcon,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                currentSubject?.name.toUpperCase() ?? 'MATERIA',
                                style: TextStyle(
                                  color: subjectColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Correct/Incorrect/Omitted Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isOmitted
                                ? const Color(0xFF475569).withValues(alpha: 0.2)
                                : isCorrect
                                ? const Color(0xFF10B981).withValues(alpha: 0.2)
                                : const Color(
                                    0xFFEF4444,
                                  ).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isOmitted
                                  ? const Color(0xFF475569)
                                  : isCorrect
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFEF4444),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            isOmitted
                                ? 'OMITIDA'
                                : isCorrect
                                ? 'CORRECTA'
                                : 'INCORRECTA',
                            style: TextStyle(
                              color: isOmitted
                                  ? const Color(0xFF94A3B8)
                                  : isCorrect
                                  ? const Color(0xFF34D399)
                                  : const Color(0xFFF87171),
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Question Text
                    Center(
                      child: Text(
                        question.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Options list
                    ...List.generate(question.options.length, (i) {
                      final isCorrectOption = i == question.correctAnswer;
                      final isSelectedOption = i == selectedAnswer;

                      Color itemBg = const Color(0xFF1E293B);
                      Color itemBorder = const Color(0xFF334155);
                      Color textColor = Colors.white;
                      IconData? rightIcon;
                      Color iconColor = Colors.transparent;

                      if (isCorrectOption) {
                        itemBg = const Color(0xFF064E3B);
                        itemBorder = const Color(0xFF10B981);
                        textColor = const Color(0xFFD1FAE5);
                        rightIcon = Icons.check_circle_rounded;
                        iconColor = const Color(0xFF10B981);
                      } else if (isSelectedOption && !isCorrect) {
                        itemBg = const Color(0xFF7F1D1D);
                        itemBorder = const Color(0xFFEF4444);
                        textColor = const Color(0xFFFEE2E2);
                        rightIcon = Icons.cancel_rounded;
                        iconColor = const Color(0xFFEF4444);
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: itemBg,
                            border: Border.all(color: itemBorder, width: 1.5),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(
                                    0xFF334155,
                                  ).withValues(alpha: 0.3),
                                ),
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + i),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  question.options[i],
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              if (rightIcon != null) ...[
                                const SizedBox(width: 10),
                                Icon(rightIcon, color: iconColor, size: 22),
                              ],
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),

                    // Explanation card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B).withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF334155)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: Color(0xFF60A5FA),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Explicación Teórica',
                                style: TextStyle(
                                  color: Colors.blue[300],
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            question.explanation.isNotEmpty
                                ? question.explanation
                                : 'No hay una explicación detallada disponible para esta pregunta en este momento.',
                            style: const TextStyle(
                              color: Color(0xFFE2E8F0),
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // AI Tutor Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D1B69).withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF6D28D9)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.smart_toy_rounded,
                                color: Colors.purpleAccent,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Tutor IA',
                                style: TextStyle(
                                  color: Colors.purpleAccent,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              if (!(_isLoadingAi[question.id] ?? false) &&
                                  !_aiExplanations.containsKey(question.id))
                                ElevatedButton.icon(
                                  onPressed: () => _requestAIExplanation(
                                    question,
                                    selectedAnswer,
                                    isCorrect,
                                  ),
                                  icon: const Icon(
                                    Icons.auto_awesome,
                                    size: 16,
                                  ),
                                  label: const Text(
                                    'Explicar con IA (Puter)',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purpleAccent
                                        .withValues(alpha: 0.2),
                                    foregroundColor: Colors.purpleAccent,
                                    elevation: 0,
                                    side: const BorderSide(
                                      color: Colors.purpleAccent,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (_isLoadingAi[question.id] ?? false) ...[
                            const SizedBox(height: 16),
                            const Center(
                              child: CircularProgressIndicator(
                                color: Colors.purpleAccent,
                              ),
                            ),
                          ] else if (_aiExplanations.containsKey(
                            question.id,
                          )) ...[
                            const SizedBox(height: 12),
                            MarkdownBody(
                              data: _aiExplanations[question.id]!,
                              styleSheet: MarkdownStyleSheet(
                                p: const TextStyle(
                                  color: Color(0xFFE2E8F0),
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                                strong: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ] else ...[
                            const SizedBox(height: 8),
                            Text(
                              '¿Aún tienes dudas? Pídele a nuestro Profesor IA que te lo explique paso a paso.',
                              style: TextStyle(
                                color: Colors.purple[200]!.withValues(
                                  alpha: 0.7,
                                ),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.questions.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(
          child: Text(
            'No hay preguntas para revisar.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 950;

    if (_filteredIndices.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        body: NeuralBackgroundWrapper(
          child: SafeArea(
            child: Column(
              children: [
                _buildHeaderBar(isLargeScreen),
                _buildFilterRow(),
                const Expanded(
                  child: Center(
                    child: Text(
                      'No hay preguntas que coincidan con este filtro.',
                      style: TextStyle(color: Color(0xFF94A3B8), fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final originalIndex = _filteredIndices[_currentIndex];
    final question = widget.questions[originalIndex];
    final selectedAnswer = widget.answers[question.id] ?? -1;
    final isCorrect = selectedAnswer == question.correctAnswer;
    final isOmitted = selectedAnswer == -1;

    final currentSubject = _getCurrentSubject(question);
    final subjectColorHex = currentSubject?.color ?? '#3B82F6';
    final colorVal =
        int.tryParse(subjectColorHex.replaceAll('#', ''), radix: 16) ??
        0xFF3B82F6;
    final subjectColor = Color(colorVal | 0xFF000000);
    final subjectIcon = currentSubject?.icon ?? '📚';

    final bridgeWidget = _puterService.buildBridgeWidget();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          if (bridgeWidget != null)
            Positioned(top: -100, left: -100, child: bridgeWidget),
          NeuralBackgroundWrapper(
            child: SafeArea(
              child: isLargeScreen
                  ? Center(
                      child: SizedBox(
                        width: screenWidth.clamp(0.0, 960.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: _buildMainReviewColumn(
                                isLargeScreen,
                                originalIndex,
                                question,
                                selectedAnswer,
                                isCorrect,
                                isOmitted,
                                subjectIcon,
                                subjectColor,
                                currentSubject,
                              ),
                            ),
                            _buildSidebarGrid(),
                          ],
                        ),
                      ),
                    )
                  : _buildMainReviewColumn(
                      isLargeScreen,
                      originalIndex,
                      question,
                      selectedAnswer,
                      isCorrect,
                      isOmitted,
                      subjectIcon,
                      subjectColor,
                      currentSubject,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBar(bool isLargeScreen) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.white70),
          ),
          const Expanded(
            child: Text(
              'Revisión de Respuestas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (!isLargeScreen)
            IconButton(
              onPressed: _showNavigationGrid,
              icon: const Icon(Icons.grid_view_rounded, color: Colors.white70),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildFilterButton('all', 'Todas'),
            _buildFilterButton('correct', 'Correctas'),
            _buildFilterButton('incorrect', 'Erróneas'),
            _buildFilterButton('omitted', 'Omitidas'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String val, String label) {
    final isSelected = _filter == val;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _filter = val;
            _applyFilter();
            _currentIndex = 0; // Reset index to first item of new filter list
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

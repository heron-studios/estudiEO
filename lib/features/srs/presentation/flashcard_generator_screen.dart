import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/screens/entrevista_simulator/puter_service.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:learn/models/question.dart';
import 'package:learn/models/srs_card.dart';
import 'package:learn/models/topic.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:uuid/uuid.dart';

class FlashcardGeneratorScreen extends StatefulWidget {
  const FlashcardGeneratorScreen({super.key});

  @override
  State<FlashcardGeneratorScreen> createState() =>
      _FlashcardGeneratorScreenState();
}

class _FlashcardGeneratorScreenState extends State<FlashcardGeneratorScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _isGenerating = false;
  int _generatedCount = 0;
  String _errorMessage = '';
  List<Question> _generatedQuestions = [];

  Future<void> _generateFlashcards() async {
    final text = _textController.text.trim();
    if (text.isEmpty || text.length < 50) {
      setState(
        () => _errorMessage =
            'El texto es muy corto. Pega al menos un párrafo de información.',
      );
      return;
    }
    if (text.length > 12000) {
      setState(
        () => _errorMessage =
            'El texto es demasiado largo (máx 12,000 caracteres). Por favor, resúmelo o divídelo en partes.',
      );
      return;
    }

    final storage = context.read<LocalStorageService>();
    if (!kIsWeb) {
      final lastGen = storage.loadLastFlashcardGenDate();
      final now = DateTime.now();
      if (lastGen != null &&
          lastGen.year == now.year &&
          lastGen.month == now.month &&
          lastGen.day == now.day) {
        setState(
          () => _errorMessage =
              'Límite alcanzado: En la app móvil el límite es de 1 generación de flashcards por día. Vuelve mañana o usa la versión web que es ilimitada.',
        );
        return;
      }
    }

    setState(() {
      _isGenerating = true;
      _errorMessage = '';
      _generatedCount = 0;
      _generatedQuestions = [];
    });

    try {
      final puterService = PuterService();
      final jsonResponse = await puterService.generateFlashcardsFromText(text);

      String cleanJson = jsonResponse;
      final startIdx = jsonResponse.indexOf('{');
      final endIdx = jsonResponse.lastIndexOf('}');
      if (startIdx != -1 && endIdx != -1 && endIdx > startIdx) {
        cleanJson = jsonResponse.substring(startIdx, endIdx + 1);
      }

      final data = jsonDecode(cleanJson);
      if (data['flashcards'] == null || data['flashcards'] is! List) {
        throw const FormatException(
          'El formato JSON no contiene un array "flashcards".',
        );
      }

      String topicName = data['topicName']?.toString() ?? '';
      if (topicName.isEmpty) topicName = 'Mazo generado por IA';

      final List flashcards = data['flashcards'];
      if (!mounted) return;
      const uuid = Uuid();

      int count = 0;
      List<Question> newQuestions = [];

      for (var f in flashcards) {
        try {
          if (f['text'] == null ||
              f['options'] == null ||
              f['correctAnswer'] == null) {
            continue; // Ignorar si faltan campos clave
          }
          if (f['options'] is! List) continue;

          final List<String> options = List<String>.from(f['options']);
          if (options.length < 2) continue; // Mínimo 2 opciones

          int correctAnswer = f['correctAnswer'] is int
              ? f['correctAnswer']
              : int.tryParse(f['correctAnswer'].toString()) ?? 0;
          if (correctAnswer < 0 || correctAnswer >= options.length) {
            correctAnswer = 0; // Fallback seguro
          }

          final String questionId = 'ai_gen_${uuid.v4()}';
          final question = Question(
            id: questionId,
            topicId: 'temp_topic',
            text: f['text'],
            options: options,
            correctAnswer: correctAnswer,
            explanation: f['explanation'] ?? '',
          );

          newQuestions.add(question);
          count++;
        } catch (e) {
          debugPrint('Error parseando una tarjeta individual: $e');
        }
      }

      if (mounted) {
        if (count > 0) {
          if (!kIsWeb) storage.saveLastFlashcardGenDate(DateTime.now());
          _saveCustomTopic(topicName, newQuestions);

          setState(() {
            _isGenerating = false;
            _generatedCount = count;
            _generatedQuestions = newQuestions;
            _textController.clear();
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('¡Guardado automáticamente como "$topicName"!'),
              backgroundColor: const Color(0xFF8B5CF6),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          setState(() {
            _isGenerating = false;
            _errorMessage =
                'No se pudo extraer ninguna pregunta válida del texto.';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isGenerating = false;
          _errorMessage = 'Error de la IA: No se pudo procesar el texto.\n$e';
        });
      }
    }
  }

  // Eliminamos _showSaveDialog ya que el guardado ahora es automático

  void _saveCustomTopic(String name, List<Question> tempQuestions) {
    final storage = context.read<LocalStorageService>();
    final srsProvider = context.read<SrsProvider>();
    const uuid = Uuid();
    final topicId = 'ai_topic_${uuid.v4()}';

    final topic = Topic(
      id: topicId,
      subjectId: 'ai_custom_subject',
      name: name,
      description: 'Mazo generado por IA',
      questionCount: tempQuestions.length,
    );
    storage.saveCustomTopic(topic);

    for (var q in tempQuestions) {
      final newQ = Question(
        id: q.id,
        topicId: topicId,
        text: q.text,
        options: q.options,
        correctAnswer: q.correctAnswer,
        explanation: q.explanation,
      );
      storage.saveCustomQuestion(newQ);

      final srsCard = SrsCard(questionId: newQ.id, topicId: topicId);
      storage.saveSrsCard(srsCard);
    }

    srsProvider.forceReload();
    context.read<SubjectProvider>().reload(); // Refresh the subjects list
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090A0C),
      appBar: AppBar(
        title: const Text(
          'Generador IA',
          style: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background glows
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        color: Color(0xFF8B5CF6),
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Extraer Flashcards',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(
                              0xFF8B5CF6,
                            ).withValues(alpha: 0.5),
                          ),
                        ),
                        child: const Text(
                          'EXPERIMENTAL',
                          style: TextStyle(
                            color: Color(0xFF8B5CF6),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Pega tus apuntes de historia, cívica o cualquier tema. La IA leerá el texto y extraerá automáticamente las preguntas más importantes para que las repases en tu sistema SRS.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E28).withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: _textController,
                        maxLines: null,
                        expands: true,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          height: 1.5,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              'Pega tu texto aquí (mínimo un párrafo largo)...',
                          hintStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  if (_errorMessage.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.redAccent.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.error_outline_rounded,
                            color: Colors.redAccent,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _errorMessage,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  if (_generatedCount > 0) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.greenAccent.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.greenAccent,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '¡Éxito!',
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Se han generado $_generatedCount flashcards y se han añadido a tu cola de repaso.',
                                  style: const TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Preguntas Extraídas:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 2,
                      child: ListView.builder(
                        itemCount: _generatedQuestions.length,
                        itemBuilder: (context, index) {
                          final q = _generatedQuestions[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.1),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 1}. ${q.text}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Respuesta: ${q.options[q.correctAnswer]}',
                                  style: const TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isGenerating ? null : _generateFlashcards,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: _isGenerating
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'La IA está analizando...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Outfit',
                                  ),
                                ),
                              ],
                            )
                          : const Text(
                              'Generar Flashcards',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Outfit',
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

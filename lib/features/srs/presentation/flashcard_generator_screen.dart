import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/screens/entrevista_simulator/puter_service.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:learn/models/question.dart';
import 'package:learn/models/srs_card.dart';
import 'package:uuid/uuid.dart';

class FlashcardGeneratorScreen extends StatefulWidget {
  const FlashcardGeneratorScreen({super.key});

  @override
  State<FlashcardGeneratorScreen> createState() => _FlashcardGeneratorScreenState();
}

class _FlashcardGeneratorScreenState extends State<FlashcardGeneratorScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _isGenerating = false;
  int _generatedCount = 0;
  String _errorMessage = '';

  Future<void> _generateFlashcards() async {
    final text = _textController.text.trim();
    if (text.isEmpty || text.length < 50) {
      setState(() => _errorMessage = 'El texto es muy corto. Pega al menos un párrafo de información.');
      return;
    }

    setState(() {
      _isGenerating = true;
      _errorMessage = '';
      _generatedCount = 0;
    });

    try {
      final puterService = PuterService();
      final jsonResponse = await puterService.generateFlashcardsFromText(text);
      
      // Intentar extraer el JSON si la IA incluyó basura alrededor
      String cleanJson = jsonResponse;
      final startIdx = jsonResponse.indexOf('{');
      final endIdx = jsonResponse.lastIndexOf('}');
      if (startIdx != -1 && endIdx != -1 && endIdx > startIdx) {
        cleanJson = jsonResponse.substring(startIdx, endIdx + 1);
      }

      final data = jsonDecode(cleanJson);
      if (data['flashcards'] == null || data['flashcards'] is! List) {
        throw const FormatException('El formato JSON no contiene un array "flashcards".');
      }

      final List flashcards = data['flashcards'];
      if (!mounted) return;
      final storage = context.read<LocalStorageService>();
      const uuid = Uuid();

      int count = 0;
      for (var f in flashcards) {
        try {
          final String questionId = 'ai_gen_${uuid.v4()}';
          final List<String> options = List<String>.from(f['options']);
          
          final question = Question(
            id: questionId,
            topicId: 'ai_custom_topic',
            text: f['text'] ?? 'Pregunta IA',
            options: options,
            correctAnswer: f['correctAnswer'] ?? 0,
            explanation: f['explanation'] ?? '',
          );

          // Guardar pregunta en repositorio personalizado
          storage.saveCustomQuestion(question);

          // Crear SrsCard para el sistema de repetición espaciada
          final srsCard = SrsCard(
            questionId: questionId,
            topicId: 'ai_custom_topic',
          );
          storage.saveSrsCard(srsCard);
          
          count++;
        } catch (e) {
          debugPrint('Error parseando una tarjeta individual: $e');
        }
      }

      if (mounted) {
        setState(() {
          _isGenerating = false;
          _generatedCount = count;
          if (count > 0) {
            _textController.clear();
          } else {
            _errorMessage = 'No se pudo extraer ninguna pregunta válida del texto.';
          }
        });
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
        title: const Text('Generador IA', style: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background glows
          Positioned(
            top: -100, right: -50,
            child: Container(
              width: 300, height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                    blurRadius: 100,
                    spreadRadius: 20,
                  )
                ]
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
                      const Icon(Icons.auto_awesome_rounded, color: Color(0xFF8B5CF6), size: 28),
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
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF8B5CF6).withValues(alpha: 0.5)),
                        ),
                        child: const Text('EXPERIMENTAL', style: TextStyle(color: Color(0xFF8B5CF6), fontSize: 10, fontWeight: FontWeight.bold)),
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
                        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: _textController,
                        maxLines: null,
                        expands: true,
                        style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5),
                        decoration: InputDecoration(
                          hintText: 'Pega tu texto aquí (mínimo un párrafo largo)...',
                          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
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
                        border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 20),
                          const SizedBox(width: 10),
                          Expanded(child: Text(_errorMessage, style: const TextStyle(color: Colors.redAccent, fontSize: 13))),
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
                        border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_outline_rounded, color: Colors.greenAccent, size: 28),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('¡Éxito!', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 16)),
                                const SizedBox(height: 4),
                                Text('Se han generado $_generatedCount flashcards y se han añadido a tu cola de repaso.', style: const TextStyle(color: Colors.greenAccent, fontSize: 13)),
                              ],
                            ),
                          ),
                        ],
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: _isGenerating 
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
                              SizedBox(width: 12),
                              Text('La IA está analizando...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            ],
                          )
                        : const Text('Generar Flashcards', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
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

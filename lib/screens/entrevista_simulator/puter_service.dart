import 'package:flutter/widgets.dart';
import 'puter_service_mobile.dart';

/// Interfaz abstracta para comunicarse con el Tutor IA (Groq)
abstract class PuterService {
  /// Constructor factory que usa Groq para Web y Mobile
  factory PuterService() => getPuterService();

  /// Inicializa el servicio. Útil para cargar el WebView en móviles.
  /// Retorna un Widget que debe ser insertado en el árbol de widgets
  /// (o null en el caso de Web donde no se necesita WebView).
  Widget? buildBridgeWidget();

  /// Envía un prompt a Puter.js y retorna la respuesta.
  Future<String> chat(String prompt);

  /// Genera Flashcards a partir de un texto libre (Retorna JSON).
  Future<String> generateFlashcardsFromText(String text);
}

import 'dart:js_interop';
import 'package:flutter/widgets.dart';
import 'puter_service.dart';

// Definición de la interfaz de JS para interactuar con puter.js
@JS('puter.ai.chat')
external JSPromise _puterChat(JSString prompt, JSObject options);

/// Implementación Web de PuterService usando dart:js_interop
class PuterServiceWeb implements PuterService {
  @override
  Widget? buildBridgeWidget() {
    return null; // En web la librería se inyecta nativamente en index.html
  }

  @override
  Future<String> chat(String prompt) async {
    try {
      // De acuerdo a la documentación, usamos el modelo soportado
      final options = {'model': 'gpt-5.4-nano'}.jsify() as JSObject;
      final promise = _puterChat(prompt.toJS, options);
      
      // Esperamos que la promesa se resuelva.
      // La documentación de Puter v2 devuelve la respuesta directamente como string
      final responseAny = await promise.toDart;
      
      if (responseAny.isA<JSString>()) {
        return (responseAny as JSString).toDart;
      }
      
      // Fallback por si devuelve un objeto
      return responseAny.toString();
    } catch (e) {
      return 'Hubo un error al comunicarse con el jurado (Web): $e';
    }
  }
}

/// Factory que retorna esta implementación en la compilación web
PuterService getPuterService() => PuterServiceWeb();

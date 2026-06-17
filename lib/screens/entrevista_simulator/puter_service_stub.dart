import 'package:flutter/widgets.dart';
import 'puter_service.dart';

/// Implementación por defecto (stub) de PuterService
class PuterServiceStub implements PuterService {
  @override
  Widget? buildBridgeWidget() {
    return null; // El stub no hace nada
  }

  @override
  Future<String> chat(String prompt) {
    throw UnsupportedError('No se puede usar Puter.js en esta plataforma de esta forma.');
  }
}

/// Función que será sobreescrita por las importaciones condicionales
PuterService getPuterService() => PuterServiceStub();

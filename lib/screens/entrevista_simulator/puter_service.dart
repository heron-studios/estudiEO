import 'package:flutter/widgets.dart';

import 'puter_service_stub.dart'
    if (dart.library.js_interop) 'puter_service_web.dart'
    if (dart.library.io) 'puter_service_mobile.dart';

/// Interfaz abstracta para comunicarse con Puter.js
abstract class PuterService {
  /// Constructor factory que decide qué implementación usar basado en la plataforma
  factory PuterService() => getPuterService();

  /// Inicializa el servicio. Útil para cargar el WebView en móviles.
  /// Retorna un Widget que debe ser insertado en el árbol de widgets
  /// (o null en el caso de Web donde no se necesita WebView).
  Widget? buildBridgeWidget();

  /// Envía un prompt a Puter.js y retorna la respuesta.
  Future<String> chat(String prompt);
}

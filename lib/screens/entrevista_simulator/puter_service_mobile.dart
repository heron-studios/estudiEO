import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'puter_service.dart';

/// Implementación Móvil de PuterService usando webview_flutter
class PuterServiceMobile implements PuterService {
  late final WebViewController _controller;
  Completer<String>? _currentChatCompleter;
  bool _isReady = false;

  PuterServiceMobile() {
    _initWebView();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel(
        'PuterChannel',
        onMessageReceived: (JavaScriptMessage message) {
          _handleMessage(message.message);
        },
      )
      ..loadFlutterAsset('assets/html/puter_bridge.html');
  }

  void _handleMessage(String messageStr) {
    try {
      final data = jsonDecode(messageStr);
      final status = data['status'];
      
      if (status == 'ready') {
        _isReady = true;
      } else if (data['type'] == 'chat_response') {
        if (_currentChatCompleter != null && !_currentChatCompleter!.isCompleted) {
          if (status == 'success') {
            _currentChatCompleter!.complete(data['response']);
          } else {
            _currentChatCompleter!.completeError(data['error'] ?? 'Error desconocido en Puter.js');
          }
          _currentChatCompleter = null;
        }
      }
    } catch (e) {
      debugPrint('Error decodificando mensaje de WebView: $e');
    }
  }

  @override
  Widget? buildBridgeWidget() {
    // Retornamos un WebView oculto de 1x1 pixel.
    return SizedBox(
      width: 1,
      height: 1,
      child: WebViewWidget(controller: _controller),
    );
  }

  @override
  Future<String> chat(String prompt) async {
    if (!_isReady) {
      // Esperamos un momento si el WebView no ha terminado de cargar
      await Future.delayed(const Duration(milliseconds: 500));
      if (!_isReady) {
        return 'El sistema aún se está inicializando. Por favor intenta de nuevo.';
      }
    }

    if (_currentChatCompleter != null && !_currentChatCompleter!.isCompleted) {
      return 'El jurado está pensando, espera un momento.';
    }

    _currentChatCompleter = Completer<String>();

    final jsCommand = '''
      handleFlutterMessage(JSON.stringify({
        "action": "chat",
        "prompt": ${jsonEncode(prompt)}
      }));
    ''';

    try {
      await _controller.runJavaScript(jsCommand);
      return await _currentChatCompleter!.future;
    } catch (e) {
      _currentChatCompleter = null;
      return 'Hubo un error de comunicación con el jurado (Mobile): $e';
    }
  }
}

/// Factory que retorna esta implementación en compilación móvil (iOS/Android)
PuterService getPuterService() => PuterServiceMobile();

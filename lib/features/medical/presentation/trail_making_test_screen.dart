import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import '../data/trail_making_levels.dart';
import '../models/trail_node.dart';

class TrailMakingTestScreen extends StatefulWidget {
  const TrailMakingTestScreen({super.key});

  @override
  State<TrailMakingTestScreen> createState() => _TrailMakingTestScreenState();
}

class _TrailMakingTestScreenState extends State<TrailMakingTestScreen> {
  late TrailLevel currentLevel;

  List<TrailNode> connectedNodes = [];
  Offset? currentDragPosition;
  bool hasError = false;

  int _secondsRemaining = 0;
  Timer? _timer;
  bool _isPlaying = false;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _loadLevel(TrailMakingLevels.levels.first);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _loadLevel(TrailLevel level) {
    _timer?.cancel();
    setState(() {
      currentLevel = level;
      connectedNodes.clear();
      currentDragPosition = null;
      hasError = false;
      _secondsRemaining = level.timeLimitSeconds;
      _isPlaying = false;
      _isFinished = false;
    });
  }

  void _startGame() {
    if (_isPlaying) return;
    setState(() {
      _isPlaying = true;
      _isFinished = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          _isPlaying = false;
          hasError = true;
          _isFinished = true;
        });
        _showGameOverDialog(
          '¡Tiempo agotado!',
          'Inténtalo de nuevo para mejorar tu velocidad.',
        );
      }
    });
  }

  void _showGameOverDialog(String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: NeuralTheme.of(context).surfaceCard,
          title: Text(
            title,
            style: TextStyle(
              color: NeuralTheme.of(context).textPrimary,
              fontFamily: 'Outfit',
            ),
          ),
          content: Text(
            message,
            style: TextStyle(color: NeuralTheme.of(context).textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _loadLevel(currentLevel);
              },
              child: Text(
                'Reintentar',
                style: TextStyle(color: NeuralTheme.of(context).blueGoogle),
              ),
            ),
            if (connectedNodes.length == currentLevel.nodes.length)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Go to next level if available
                  int nextIndex =
                      TrailMakingLevels.levels.indexOf(currentLevel) + 1;
                  if (nextIndex < TrailMakingLevels.levels.length) {
                    _loadLevel(TrailMakingLevels.levels[nextIndex]);
                  } else {
                    context.pop();
                  }
                },
                child: Text(
                  'Continuar',
                  style: TextStyle(color: NeuralTheme.of(context).successGreen),
                ),
              ),
          ],
        );
      },
    );
  }

  void _handlePanStart(DragStartDetails details, Size size) {
    if (!_isPlaying) _startGame();
    if (_isFinished) return;

    _checkCollision(details.localPosition, size);
  }

  void _handlePanUpdate(DragUpdateDetails details, Size size) {
    if (!_isPlaying || _isFinished) return;

    setState(() {
      currentDragPosition = details.localPosition;
    });

    _checkCollision(details.localPosition, size);
  }

  void _handlePanEnd(DragEndDetails details) {
    setState(() {
      currentDragPosition = null;
      hasError = false;
    });
  }

  void _checkCollision(Offset position, Size size) {
    const double nodeRadius = 25.0; // Radio visual del nodo

    for (var node in currentLevel.nodes) {
      // Coordenadas absolutas del nodo
      final Offset nodeCenter = Offset(
        node.xOffset * size.width,
        node.yOffset * size.height,
      );

      // Calcular distancia entre dedo y centro del nodo
      final double distance = (position - nodeCenter).distance;

      if (distance <= nodeRadius) {
        // Colisión detectada
        if (connectedNodes.contains(node)) {
          // Ya está conectado, no hacer nada o permitir volver a este si es el último
          if (connectedNodes.last == node) {
            setState(() {
              hasError = false;
            });
          }
          continue;
        }

        // Es el siguiente nodo correcto?
        if (node.sequenceIndex == connectedNodes.length) {
          // Correcto!
          setState(() {
            connectedNodes.add(node);
            hasError = false;

            // Check win
            if (connectedNodes.length == currentLevel.nodes.length) {
              _timer?.cancel();
              _isFinished = true;
              _showGameOverDialog(
                '¡Excelente!',
                'Has completado el test satisfactoriamente en ${currentLevel.timeLimitSeconds - _secondsRemaining} segundos.',
              );
            }
          });
        } else {
          // Incorrecto
          if (connectedNodes.isNotEmpty) {
            setState(() {
              hasError = true;
            });
          }
        }
        break; // Solo chequear un nodo a la vez
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return NeuralBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'Test del Trazo',
            style: TextStyle(color: nt.textPrimary, fontFamily: 'Outfit'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<TrailLevel>(
                  value: currentLevel,
                  dropdownColor: nt.surfaceElevated,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: nt.textPrimaryAlt,
                  ),
                  style: TextStyle(color: nt.textPrimaryAlt, fontSize: 14),
                  onChanged: (TrailLevel? newLevel) {
                    if (newLevel != null) {
                      _loadLevel(newLevel);
                    }
                  },
                  items: TrailMakingLevels.levels
                      .map<DropdownMenuItem<TrailLevel>>((TrailLevel level) {
                        return DropdownMenuItem<TrailLevel>(
                          value: level,
                          child: Text(level.title),
                        );
                      })
                      .toList(),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: StaticGlassContainer(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      currentLevel.description,
                      style: TextStyle(color: nt.textSecondary, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: _secondsRemaining <= 5 ? nt.pink : nt.cyan,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            color: _secondsRemaining <= 5
                                ? nt.pink
                                : nt.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: StaticGlassContainer(
                  padding: EdgeInsets.zero,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GestureDetector(
                        onPanStart: (details) => _handlePanStart(
                          details,
                          Size(constraints.maxWidth, constraints.maxHeight),
                        ),
                        onPanUpdate: (details) => _handlePanUpdate(
                          details,
                          Size(constraints.maxWidth, constraints.maxHeight),
                        ),
                        onPanEnd: _handlePanEnd,
                        child: CustomPaint(
                          size: Size(
                            constraints.maxWidth,
                            constraints.maxHeight,
                          ),
                          painter: TrailPainter(
                            level: currentLevel,
                            connectedNodes: connectedNodes,
                            currentDragPosition: currentDragPosition,
                            hasError: hasError,
                            nt: nt,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class TrailPainter extends CustomPainter {
  final TrailLevel level;
  final List<TrailNode> connectedNodes;
  final Offset? currentDragPosition;
  final bool hasError;
  final NeuralThemeData nt;

  TrailPainter({
    required this.level,
    required this.connectedNodes,
    required this.currentDragPosition,
    required this.hasError,
    required this.nt,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double nodeRadius = 22.0;

    // Paints
    final linePaint = Paint()
      ..color = nt.cyan
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final errorLinePaint = Paint()
      ..color = nt.pink
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final nodePaint = Paint()
      ..color = nt.surfaceElevated
      ..style = PaintingStyle.fill;

    final nodeBorderPaint = Paint()
      ..color = nt.borderSubtle
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final connectedNodeBorderPaint = Paint()
      ..color = nt.cyan
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    // 1. Draw connected lines
    for (int i = 0; i < connectedNodes.length - 1; i++) {
      final p1 = Offset(
        connectedNodes[i].xOffset * size.width,
        connectedNodes[i].yOffset * size.height,
      );
      final p2 = Offset(
        connectedNodes[i + 1].xOffset * size.width,
        connectedNodes[i + 1].yOffset * size.height,
      );
      canvas.drawLine(p1, p2, linePaint);
    }

    // 2. Draw current drag line
    if (connectedNodes.isNotEmpty && currentDragPosition != null) {
      final lastNode = connectedNodes.last;
      final p1 = Offset(
        lastNode.xOffset * size.width,
        lastNode.yOffset * size.height,
      );
      canvas.drawLine(
        p1,
        currentDragPosition!,
        hasError ? errorLinePaint : linePaint,
      );
    }

    // 3. Draw nodes
    for (var node in level.nodes) {
      final center = Offset(
        node.xOffset * size.width,
        node.yOffset * size.height,
      );
      final isConnected = connectedNodes.contains(node);

      // Circle background
      canvas.drawCircle(center, nodeRadius, nodePaint);

      // Circle border
      canvas.drawCircle(
        center,
        nodeRadius,
        isConnected ? connectedNodeBorderPaint : nodeBorderPaint,
      );

      // Text label
      final textSpan = TextSpan(
        text: node.label,
        style: TextStyle(
          color: isConnected ? nt.cyan : nt.textPrimaryAlt,
          fontSize: node.label.length > 2 ? 10 : 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Outfit',
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      textPainter.layout(minWidth: 0, maxWidth: nodeRadius * 2);

      // Center text
      final textOffset = Offset(
        center.dx - (textPainter.width / 2),
        center.dy - (textPainter.height / 2),
      );

      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(covariant TrailPainter oldDelegate) {
    return oldDelegate.connectedNodes.length != connectedNodes.length ||
        oldDelegate.currentDragPosition != currentDragPosition ||
        oldDelegate.hasError != hasError ||
        oldDelegate.level != level;
  }
}

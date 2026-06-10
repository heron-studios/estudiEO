import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import '../data/anp_repository.dart';
import '../data/anp_model.dart';

class ANPMapView extends StatefulWidget {
  const ANPMapView({super.key});

  @override
  State<ANPMapView> createState() => _ANPMapViewState();
}

class _ANPMapViewState extends State<ANPMapView>
    with TickerProviderStateMixin {
  bool _isBlindMode = false;
  ANPModel? _selectedANP;
  final List<ANPModel> _anps = ANPRepository.getAllANPs();

  // Category filter
  String _activeFilter = 'Todos';
  static const List<String> _filters = [
    'Todos',
    'Parque Nacional',
    'Reserva Nacional',
    'Santuario Nacional',
    'Santuario Histórico',
  ];

  // Blind game mode state
  ANPModel? _targetANP;
  int _gameScore = 0;
  int _gameTotal = 0;
  String _gameMessage =
      '¡Bienvenido al Desafío Geográfico! Toca el pin correcto.';
  Color _messageColor = Colors.white70;
  List<String> _remainingGameAnps = [];
  bool _showCorrectLocation = false;
  ANPModel? _incorrectTappedANP;

  // Pulse animation for selected pin
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnimation =
        Tween<double>(begin: 1.0, end: 1.3).animate(_pulseController);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  List<ANPModel> get _filteredANPs {
    if (_activeFilter == 'Todos') return _anps;
    return _anps.where((a) => a.category == _activeFilter).toList();
  }

  void _startBlindGame() {
    setState(() {
      _isBlindMode = true;
      _gameScore = 0;
      _gameTotal = 0;
      _selectedANP = null;
      _incorrectTappedANP = null;
      _showCorrectLocation = false;
      _remainingGameAnps =
          _anps.map((e) => e.id).toList()..shuffle();
      _nextGameTurn();
    });
  }

  void _stopBlindGame() {
    setState(() {
      _isBlindMode = false;
      _targetANP = null;
      _selectedANP = null;
      _incorrectTappedANP = null;
      _showCorrectLocation = false;
    });
  }

  void _nextGameTurn() {
    if (_remainingGameAnps.isEmpty) {
      _confettiController.play();
      setState(() {
        _targetANP = null;
        _gameMessage =
            '¡Felicidades! Has ubicado todas las áreas con éxito.';
        _messageColor = Colors.greenAccent;
      });
      return;
    }
    setState(() {
      final nextId = _remainingGameAnps.removeLast();
      _targetANP = _anps.firstWhere((e) => e.id == nextId);
      _incorrectTappedANP = null;
      _showCorrectLocation = false;
      _gameMessage = 'Ubica en el mapa: ${_targetANP!.name}';
      _messageColor = Colors.white;
    });
  }

  void _handlePinTap(ANPModel tapped) {
    if (!_isBlindMode) {
      setState(() {
        _selectedANP = _selectedANP?.id == tapped.id ? null : tapped;
      });
      return;
    }

    if (_showCorrectLocation) return;

    setState(() {
      _gameTotal++;
      if (tapped.id == _targetANP!.id) {
        _gameScore++;
        _gameMessage = '¡Correcto! Es ${_targetANP!.name}.';
        _messageColor = Colors.greenAccent;
        _showCorrectLocation = true;
        _selectedANP = tapped;
        Future.delayed(const Duration(milliseconds: 1800), () {
          if (mounted && _isBlindMode) {
            _nextGameTurn();
          }
        });
      } else {
        _incorrectTappedANP = tapped;
        _gameMessage =
            'Incorrecto. Ese es ${tapped.name}.\n¡Mira la ubicación correcta!';
        _messageColor = Colors.redAccent;
        _showCorrectLocation = true;
        _selectedANP = _targetANP;
        Future.delayed(const Duration(milliseconds: 3000), () {
          if (mounted && _isBlindMode) {
            _nextGameTurn();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return Scaffold(
      backgroundColor: nt.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          _isBlindMode ? 'Desafío del Guardaparque' : 'Mapa Interactivo',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton.icon(
            icon: Icon(
              _isBlindMode
                  ? Icons.explore_rounded
                  : Icons.visibility_off_rounded,
              color:
                  _isBlindMode ? Colors.greenAccent : Colors.orangeAccent,
              size: 20,
            ),
            label: Text(
              _isBlindMode ? 'Explorar' : 'Modo Ciego',
              style: TextStyle(
                  color: _isBlindMode
                      ? Colors.greenAccent
                      : Colors.orangeAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            onPressed: () {
              if (_isBlindMode) {
                _stopBlindGame();
              } else {
                _startBlindGame();
              }
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: NeuralBackgroundWrapper(
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  // Status Panel
                  _isBlindMode
                      ? _buildBlindGamePanel(nt)
                      : _buildExplorePanel(nt),

                  // Category Filter Chips (only in explore mode)
                  if (!_isBlindMode)
                    _buildFilterChips(nt),

                  // Map Canvas
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;
                          final height = constraints.maxHeight;

                          return Stack(
                            children: [
                              // Map silhouette
                              Positioned.fill(
                                child: CustomPaint(
                                  painter: PeruMapPainter(
                                    coastalColor: nt.cyan,
                                    sierraColor: nt.warningAmber,
                                    selvaColor: nt.successGreen,
                                  ),
                                ),
                              ),

                              // Map Legend (explore mode)
                              if (!_isBlindMode)
                                Positioned(
                                  right: 0,
                                  top: 8,
                                  child: _buildMapLegend(nt),
                                ),

                              // Pins
                              ..._filteredANPs.map((anp) {
                                final isSelected =
                                    _selectedANP?.id == anp.id;
                                final isTarget = _isBlindMode &&
                                    _targetANP?.id == anp.id;
                                final isIncorrectTapped = _isBlindMode &&
                                    _incorrectTappedANP?.id == anp.id;

                                double size = 28;
                                Color pinColor = nt.successGreen;

                                if (_isBlindMode) {
                                  if (_showCorrectLocation && isTarget) {
                                    pinColor = Colors.greenAccent;
                                    size = 42;
                                  } else if (_showCorrectLocation &&
                                      isIncorrectTapped) {
                                    pinColor = Colors.redAccent;
                                    size = 36;
                                  } else {
                                    pinColor = nt.blueGoogle;
                                  }
                                } else {
                                  final catColor = _getCategoryColor(
                                      anp.category, nt);
                                  pinColor = isSelected
                                      ? Colors.orangeAccent
                                      : catColor;
                                  if (isSelected) size = 38;
                                }

                                return Positioned(
                                  left: anp.relativeX * width - (size / 2),
                                  top: anp.relativeY * height - size,
                                  child: GestureDetector(
                                    onTap: () => _handlePinTap(anp),
                                    child: isSelected && !_isBlindMode
                                        ? AnimatedBuilder(
                                            animation: _pulseAnimation,
                                            builder: (ctx, child) =>
                                                Transform.scale(
                                              scale: _pulseAnimation.value,
                                              child: child,
                                            ),
                                            child: _buildInteractivePin(
                                                anp, pinColor, size),
                                          )
                                        : _buildInteractivePin(
                                            anp, pinColor, size),
                                  ),
                                );
                              }),
                            ],
                          );
                        },
                      ),
                    ),
                  ),

                  // Bottom detail sheet
                  if (_selectedANP != null) _buildDetailSheet(nt),
                ],
              ),
            ),

            // Confetti Overlay
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 24,
                colors: const [
                  Colors.greenAccent,
                  Colors.blueAccent,
                  Colors.orangeAccent
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category, NeuralThemeData nt) {
    switch (category) {
      case 'Parque Nacional':
        return nt.successGreen;
      case 'Reserva Nacional':
        return nt.blueGoogle;
      case 'Santuario Nacional':
        return nt.warningAmber;
      case 'Santuario Histórico':
        return nt.pink;
      default:
        return nt.cyan;
    }
  }

  Widget _buildBlindGamePanel(NeuralThemeData nt) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      margin:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: nt.surfaceCard.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _gameMessage,
                  style: TextStyle(
                      color: _messageColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
                if (_targetANP != null) ...[
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.tips_and_updates_rounded,
                          color: nt.warningAmber, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        'Pista: ${_targetANP!.regions.join(", ")}',
                        style: const TextStyle(
                            color: Colors.white38, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: nt.blueGoogle.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: nt.blueGoogle.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Text(
                  '$_gameScore/$_gameTotal',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Text(
                  'Score',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplorePanel(NeuralThemeData nt) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        children: [
          Icon(Icons.touch_app_rounded,
              color: Colors.white.withValues(alpha: 0.4), size: 16),
          const SizedBox(width: 6),
          Text(
            'Toca los pines para explorar las ANPs',
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 12),
          ),
          const Spacer(),
          Text(
            '${_filteredANPs.length} áreas',
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(NeuralThemeData nt) {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        itemBuilder: (context, i) {
          final filter = _filters[i];
          final isActive = filter == _activeFilter;
          final color = i == 0
              ? nt.cyan
              : _getCategoryColor(filter, nt);
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () =>
                  setState(() => _activeFilter = filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isActive
                      ? color.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isActive
                        ? color.withValues(alpha: 0.6)
                        : Colors.white.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Text(
                  filter == 'Todos' ? 'Todas' : filter.split(' ').last,
                  style: TextStyle(
                    color: isActive ? color : Colors.white38,
                    fontSize: 11,
                    fontWeight: isActive
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMapLegend(NeuralThemeData nt) {
    final items = [
      ('Parque Nac.', nt.successGreen),
      ('Reserva Nac.', nt.blueGoogle),
      ('Santuario Nac.', nt.warningAmber),
      ('Santuario Hist.', nt.pink),
    ];
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on_rounded,
                    color: item.$2, size: 12),
                const SizedBox(width: 4),
                Text(
                  item.$1,
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 9),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInteractivePin(
      ANPModel anp, Color pinColor, double size) {
    return Tooltip(
      message: _isBlindMode ? '???' : anp.name,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              Icons.location_on_rounded,
              color: pinColor,
              size: size,
              shadows: [
                Shadow(
                  color: pinColor.withValues(alpha: 0.5),
                  blurRadius: 8,
                )
              ],
            ),
          ),
          if (!_isBlindMode)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: pinColor.withValues(alpha: 0.3),
                    width: 0.5),
              ),
              child: Text(
                anp.name.length > 14
                    ? '${anp.name.substring(0, 11)}...'
                    : anp.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailSheet(NeuralThemeData nt) {
    final isIndirect = _selectedANP!.useType.contains('Indirecto');
    // Relative size compared to the largest ANP
    final maxExt = _anps
        .map((a) => a.extensionHa)
        .reduce((a, b) => a > b ? a : b);
    final relativeSize = _selectedANP!.extensionHa / maxExt;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      constraints: const BoxConstraints(maxHeight: 280),
      decoration: BoxDecoration(
        color: nt.surfaceCard.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white12),
        boxShadow: const [
          BoxShadow(
              color: Colors.black45,
              blurRadius: 20,
              offset: Offset(0, 10)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _selectedANP!.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: Colors.white38, size: 20),
                    onPressed: () =>
                        setState(() => _selectedANP = null),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Badges row
              Row(
                children: [
                  _buildBadge(
                    isIndirect
                        ? 'Uso Indirecto'
                        : 'Uso Directo',
                    isIndirect ? nt.pink : nt.successGreen,
                  ),
                  const SizedBox(width: 8),
                  _buildBadge(
                    _selectedANP!.category,
                    nt.blueGoogle,
                  ),
                  const SizedBox(width: 8),
                  _buildBadge(
                    'Est. ${_selectedANP!.establishedYear}',
                    nt.purple,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Region
              _buildInfoRow(
                  Icons.map_rounded,
                  'Regiones:',
                  _selectedANP!.regions.join(', '),
                  nt.purple),
              // Fauna
              _buildInfoRow(
                  Icons.pets_rounded,
                  'Fauna:',
                  _selectedANP!.keyFauna.join(' · '),
                  nt.successGreen),
              const SizedBox(height: 10),
              // Relative size bar
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Extensión relativa',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 11),
                  ),
                  Text(
                    '${(_selectedANP!.extensionHa / 1000).toStringAsFixed(1)}K Ha',
                    style: TextStyle(
                        color: nt.cyan,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: SizedBox(
                  height: 5,
                  child: Stack(
                    children: [
                      Container(
                          color: Colors.white
                              .withValues(alpha: 0.08)),
                      AnimatedContainer(
                        duration:
                            const Duration(milliseconds: 600),
                        width: (MediaQuery.of(context).size.width -
                                72) *
                            relativeSize,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [nt.cyan, nt.blueGoogle],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Mnemonic
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: Colors.white10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb_rounded,
                        color: nt.warningAmber, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _selectedANP!.mnemonicHint,
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
                color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Peru Map
class PeruMapPainter extends CustomPainter {
  final Color coastalColor;
  final Color sierraColor;
  final Color selvaColor;

  const PeruMapPainter({
    required this.coastalColor,
    required this.sierraColor,
    required this.selvaColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Background grid dots (ocean texture)
    final dotPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..style = PaintingStyle.fill;
    final r = Random(42);
    for (int i = 0; i < 60; i++) {
      canvas.drawCircle(
          Offset(r.nextDouble() * w, r.nextDouble() * h), 1.2, dotPaint);
    }

    // Costa path
    final pathCosta = Path();
    pathCosta.moveTo(w * 0.16, h * 0.16);
    pathCosta.lineTo(w * 0.28, h * 0.30);
    pathCosta.lineTo(w * 0.32, h * 0.40);
    pathCosta.lineTo(w * 0.35, h * 0.48);
    pathCosta.lineTo(w * 0.38, h * 0.54);
    pathCosta.lineTo(w * 0.43, h * 0.65);
    pathCosta.lineTo(w * 0.55, h * 0.76);
    pathCosta.lineTo(w * 0.70, h * 0.85);
    pathCosta.lineTo(w * 0.66, h * 0.80);
    pathCosta.lineTo(w * 0.52, h * 0.71);
    pathCosta.lineTo(w * 0.40, h * 0.60);
    pathCosta.lineTo(w * 0.33, h * 0.45);
    pathCosta.lineTo(w * 0.28, h * 0.30);
    pathCosta.lineTo(w * 0.22, h * 0.20);
    pathCosta.close();

    // Sierra path
    final pathSierra = Path();
    pathSierra.moveTo(w * 0.22, h * 0.20);
    pathSierra.lineTo(w * 0.28, h * 0.30);
    pathSierra.lineTo(w * 0.33, h * 0.45);
    pathSierra.lineTo(w * 0.40, h * 0.60);
    pathSierra.lineTo(w * 0.52, h * 0.71);
    pathSierra.lineTo(w * 0.66, h * 0.80);
    pathSierra.lineTo(w * 0.70, h * 0.85);
    pathSierra.lineTo(w * 0.81, h * 0.77);
    pathSierra.lineTo(w * 0.74, h * 0.68);
    pathSierra.lineTo(w * 0.62, h * 0.60);
    pathSierra.lineTo(w * 0.50, h * 0.46);
    pathSierra.lineTo(w * 0.45, h * 0.30);
    pathSierra.lineTo(w * 0.30, h * 0.21);
    pathSierra.close();

    // Selva path
    final pathSelva = Path();
    pathSelva.moveTo(w * 0.30, h * 0.21);
    pathSelva.lineTo(w * 0.45, h * 0.30);
    pathSelva.lineTo(w * 0.50, h * 0.46);
    pathSelva.lineTo(w * 0.62, h * 0.60);
    pathSelva.lineTo(w * 0.74, h * 0.68);
    pathSelva.lineTo(w * 0.81, h * 0.77);
    pathSelva.lineTo(w * 0.85, h * 0.69);
    pathSelva.lineTo(w * 0.83, h * 0.55);
    pathSelva.lineTo(w * 0.88, h * 0.32);
    pathSelva.lineTo(w * 0.68, h * 0.16);
    pathSelva.lineTo(w * 0.52, h * 0.12);
    pathSelva.close();

    void drawRegion(Path path, Color color) {
      canvas.drawPath(
          path,
          Paint()
            ..color = color.withValues(alpha: 0.14)
            ..style = PaintingStyle.fill);
      canvas.drawPath(
          path,
          Paint()
            ..color = color.withValues(alpha: 0.45)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.8);
    }

    drawRegion(pathCosta, coastalColor);
    drawRegion(pathSierra, sierraColor);
    drawRegion(pathSelva, selvaColor);

    // Outer border of Peru (glow effect)
    final pathOutline = Path()
      ..moveTo(w * 0.16, h * 0.16)
      ..lineTo(w * 0.30, h * 0.35)
      ..lineTo(w * 0.35, h * 0.48)
      ..lineTo(w * 0.38, h * 0.54)
      ..lineTo(w * 0.43, h * 0.65)
      ..lineTo(w * 0.55, h * 0.76)
      ..lineTo(w * 0.70, h * 0.85)
      ..lineTo(w * 0.81, h * 0.77)
      ..lineTo(w * 0.85, h * 0.69)
      ..lineTo(w * 0.83, h * 0.55)
      ..lineTo(w * 0.88, h * 0.32)
      ..lineTo(w * 0.68, h * 0.16)
      ..lineTo(w * 0.52, h * 0.12)
      ..lineTo(w * 0.30, h * 0.21)
      ..close();

    canvas.drawPath(
        pathOutline,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.15)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

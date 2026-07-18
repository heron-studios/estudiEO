import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:confetti/confetti.dart';
import '../data/anp_repository.dart';
import '../data/anp_model.dart';
import '../domain/spaced_repetition_engine.dart';
import 'dart:math';

class ANPFlashcardsView extends StatefulWidget {
  const ANPFlashcardsView({super.key});

  @override
  State<ANPFlashcardsView> createState() => _ANPFlashcardsViewState();
}

class _ANPFlashcardsViewState extends State<ANPFlashcardsView> {
  final SpacedRepetitionEngine _engine = SpacedRepetitionEngine();
  final List<ANPModel> _allAnps = ANPRepository.getAllANPs();

  List<String> _studyQueue = [];
  int _currentIndex = 0;
  int _cardsReviewedThisSession = 0;

  late ConfettiController _confettiController;
  final GlobalKey<_FlipCardState> _cardKey = GlobalKey<_FlipCardState>();

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    _engine.initItems(_allAnps.map((e) => e.id).toList());
    _loadQueue();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _loadQueue() {
    // Priority: due items first. If none are due, load all items shuffled.
    final due = _engine.getDueItems(15);
    if (due.isNotEmpty) {
      _studyQueue = due;
    } else {
      _studyQueue = _allAnps.map((e) => e.id).toList()..shuffle();
    }
    _currentIndex = 0;
    _cardsReviewedThisSession = 0;
  }

  void _submitReview(int qualityScore) {
    if (_studyQueue.isEmpty) return;

    final currentId = _studyQueue[_currentIndex];

    // Process in engine
    _engine.processAnswer(currentId, qualityScore);

    setState(() {
      _cardsReviewedThisSession++;
    });

    // Make sure we flip the card back to front before showing the next one
    if (_cardKey.currentState != null && !_cardKey.currentState!._isFront) {
      _cardKey.currentState!._flipSilent();
    }

    // Delay slightly to allow flip animation to complete
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        if (_currentIndex < _studyQueue.length - 1) {
          _currentIndex++;
        } else {
          // Finished session
          _confettiController.play();
          _showSessionFinishedDialog();
        }
      });
    });
  }

  void _showSessionFinishedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: NeuralTheme.of(context).surfaceCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          title: const Text(
            '¡Sesión Completada! 🎉',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Has repasado $_cardsReviewedThisSession tarjetas de áreas naturales usando repetición espaciada.\n\nEl algoritmo SM-2 ha programado las fechas de tus próximos repasos.',
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop(); // close dialog
                context.pop(); // return to dashboard
              },
              child: const Text(
                'Volver al Menú',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop(); // close dialog
                setState(() {
                  _loadQueue();
                });
              },
              child: const Text(
                'Repasar otra vez',
                style: TextStyle(color: Colors.orangeAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    if (_studyQueue.isEmpty) {
      return Scaffold(
        backgroundColor: nt.background,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: const Center(
          child: Text(
            'Cargando tarjetas...',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final currentAnpId = _studyQueue[_currentIndex];
    final currentANP = _allAnps.firstWhere((e) => e.id == currentAnpId);
    final srsItem = _engine.getItem(currentAnpId);

    // Calculate progress
    final double progress = (_currentIndex) / _studyQueue.length;

    return Scaffold(
      backgroundColor: nt.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Repaso Inteligente (SM-2)',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: NeuralBackgroundWrapper(
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    // Progress and stats card
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progreso: ${_currentIndex + 1} de ${_studyQueue.length}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'EF: ${srsItem?.easinessFactor.toStringAsFixed(2) ?? '2.50'}',
                            style: TextStyle(
                              color: nt.cyan,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Custom animated progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: SizedBox(
                        height: 6,
                        child: Stack(
                          children: [
                            Container(color: Colors.white10),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width:
                                  MediaQuery.of(context).size.width * progress,
                              color: nt.blueGoogle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // The Flashcard itself
                    Expanded(
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 0.72,
                          child: _FlipCard(
                            key: _cardKey,
                            anp: currentANP,
                            onReview: _submitReview,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Toca la tarjeta para ver los datos clave del SINANPE',
                      style: TextStyle(color: Colors.white30, fontSize: 12),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Confetti Overlay
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlipCard extends StatefulWidget {
  final ANPModel anp;
  final Function(int) onReview;

  const _FlipCard({super.key, required this.anp, required this.onReview});

  @override
  State<_FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<_FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(covariant _FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.anp.id != widget.anp.id) {
      _isFront = true;
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flip() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isFront = !_isFront;
    });
  }

  void _flipSilent() {
    _isFront = true;
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          final isUnder = angle > pi / 2;
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateY(angle),
            alignment: Alignment.center,
            child: isUnder
                ? Transform(
                    transform: Matrix4.rotationY(pi),
                    alignment: Alignment.center,
                    child: _buildBack(),
                  )
                : _buildFront(),
          );
        },
      ),
    );
  }

  Widget _buildFront() {
    final nt = NeuralTheme.of(context);
    final isIndirect = widget.anp.useType.contains('Indirecto');

    return Container(
      decoration: BoxDecoration(
        color: nt.surfaceCard.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: (isIndirect ? nt.pink : nt.successGreen).withValues(
                alpha: 0.12,
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: (isIndirect ? nt.pink : nt.successGreen).withValues(
                  alpha: 0.3,
                ),
              ),
            ),
            child: Icon(
              Icons.landscape_rounded,
              size: 72,
              color: isIndirect ? nt.pink : nt.successGreen,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            widget.anp.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.01,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: nt.blueGoogle.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: nt.blueGoogle.withValues(alpha: 0.3)),
            ),
            child: Text(
              widget.anp.category,
              style: TextStyle(
                color: nt.blueGoogle,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const Spacer(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.touch_app_rounded, color: Colors.white30, size: 16),
              SizedBox(width: 6),
              Text(
                'Toca para revelar respuestas',
                style: TextStyle(color: Colors.white30, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBack() {
    final nt = NeuralTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: nt.surfaceCard.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Datos de Admisión',
            style: TextStyle(
              color: Colors.orangeAccent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          _infoRow('Región:', widget.anp.regions.join(', ')),
          _infoRow(
            'Establecido:',
            '${widget.anp.establishedYear} (${DateTime.now().year - widget.anp.establishedYear} años)',
          ),
          _infoRow('Tipo de Uso:', widget.anp.useType),
          _infoRow('Fauna Clave:', widget.anp.keyFauna.join(', ')),
          const SizedBox(height: 16),
          const Text(
            'Mnemotecnia:',
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                widget.anp.mnemonicHint,
                style: const TextStyle(
                  color: Colors.white70,
                  height: 1.4,
                  fontStyle: FontStyle.italic,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // SM-2 Review feedback buttons
          const Text(
            '¿Qué tan bien lo recordabas?',
            style: TextStyle(
              color: Colors.white30,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildReviewButton(
                  label: 'Difícil',
                  desc: 'Repetir hoy',
                  color: nt.pink,
                  onPressed: () => widget.onReview(2), // SM-2 low quality
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildReviewButton(
                  label: 'Bien',
                  desc: 'Mañana',
                  color: nt.warningAmber,
                  onPressed: () => widget.onReview(4), // SM-2 good
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildReviewButton(
                  label: 'Fácil',
                  desc: 'En días',
                  color: nt.successGreen,
                  onPressed: () => widget.onReview(5), // SM-2 perfect
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewButton({
    required String label,
    required String desc,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.15),
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: BorderSide(color: color.withValues(alpha: 0.3), width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            desc,
            style: TextStyle(color: color.withValues(alpha: 0.6), fontSize: 9),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

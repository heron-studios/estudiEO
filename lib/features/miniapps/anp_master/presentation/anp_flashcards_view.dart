import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import '../data/anp_repository.dart';
import '../data/anp_model.dart';
import 'dart:math';

class ANPFlashcardsView extends StatefulWidget {
  const ANPFlashcardsView({super.key});

  @override
  State<ANPFlashcardsView> createState() => _ANPFlashcardsViewState();
}

class _ANPFlashcardsViewState extends State<ANPFlashcardsView> {
  final List<ANPModel> _anps = ANPRepository.getAllANPs();
  int _currentIndex = 0;

  void _nextCard() {
    setState(() {
      if (_currentIndex < _anps.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0; // Loop back
      }
    });
  }

  void _prevCard() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      } else {
        _currentIndex = _anps.length - 1; // Loop to end
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    final currentANP = _anps[_currentIndex];

    return Scaffold(
      backgroundColor: nt.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Flashcards de Alto Impacto',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${_currentIndex + 1} / ${_anps.length}',
                style: const TextStyle(color: Colors.white54, fontSize: 16),
              ),
              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: _FlipCard(anp: currentANP),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _prevCard,
                    icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                    iconSize: 32,
                  ),
                  const SizedBox(width: 48),
                  IconButton(
                    onPressed: _nextCard,
                    icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                    iconSize: 32,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlipCard extends StatefulWidget {
  final ANPModel anp;

  const _FlipCard({required this.anp});

  @override
  State<_FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<_FlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant _FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.anp.id != widget.anp.id) {
      if (!_isFront) {
        _isFront = true;
        _controller.reverse(from: 1.0);
      }
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
    _isFront = !_isFront;
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
            transform: Matrix4.rotationY(angle),
            alignment: Alignment.center,
            child: isUnder ? Transform(
              transform: Matrix4.rotationY(pi),
              alignment: Alignment.center,
              child: _buildBack(),
            ) : _buildFront(),
          );
        },
      ),
    );
  }

  Widget _buildFront() {
    final nt = NeuralTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: nt.surfaceCard,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.landscape_rounded, size: 80, color: nt.blueGoogle),
          const SizedBox(height: 24),
          Text(
            widget.anp.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: nt.blueGoogle.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.anp.category,
              style: TextStyle(color: nt.blueGoogle, fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          const Text(
            'Toca para voltear',
            style: TextStyle(color: Colors.white30),
          ),
        ],
      ),
    );
  }

  Widget _buildBack() {
    final nt = NeuralTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: nt.surfaceCard,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Datos Críticos',
            style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          _infoRow('Región:', widget.anp.regions.join(', ')),
          const SizedBox(height: 12),
          _infoRow('Creación:', widget.anp.establishedYear.toString()),
          const SizedBox(height: 12),
          _infoRow('Uso:', widget.anp.useType),
          const SizedBox(height: 12),
          _infoRow('Fauna:', widget.anp.keyFauna.join(', ')),
          const SizedBox(height: 24),
          const Text(
            'Regla Mnemotécnica:',
            style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            widget.anp.mnemonicHint,
            style: const TextStyle(color: Colors.white70, height: 1.5, fontStyle: FontStyle.italic),
          ),
          const Spacer(),
          const Center(
            child: Text(
              'Toca para voltear',
              style: TextStyle(color: Colors.white30),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white54),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

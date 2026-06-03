import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import '../data/anp_repository.dart';
import '../data/anp_model.dart';

class ANPMapView extends StatefulWidget {
  const ANPMapView({super.key});

  @override
  State<ANPMapView> createState() => _ANPMapViewState();
}

class _ANPMapViewState extends State<ANPMapView> {
  bool _isBlindMode = false;
  ANPModel? _selectedANP;
  final List<ANPModel> _anps = ANPRepository.getAllANPs();

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
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Mapa Interactivo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isBlindMode ? Icons.visibility_off_rounded : Icons.visibility_rounded,
              color: _isBlindMode ? Colors.orangeAccent : Colors.white,
            ),
            tooltip: 'Modo Ciego',
            onPressed: () {
              setState(() {
                _isBlindMode = !_isBlindMode;
              });
            },
          ),
        ],
      ),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: Column(
            children: [
              if (_isBlindMode)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Colors.orangeAccent.withValues(alpha: 0.2),
                  child: const Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Modo Ciego Activado. Adivina las regiones.',
                          style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      // Placeholder for the Vector Map of Peru
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.map_rounded, size: 64, color: Colors.white24),
                              SizedBox(height: 16),
                              Text(
                                'Lienzo del Mapa del PerÃº\n(Requiere SVGs)',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white54),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Mocking some interactive pins
                      ..._anps.asMap().entries.map((entry) {
                        final index = entry.key;
                        final anp = entry.value;
                        return Positioned(
                          top: 100.0 + (index * 60),
                          left: 100.0 + (index * 40),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedANP = anp;
                              });
                            },
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.greenAccent,
                                  size: 32,
                                ),
                                if (!_isBlindMode)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      anp.name,
                                      style: const TextStyle(color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              if (_selectedANP != null)
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: nt.surfaceCard,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  ),
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
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded, color: Colors.white54),
                            onPressed: () {
                              setState(() {
                                _selectedANP = null;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'CategorÃ­a: ${_selectedANP!.category}',
                        style: const TextStyle(color: Colors.greenAccent),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Uso: ${_selectedANP!.useType}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Regiones: ${_selectedANP!.regions.join(", ")}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Fauna Clave:',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                        spacing: 8,
                        children: _selectedANP!.keyFauna.map((f) {
                          return Chip(
                            backgroundColor: nt.blueGoogle.withValues(alpha: 0.2),
                            side: BorderSide.none,
                            label: Text(f, style: const TextStyle(color: Colors.white)),
                          );
                        }).toList(),
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
}

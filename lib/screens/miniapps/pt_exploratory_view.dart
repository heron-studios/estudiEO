import 'package:flutter/material.dart';
import 'package:learn/config/neural_theme.dart';
import 'package:learn/data/periodic_table_data.dart';
import 'package:learn/models/chemical_element.dart';

class PtExploratoryView extends StatelessWidget {
  const PtExploratoryView({super.key});

  Color _getFamilyColor(String family, NeuralThemeData nt) {
    switch (family) {
      case 'Metal alcalino': return const Color(0xFFF05252);
      case 'Metal alcalinotérreo': return const Color(0xFFFF7A00);
      case 'Metal de transición': return const Color(0xFFFFB020);
      case 'Metal del bloque p': return const Color(0xFF00A2FF);
      case 'Metaloide': return const Color(0xFF00D2B4);
      case 'No metal': return const Color(0xFF4ADE80);
      case 'Halógeno': return const Color(0xFFA855F7);
      case 'Gas noble': return const Color(0xFFEC4899);
      case 'Lantánido': return const Color(0xFFE879F9);
      case 'Actínido': return const Color(0xFFF472B6);
      default: return Colors.grey;
    }
  }

  void _showElementDetails(BuildContext context, ChemicalElement element, NeuralThemeData nt) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final color = _getFamilyColor(element.family, nt);
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: nt.surfaceElevated,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            border: Border(top: BorderSide(color: nt.borderSubtle)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    element.symbol,
                    style: TextStyle(
                      color: color,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                element.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  element.family.toUpperCase(),
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _InfoBox(label: 'NÚMERO ATÓMICO', value: element.atomicNumber.toString(), nt: nt),
                  _InfoBox(label: 'GRUPO', value: element.group.toString(), nt: nt),
                  _InfoBox(label: 'PERÍODO', value: element.period.toString(), nt: nt),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    const double cellSize = 56.0;
    const double spacing = 4.0;
    
    final width = 18 * (cellSize + spacing);
    final height = 9 * (cellSize + spacing) + 30; // Extra padding

    return Center(
      child: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(40),
        minScale: 0.1,
        maxScale: 3.0,
        constrained: false,
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: periodicTableElements.map((element) {
              final left = (element.gridColumn - 1) * (cellSize + spacing);
              // Add a gap between main table and lathanides/actinides
              double top = (element.gridRow - 1) * (cellSize + spacing);
              if (element.gridRow >= 8) {
                top += 20; // visual gap
              }

              final color = _getFamilyColor(element.family, nt);

              return Positioned(
                left: left,
                top: top,
                width: cellSize,
                height: cellSize,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _showElementDetails(context, element, nt),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        border: Border.all(color: color.withValues(alpha: 0.3)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4, top: 2),
                              child: Text(
                                '${element.atomicNumber}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                element.symbol,
                                style: TextStyle(
                                  color: color,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              element.name,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 8,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;
  final NeuralThemeData nt;

  const _InfoBox({required this.label, required this.value, required this.nt});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: nt.borderSubtle),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

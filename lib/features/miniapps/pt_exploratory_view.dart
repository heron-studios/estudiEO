import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:learn/core/config/neural_theme.dart';
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
    final color = _getFamilyColor(element.family, nt);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              decoration: BoxDecoration(
                color: nt.surfaceElevated.withValues(alpha: 0.8),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.2), width: 1.5)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.withValues(alpha: 0.3),
                          color.withValues(alpha: 0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(color: color.withValues(alpha: 0.6), width: 2),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        element.symbol,
                        style: TextStyle(
                          color: color,
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(color: color.withValues(alpha: 0.5), blurRadius: 10),
                          ]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    element.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: color.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      element.family.toUpperCase(),
                      style: TextStyle(
                        color: color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(child: _InfoBox(label: 'NÚMERO ATÓMICO', value: element.atomicNumber.toString(), icon: Icons.tag_rounded, color: color, nt: nt)),
                      const SizedBox(width: 12),
                      Expanded(child: _InfoBox(label: 'GRUPO', value: element.group.toString(), icon: Icons.view_column_rounded, color: color, nt: nt)),
                      const SizedBox(width: 12),
                      Expanded(child: _InfoBox(label: 'PERÍODO', value: element.period.toString(), icon: Icons.view_headline_rounded, color: color, nt: nt)),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    const double cellSize = 60.0;
    const double spacing = 6.0;
    
    const width = 18 * (cellSize + spacing) + 120;
    const height = 10 * (cellSize + spacing) + 120;

    return Center(
      child: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(80),
        minScale: 0.1,
        maxScale: 3.0,
        constrained: false,
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(24),
          child: Stack(
            children: periodicTableElements.map((element) {
              final left = (element.gridColumn - 1) * (cellSize + spacing);
              double top = (element.gridRow - 1) * (cellSize + spacing);
              if (element.gridRow >= 8) {
                top += 24; 
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
                    borderRadius: BorderRadius.circular(12),
                    hoverColor: color.withValues(alpha: 0.3),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withValues(alpha: 0.2),
                            color.withValues(alpha: 0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ]
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 4,
                            left: 6,
                            child: Text(
                              '${element.atomicNumber}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              element.symbol,
                              style: TextStyle(
                                color: color,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            left: 0,
                            right: 0,
                            child: Text(
                              element.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 9,
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
  final IconData icon;
  final Color color;
  final NeuralThemeData nt;

  const _InfoBox({
    required this.label, 
    required this.value, 
    required this.icon,
    required this.color,
    required this.nt
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color.withValues(alpha: 0.8), size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

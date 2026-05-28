/// neural_design_system.dart — Backward-compatibility shim
///
/// Todos los tokens de diseño han migrado a [NeuralTheme] / [NeuralThemeData]
/// en neural_theme.dart. Este archivo re-exporta las constantes más usadas
/// para que pantallas que aún no han migrado no rompan la compilación.
///
/// DEPRECADO: Usa NeuralTheme.of(context).* en código nuevo.
library;

import 'package:flutter/material.dart';

export 'package:learn/config/neural_theme.dart';

/// Alias estático con los tokens de color originales.
/// Los valores DEBEN coincidir exactamente con [NeuralThemeData.defaults].
/// En código nuevo, usa [NeuralTheme.of(context)].
class NeuralDesignSystem {
  NeuralDesignSystem._();

  static const Color background     = Color(0xFF131314);
  static const Color surfaceCard    = Color(0xFF1E1F20);
  static const Color textPrimary    = Color(0xFFFFFFFF);
  static const Color textPrimaryAlt = Color(0xFFE3E3E3);
  static const Color textSecondary  = Color(0xFFC4C7C5);
  static const Color textMuted      = Color(0xFF94A3B8);
  static const Color blueGoogle     = Color(0xFF4285F4);
  static const Color purple         = Color(0xFF9B72CB);
  static const Color pink           = Color(0xFFD96570);
  static const Color cyan           = Color(0xFF22D3EE);

  static const LinearGradient neuralGradient = LinearGradient(
    colors: [Color(0xFF4285F4), Color(0xFF9B72CB), Color(0xFFD96570), Color(0xFF22D3EE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

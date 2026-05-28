import 'package:flutter/material.dart';

/// Define los colores y constantes globales de la marca y tema "Neural Expressive" 
/// inspirado fuertemente en el estilo visual de Google Gemini 2026.
class NeuralDesignSystem {
  // Paleta de Colores (Dark Mode Místico)
  static const Color background = Color(0xFF131314);
  static const Color surfaceCard = Color(0xFF1E1F20);
  
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textPrimaryAlt = Color(0xFFE3E3E3);
  static const Color textSecondary = Color(0xFFC4C7C5);
  static const Color textMuted = Color(0xFF94A3B8);

  // Gradiente "Neural" (Core Brand)
  static const Color blueGoogle = Color(0xFF4285F4);
  static const Color purple = Color(0xFF9B72CB);
  static const Color pink = Color(0xFFD96570);
  static const Color cyan = Color(0xFF22D3EE);

  static const LinearGradient neuralGradient = LinearGradient(
    colors: [blueGoogle, purple, pink, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Definición de ThemeData Global
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      fontFamily: 'Inter', // Utiliza Inter por defecto como se requiere
      colorScheme: const ColorScheme.dark(
        primary: blueGoogle,
        secondary: purple,
        surface: surfaceCard,
        error: pink,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.02,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.02,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimaryAlt,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          height: 1.6,
          color: textPrimaryAlt,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          height: 1.6,
          color: textSecondary,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textPrimary),
      ),
    );
  }
}

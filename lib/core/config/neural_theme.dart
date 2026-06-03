import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  NeuralThemeData — ThemeExtension inyectable
//  Uso: Theme.of(context).extension<NeuralThemeData>()!
// ─────────────────────────────────────────────────────────────────────────────
class NeuralThemeData extends ThemeExtension<NeuralThemeData> {
  const NeuralThemeData({
    required this.background,
    required this.surfaceCard,
    required this.surfaceElevated,
    required this.textPrimary,
    required this.textPrimaryAlt,
    required this.textSecondary,
    required this.textMuted,
    required this.blueGoogle,
    required this.purple,
    required this.pink,
    required this.cyan,
    required this.successGreen,
    required this.warningAmber,
    required this.neuralGradient,
    required this.cardOpacityMin,
    required this.cardOpacityMax,
    required this.borderSubtle,
    required this.borderHover,
    required this.blobBlueOpacity,
    required this.blobPurpleOpacity,
    required this.blobPinkOpacity,
  });

  // ── Fondos ────────────────────────────────────────────────────────────────
  final Color background;
  final Color surfaceCard;
  final Color surfaceElevated;

  // ── Tipografía ────────────────────────────────────────────────────────────
  final Color textPrimary;
  final Color textPrimaryAlt;
  final Color textSecondary;
  final Color textMuted;

  // ── Marca Neural ──────────────────────────────────────────────────────────
  final Color blueGoogle;
  final Color purple;
  final Color pink;
  final Color cyan;
  final Color successGreen;
  final Color warningAmber;

  // ── Gradiente Iridiscente ─────────────────────────────────────────────────
  final LinearGradient neuralGradient;

  // ── Glassmorphism — opacidades de superficie (40%–60%) ───────────────────
  final double cardOpacityMin; // 0.40
  final double cardOpacityMax; // 0.60

  // ── Bordes de tarjeta ─────────────────────────────────────────────────────
  /// Borde sutil en reposo: rgba(255,255,255,0.10)
  final Color borderSubtle;

  /// Borde iluminado en hover: rgba(255,255,255,0.22)
  final Color borderHover;

  // ── Blobs del fondo neural ────────────────────────────────────────────────
  final double blobBlueOpacity;
  final double blobPurpleOpacity;
  final double blobPinkOpacity;

  // ── Instancia por defecto (Dark Mode Místico) ─────────────────────────────
  static const NeuralThemeData defaults = NeuralThemeData(
    background: Color(0xFF131314),
    surfaceCard: Color(0xFF1E1F20),
    surfaceElevated: Color(0xFF252628),
    textPrimary: Color(0xFFFFFFFF),
    textPrimaryAlt: Color(0xFFE3E3E3),
    textSecondary: Color(0xFFC4C7C5),
    textMuted: Color(0xFF94A3B8),
    blueGoogle: Color(0xFF4285F4),
    purple: Color(0xFF9B72CB),
    pink: Color(0xFFD96570),
    cyan: Color(0xFF22D3EE),
    successGreen: Color(0xFF4ADE80),
    warningAmber: Color(0xFFFBBF24),
    neuralGradient: LinearGradient(
      colors: [Color(0xFF4285F4), Color(0xFF9B72CB), Color(0xFFD96570), Color(0xFF22D3EE)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    cardOpacityMin: 0.40,
    cardOpacityMax: 0.60,
    borderSubtle: Color(0x1AFFFFFF),   // rgba(255,255,255,0.10)
    borderHover: Color(0x38FFFFFF),    // rgba(255,255,255,0.22)
    blobBlueOpacity: 0.18,
    blobPurpleOpacity: 0.15,
    blobPinkOpacity: 0.12,
  );

  // ── ThemeExtension overrides ──────────────────────────────────────────────
  @override
  NeuralThemeData copyWith({
    Color? background,
    Color? surfaceCard,
    Color? surfaceElevated,
    Color? textPrimary,
    Color? textPrimaryAlt,
    Color? textSecondary,
    Color? textMuted,
    Color? blueGoogle,
    Color? purple,
    Color? pink,
    Color? cyan,
    Color? successGreen,
    Color? warningAmber,
    LinearGradient? neuralGradient,
    double? cardOpacityMin,
    double? cardOpacityMax,
    Color? borderSubtle,
    Color? borderHover,
    double? blobBlueOpacity,
    double? blobPurpleOpacity,
    double? blobPinkOpacity,
  }) {
    return NeuralThemeData(
      background: background ?? this.background,
      surfaceCard: surfaceCard ?? this.surfaceCard,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      textPrimary: textPrimary ?? this.textPrimary,
      textPrimaryAlt: textPrimaryAlt ?? this.textPrimaryAlt,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      blueGoogle: blueGoogle ?? this.blueGoogle,
      purple: purple ?? this.purple,
      pink: pink ?? this.pink,
      cyan: cyan ?? this.cyan,
      successGreen: successGreen ?? this.successGreen,
      warningAmber: warningAmber ?? this.warningAmber,
      neuralGradient: neuralGradient ?? this.neuralGradient,
      cardOpacityMin: cardOpacityMin ?? this.cardOpacityMin,
      cardOpacityMax: cardOpacityMax ?? this.cardOpacityMax,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderHover: borderHover ?? this.borderHover,
      blobBlueOpacity: blobBlueOpacity ?? this.blobBlueOpacity,
      blobPurpleOpacity: blobPurpleOpacity ?? this.blobPurpleOpacity,
      blobPinkOpacity: blobPinkOpacity ?? this.blobPinkOpacity,
    );
  }

  @override
  NeuralThemeData lerp(NeuralThemeData other, double t) {
    return NeuralThemeData(
      background: Color.lerp(background, other.background, t)!,
      surfaceCard: Color.lerp(surfaceCard, other.surfaceCard, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textPrimaryAlt: Color.lerp(textPrimaryAlt, other.textPrimaryAlt, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      blueGoogle: Color.lerp(blueGoogle, other.blueGoogle, t)!,
      purple: Color.lerp(purple, other.purple, t)!,
      pink: Color.lerp(pink, other.pink, t)!,
      cyan: Color.lerp(cyan, other.cyan, t)!,
      successGreen: Color.lerp(successGreen, other.successGreen, t)!,
      warningAmber: Color.lerp(warningAmber, other.warningAmber, t)!,
      neuralGradient: LinearGradient.lerp(neuralGradient, other.neuralGradient, t)!,
      cardOpacityMin: ui.lerpDouble(cardOpacityMin, other.cardOpacityMin, t)!,
      cardOpacityMax: ui.lerpDouble(cardOpacityMax, other.cardOpacityMax, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      borderHover: Color.lerp(borderHover, other.borderHover, t)!,
      blobBlueOpacity: ui.lerpDouble(blobBlueOpacity, other.blobBlueOpacity, t)!,
      blobPurpleOpacity: ui.lerpDouble(blobPurpleOpacity, other.blobPurpleOpacity, t)!,
      blobPinkOpacity: ui.lerpDouble(blobPinkOpacity, other.blobPinkOpacity, t)!,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  NeuralTheme — acceso de contexto conveniente
//  Uso: NeuralTheme.of(context).blueGoogle
// ─────────────────────────────────────────────────────────────────────────────
class NeuralTheme {
  NeuralTheme._();

  /// Recupera la extensión inyectada. Nunca retorna null porque
  /// [NeuralThemeData.defaults] siempre está registrado en [buildThemeData].
  static NeuralThemeData of(BuildContext context) {
    return Theme.of(context).extension<NeuralThemeData>() ??
        NeuralThemeData.defaults;
  }

  /// Construye el [ThemeData] completo con la extensión neural inyectada.
  /// Llama esto en [MaterialApp.theme].
  static ThemeData buildThemeData({
    NeuralThemeData neural = NeuralThemeData.defaults,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: neural.background,
      fontFamily: 'Inter',
      colorScheme: ColorScheme.dark(
        primary: neural.blueGoogle,
        secondary: neural.purple,
        surface: neural.surfaceCard,
        error: neural.pink,
      ),
      extensions: [neural],
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.02,
          color: neural.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.02,
          color: neural.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: neural.textPrimaryAlt,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          height: 1.6,
          color: neural.textPrimaryAlt,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          height: 1.6,
          color: neural.textSecondary,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: neural.textPrimary),
        titleTextStyle: TextStyle(
          fontFamily: 'Outfit',
          color: neural.textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}

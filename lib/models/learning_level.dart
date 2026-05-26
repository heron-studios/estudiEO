import 'package:flutter/material.dart';

/// Representa los cuatro niveles de dificultad del Modo Aprendizaje Guiado.
enum Dificultad {
  facil,
  medio,
  dificil,
  extremo;

  String get displayName {
    switch (this) {
      case Dificultad.facil:
        return 'Fácil';
      case Dificultad.medio:
        return 'Medio';
      case Dificultad.dificil:
        return 'Difícil';
      case Dificultad.extremo:
        return 'Extremo';
    }
  }

  String get emoji {
    switch (this) {
      case Dificultad.facil:
        return '🟢';
      case Dificultad.medio:
        return '🟡';
      case Dificultad.dificil:
        return '🟠';
      case Dificultad.extremo:
        return '🔴';
    }
  }

  Color get color {
    switch (this) {
      case Dificultad.facil:
        return const Color(0xFF22C55E);
      case Dificultad.medio:
        return const Color(0xFFFBBF24);
      case Dificultad.dificil:
        return const Color(0xFFF97316);
      case Dificultad.extremo:
        return const Color(0xFFEF4444);
    }
  }

  Color get bgColor {
    switch (this) {
      case Dificultad.facil:
        return const Color(0xFF052E16);
      case Dificultad.medio:
        return const Color(0xFF451A03);
      case Dificultad.dificil:
        return const Color(0xFF431407);
      case Dificultad.extremo:
        return const Color(0xFF450A0A);
    }
  }

  /// Nivel siguiente (null si ya es el último).
  Dificultad? get next {
    switch (this) {
      case Dificultad.facil:
        return Dificultad.medio;
      case Dificultad.medio:
        return Dificultad.dificil;
      case Dificultad.dificil:
        return Dificultad.extremo;
      case Dificultad.extremo:
        return null;
    }
  }

  int get index2 {
    switch (this) {
      case Dificultad.facil:
        return 0;
      case Dificultad.medio:
        return 1;
      case Dificultad.dificil:
        return 2;
      case Dificultad.extremo:
        return 3;
    }
  }

  static Dificultad fromIndex(int index) {
    switch (index) {
      case 0:
        return Dificultad.facil;
      case 1:
        return Dificultad.medio;
      case 2:
        return Dificultad.dificil;
      case 3:
        return Dificultad.extremo;
      default:
        return Dificultad.facil;
    }
  }

  static Dificultad fromString(String s) {
    switch (s) {
      case 'facil':
        return Dificultad.facil;
      case 'medio':
        return Dificultad.medio;
      case 'dificil':
        return Dificultad.dificil;
      case 'extremo':
        return Dificultad.extremo;
      default:
        return Dificultad.facil;
    }
  }

  String get key => name;
}

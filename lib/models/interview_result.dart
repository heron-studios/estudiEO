import 'package:flutter/material.dart' show Color;

/// Resultado de una entrevista simulada con el Coronel IA.
class InterviewResult {
  final DateTime date;
  final double score; // Nota del 0 al 20
  final String evaluation; // Texto final del Coronel
  final int messagesCount; // Número de preguntas respondidas

  const InterviewResult({
    required this.date,
    required this.score,
    required this.evaluation,
    required this.messagesCount,
  });

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'score': score,
        'evaluation': evaluation,
        'messagesCount': messagesCount,
      };

  factory InterviewResult.fromJson(Map<String, dynamic> json) {
    return InterviewResult(
      date: DateTime.tryParse(json['date']?.toString() ?? '') ?? DateTime.now(),
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      evaluation: json['evaluation']?.toString() ?? '',
      messagesCount: (json['messagesCount'] as num?)?.toInt() ?? 0,
    );
  }

  /// Extrae la nota numérica del texto de evaluación final del Coronel.
  /// Busca patrones como "14/20", "nota: 12", etc.
  static double? parseScoreFromText(String text) {
    // Busca "XX/20"
    final regexSlash = RegExp(r'(\d{1,2})\s*/\s*20', caseSensitive: false);
    final matchSlash = regexSlash.firstMatch(text);
    if (matchSlash != null) {
      final val = double.tryParse(matchSlash.group(1)!);
      if (val != null && val >= 0 && val <= 20) return val;
    }
    // Busca "nota: XX" o "nota final: XX"
    final regexNota = RegExp(r'nota[^:]*:\s*(\d{1,2})', caseSensitive: false);
    final matchNota = regexNota.firstMatch(text);
    if (matchNota != null) {
      final val = double.tryParse(matchNota.group(1)!);
      if (val != null && val >= 0 && val <= 20) return val;
    }
    return null;
  }

  String get formattedDate {
    final d = date;
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }

  String get scoreLabel {
    if (score >= 17) return 'Excelente';
    if (score >= 14) return 'Aprobado';
    if (score >= 11) return 'Regular';
    return 'Desaprobado';
  }

  Color get scoreColor {
    if (score >= 17) return const Color(0xFF10B981);
    if (score >= 14) return const Color(0xFF3B82F6);
    if (score >= 11) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }
}


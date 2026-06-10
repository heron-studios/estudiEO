import 'dart:math';

class PsicoQuestion {
  final int id;
  final String text;
  final Map<String, String> options;
  final Map<String, int> puntosOpciones;
  final String hint;
  final String dimension;
  final String subDimension;
  final bool esEscalaMentira;
  final String contextoCorrecto;
  final String contextoIncorrecto;

  PsicoQuestion({
    required this.id,
    required this.text,
    required this.options,
    required this.puntosOpciones,
    this.hint = '',
    this.dimension = 'General',
    this.subDimension = '',
    this.esEscalaMentira = false,
    this.contextoCorrecto = '',
    this.contextoIncorrecto = '',
  });

  factory PsicoQuestion.fromJson(Map<String, dynamic> json) {
    final rawOptions = Map<String, String>.from(
      (json['opciones'] ?? json['options'] ?? {}).map(
        (key, value) => MapEntry(key.toString(), _clean(value.toString())),
      ),
    );
    
    final int qId = (json['pregunta_id'] ?? json['id'] ?? 0 as num).toInt();
    
    // Barajar opciones aleatoriamente pero de forma consistente segÃºn el ID
    final List<MapEntry<String, String>> entriesList = rawOptions.entries.toList();
    entriesList.shuffle(Random(qId));
    final options = Map.fromEntries(entriesList);

    final esReversa = json['es_reversa'] ?? false;
    final Map<String, dynamic> rawPuntos =
        json['puntos_opciones'] ?? json['puntosOpciones'] ?? {};
        
    final puntosMap = rawPuntos.isNotEmpty
        ? rawPuntos.map((k, v) => MapEntry(k, (v as num).toInt()))
        : _inferOptionScores(rawOptions, esReversa: esReversa);

    return PsicoQuestion(
      id: qId,
      text: _clean(json['texto'] ?? json['text'] ?? ''),
      options: options,
      puntosOpciones: puntosMap,
      hint: _clean(json['pista'] ?? json['hint'] ?? ''),
      dimension: _clean(json['dimension'] ?? 'General'),
      subDimension: _clean(json['sub_dimension'] ?? ''),
      esEscalaMentira: json['es_escala_mentira'] ?? false,
      contextoCorrecto: _clean(json['contexto_correcto'] ?? json['contextoCorrecto'] ?? ''),
      contextoIncorrecto: _clean(json['contexto_incorrecto'] ?? json['contextoIncorrecto'] ?? ''),
    );
  }

  String get displayDimension {
    if (subDimension.isEmpty) return dimension;
    return '$dimension · $subDimension';
  }

  static String _clean(Object? value) {
    return value?.toString().trim() ?? '';
  }

  static Map<String, int> _inferOptionScores(
    Map<String, String> options, {
    required bool esReversa,
  }) {
    if (options.isEmpty) return {};

    final scoredEntries = options.entries.map((entry) {
      final value = entry.value.toLowerCase();
      final intensity = _optionIntensity(value);
      final score = esReversa ? 10 - intensity : intensity;
      return MapEntry(entry.key, score);
    }).toList();

    if (scoredEntries.every(
      (entry) => entry.value == scoredEntries.first.value,
    )) {
      final sortedKeys = options.keys.toList()..sort();
      final fallback = <String, int>{};
      for (var i = 0; i < sortedKeys.length; i++) {
        final ratio = sortedKeys.length == 1
            ? 1.0
            : i / (sortedKeys.length - 1);
        final score = (ratio * 10).round();
        fallback[sortedKeys[i]] = esReversa ? 10 - score : score;
      }
      return fallback;
    }

    return Map.fromEntries(scoredEntries);
  }

  static int _optionIntensity(String value) {
    if (value.contains('nunca') ||
        value.contains('falso') ||
        value == 'no' ||
        value.contains('casi no') ||
        value.contains('desacuerdo') ||
        value.contains('nada') ||
        value.contains('peor')) {
      return 0;
    }
    if (value.contains('duda') ||
        value.contains('a veces') ||
        value.contains('ni verdadero') ||
        value.contains('regular') ||
        value.contains('depende') ||
        value.contains('neutral') ||
        value.contains('ni de acuerdo') ||
        value.contains('ocasionalmente') ||
        value.contains('algunas veces')) {
      return 5;
    }
    if (value.contains('siempre') ||
        value.contains('verdadero') ||
        value.contains('cierto') ||
        value == 'si' ||
        value == 'sí' ||
        value.contains('acuerdo') ||
        value.contains('totalmente') ||
        value.contains('mucho') ||
        value.contains('mejor')) {
      return 10;
    }
    return 5;
  }

  // La respuesta "correcta" es la de mayor puntaje
  String get correctAnswer {
    if (puntosOpciones.isEmpty) return 'A';
    final entries = puntosOpciones.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries.first.key;
  }

  int get puntajeMaximo {
    if (puntosOpciones.isEmpty) return 10;
    int max = 0;
    for (final score in puntosOpciones.values) {
      if (score > max) max = score;
    }
    return max;
  }
}

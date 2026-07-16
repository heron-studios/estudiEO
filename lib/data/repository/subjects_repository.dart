
import 'package:learn/data/library/matematicas/matematicas_subject.dart';
import 'package:learn/data/library/matematicas/matematicas_questions.dart';
import 'package:learn/data/library/matematicas/matematicas_topics.dart';
import 'package:learn/data/library/comunicacion/comunicacion_subject.dart';
import 'package:learn/data/library/comunicacion/comunicacion_questions.dart';
import 'package:learn/data/library/comunicacion/comunicacion_topics.dart';
import 'package:learn/data/library/ciencias_sociales/ciencias_sociales_subject.dart';
import 'package:learn/data/library/ciencias_sociales/ciencias_sociales_questions.dart';
import 'package:learn/data/library/ciencias_sociales/ciencias_sociales_topics.dart';
import 'package:learn/data/library/cta/cta_subject.dart';
import 'package:learn/data/library/cta/cta_questions.dart';
import 'package:learn/data/library/cta/cta_topics.dart';
import 'package:learn/data/library/pfrh/pfrh_subject.dart';
import 'package:learn/data/library/pfrh/pfrh_questions.dart';
import 'package:learn/data/library/pfrh/pfrh_topics.dart';
import 'package:learn/data/library/rv/rv_subject.dart';
import 'package:learn/data/library/rv/rv_questions.dart';
import 'package:learn/data/library/rv/rv_topics.dart';
import 'package:learn/data/library/rm/rm_subject.dart';
import 'package:learn/data/library/rm/rm_questions.dart';
import 'package:learn/data/library/rm/rm_topics.dart';
import 'package:learn/models/question.dart';
import 'package:learn/models/subject.dart';
import 'package:learn/models/topic.dart';
import 'package:learn/models/learning_level.dart';

class SubjectsRepository {

  static final Map<String, Subject> _subjects = {
    'matematicas': matematicasSubject,
    'comunicacion': comunicacionSubject,
    'ciencias-sociales': cienciasSocialesSubject,
    'cta': ctaSubject,
    'pfrh': pfrhSubject,
    'rv': razonamientoVerbalSubject,
    'rm': razonamientoMatematicoSubject,
  };

  static final Map<String, List<Question>> _questionsBySubject = {
    'matematicas': matematicasQuestions,
    'comunicacion': comunicacionQuestions,
    'ciencias-sociales': cienciasSocialesQuestions,
    'cta': ctaQuestions,
    'pfrh': pfrhQuestions,
    'rv': razonamientoVerbalQuestions,
    'rm': razonamientoMatematicoQuestions,
  };

  static final Map<String, Map<String, Topic>> _topicsBySubject = {
    'matematicas': matematicasTopics,
    'comunicacion': comunicacionTopics,
    'ciencias-sociales': cienciasSocialesTopics,
    'cta': ctaTopics,
    'pfrh': pfrhTopics,
    'rv': razonamientoVerbalTopics,
    'rm': razonamientoMatematicoTopics,
  };

  static Map<String, Question>? _questionByIdCache;
  static Map<String, List<Question>>? _questionsByTopicCache;

  static void _initIndexes() {
    if (_questionByIdCache != null && _questionsByTopicCache != null) return;
    
    _questionByIdCache = {};
    _questionsByTopicCache = {};
    
    for (final questions in _questionsBySubject.values) {
      for (final q in questions) {
        _questionByIdCache![q.id] = q;
        _questionsByTopicCache![q.topicId] ??= [];
        _questionsByTopicCache![q.topicId]!.add(q);
      }
    }
  }

  /// Obtiene todas las asignaturas
  static List<Subject> getAllSubjects() {
    return _subjects.values.toList();
  }

  /// Obtiene una asignatura por ID
  static Subject? getSubject(String subjectId) {
    return _subjects[subjectId];
  }

  /// Obtiene todas las preguntas de una asignatura
  static List<Question> getQuestionsBySubject(String subjectId) {
    final cached = _questionsBySubject[subjectId] ?? [];
    return List<Question>.from(cached);
  }

  /// Obtiene preguntas de un tópico específico
  static List<Question> getQuestionsByTopic(String topicId, {bool isPremium = false}) {
    _initIndexes();
    final cached = _questionsByTopicCache![topicId] ?? [];
    return List<Question>.from(cached);
  }

  static Question? getQuestion(String questionId, {bool isPremium = false}) {
    _initIndexes();
    return _questionByIdCache![questionId];
  }

  /// Obtiene todos los tópicos de una asignatura
  /// Solo devuelve los topics cuyo ID está en el topicIds del subject
  static List<Topic> getTopicsBySubject(String subjectId) {
    final subject = _subjects[subjectId];
    final topicsMap = _topicsBySubject[subjectId];
    if (subject == null || topicsMap == null) return [];
    // Filtrar por topicIds del subject para ocultar topics sin contenido
    return subject.topicIds
        .where((id) => topicsMap.containsKey(id))
        .map((id) => topicsMap[id]!)
        .toList();
  }

  /// Obtiene un tópico específico
  static Topic? getTopic(String topicId) {
    for (final topics in _topicsBySubject.values) {
      if (topics.containsKey(topicId)) {
        return topics[topicId];
      }
    }
    return null;
  }

  /// Obtiene preguntas aleatorias de un tópico
  static List<Question> getRandomQuestionsByTopic(String topicId, int count, {bool isPremium = false}) {
    final questions = getQuestionsByTopic(topicId, isPremium: isPremium);
    if (questions.isEmpty) return [];

    questions.shuffle();
    return questions.take(count).toList();
  }

  /// Obtiene todas las preguntas de un tópico barajadas
  static List<Question> getAllQuestionsByTopicShuffled(String topicId, {bool isPremium = false}) {
    final questions = getQuestionsByTopic(topicId, isPremium: isPremium);
    questions.shuffle();
    return questions;
  }

  /// Obtiene [count] preguntas para el nivel de dificultad dado.
  ///
  /// Estrategia Opción A: el pool total del topic se divide en 4 cuartos iguales
  /// según el nivel (facil=0, medio=1, dificil=2, extremo=3).
  /// Si hay menos de [count] en ese cuarto, se reciclan para completar exactamente [count].
  static List<Question> getQuestionsByTopicAndLevel(
    String topicId,
    Dificultad nivel, {
    int count = 10,
    bool isPremium = false,
  }) {
    _initIndexes();
    final allQuestions = List<Question>.from(_questionsByTopicCache![topicId] ?? []);

    if (allQuestions.isEmpty) return [];

    final total = allQuestions.length;
    final levelIndex = nivel.index2;
    final chunkSize = (total / 4).ceil();

    final start = (levelIndex * chunkSize).clamp(0, total - 1);
    final end = ((levelIndex + 1) * chunkSize).clamp(0, total);

    List<Question> chunk = allQuestions.sublist(start, end);
    if (chunk.isEmpty) chunk = List<Question>.from(allQuestions);

    if (chunk.length >= count) {
      chunk.shuffle();
      return chunk.take(count).toList();
    }

    // Completar con reciclo sin repetición inmediata
    final result = <Question>[];
    final source = List<Question>.from(chunk);
    while (result.length < count) {
      source.shuffle();
      for (final q in source) {
        if (result.length >= count) break;
        result.add(q);
      }
    }
    return result;
  }

  /// Obtiene la teoría para un tópico y nivel de dificultad dado.
  static String? getTheoryByTopicAndLevel(String topicId, Dificultad nivel) {
    final topic = getTopic(topicId);
    if (topic != null && topic.theoryByLevel != null) {
      final map = topic.theoryByLevel!;

      // Clave en inglés (CS, Comunicación): 'easy','medium','hard','extreme'
      final String englishKey;
      switch (nivel) {
        case Dificultad.facil:   englishKey = 'easy';    break;
        case Dificultad.medio:   englishKey = 'medium';  break;
        case Dificultad.dificil: englishKey = 'hard';    break;
        case Dificultad.extremo: englishKey = 'extreme'; break;
      }
      if (map.containsKey(englishKey)) return map[englishKey];

      // Clave enum directo (CTA, PFRH)
      if (map.containsKey(nivel)) return map[nivel];

      // Clave nombre del enum: 'facil','medio','dificil','extremo'
      if (map.containsKey(nivel.name)) return map[nivel.name];

      // Último recurso: primer valor disponible
      if (map.isNotEmpty) return map.values.first;
    }

    return null;
  }

  /// Obtiene datos de una asignatura completa
  static Map<String, dynamic> getSubjectData(String subjectId, {bool isPremium = false}) {
    return {
      'subject': getSubject(subjectId),
      'topics': getTopicsBySubject(subjectId),
      'questions': getQuestionsBySubject(subjectId),
    };
  }

  static List<Question> generateExamQuestions({bool isPremium = false}) {
    final Map<String, int> quotas = {
      'matematicas': 15,
      'comunicacion': 15,
      'ciencias-sociales': 10,
      'cta': 15,
      'pfrh': 15,
      'rm': 15,
      'rv': 15,
    };

    final List<Question> exam = [];

    quotas.forEach((subjectId, count) {
      final subjectQuestions = List<Question>.from(getQuestionsBySubject(subjectId));
      if (subjectQuestions.isEmpty) return; // Fail safe
      
      subjectQuestions.shuffle();
      if (subjectQuestions.length >= count) {
        exam.addAll(subjectQuestions.take(count));
      } else {
        // Rellenar repitiendo si no hay suficientes
        exam.addAll(subjectQuestions);
        int deficit = count - subjectQuestions.length;
        while (deficit > 0) {
          subjectQuestions.shuffle();
          final toAdd = subjectQuestions.take(deficit).toList();
          exam.addAll(toAdd);
          deficit -= toAdd.length;
        }
      }
    });

    exam.shuffle(); // Mezclar todas las materias
    return exam;
  }
}

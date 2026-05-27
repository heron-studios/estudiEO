import 'package:learn/config/app_config.dart';
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
import 'package:learn/data/library/cta/materia_energia_theory.dart';
import 'package:learn/data/library/cta/sistema_solar_theory.dart';
import 'package:learn/data/library/cta/tabla_periodica_theory.dart';
import 'package:learn/data/library/cta/vegetales_fotosintesis_theory.dart';
import 'package:learn/data/library/cta/fenomenos_cambioclimatico_theory.dart';
import 'package:learn/data/library/pfrh/pfrh_subject.dart';
import 'package:learn/data/library/pfrh/pfrh_questions.dart';
import 'package:learn/data/library/pfrh/pfrh_topics.dart';
import 'package:learn/data/library/pfrh/persona_familia_theory.dart';
import 'package:learn/data/library/pfrh/derechos_humanos_theory.dart';
import 'package:learn/data/library/pfrh/identidad_normas_theory.dart';
import 'package:learn/data/library/pfrh/autoestima_autocuidado_theory.dart';
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
  static List<Question> getQuestionsByTopic(String topicId) {
    _initIndexes();
    final cached = _questionsByTopicCache![topicId] ?? [];
    List<Question> filtered = List<Question>.from(cached);

    if (AppConfig.isDemoMode) {
      // En modo demo, solo estos temas tienen preguntas, y están limitadas para sumar 10 exactas.
      final Map<String, int> demoLimits = {
        'mat_1': 2,
        'com_1': 2,
        'cs_1': 2,
        'cta_1': 1,
        'pfrh_1': 1,
        'rv_1': 1,
        'rm_1': 1,
      };

      if (demoLimits.containsKey(topicId)) {
        return filtered.take(demoLimits[topicId]!).toList();
      } else {
        return []; // Tópico bloqueado/vacío en demo
      }
    }

    return filtered;
  }

  /// Obtiene una pregunta específica
  static Question? getQuestion(String questionId) {
    _initIndexes();
    final q = _questionByIdCache![questionId];
    if (q == null) return null;

    if (AppConfig.isDemoMode) {
       final topicQuestions = getQuestionsByTopic(q.topicId);
       if (topicQuestions.any((tq) => tq.id == questionId)) {
         return q;
       }
       return null;
    }
    return q;
  }

  /// Obtiene todos los tópicos de una asignatura
  static List<Topic> getTopicsBySubject(String subjectId) {
    return _topicsBySubject[subjectId]?.values.toList() ?? [];
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
  static List<Question> getRandomQuestionsByTopic(String topicId, int count) {
    final questions = getQuestionsByTopic(topicId);
    if (questions.isEmpty) return [];

    questions.shuffle();
    return questions.take(count).toList();
  }

  /// Obtiene todas las preguntas de un tópico barajadas
  static List<Question> getAllQuestionsByTopicShuffled(String topicId) {
    final questions = getQuestionsByTopic(topicId);
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
  }) {
    _initIndexes();
    // Usar pool completo sin filtro demo para el modo guiado
    final allQuestions = AppConfig.isDemoMode
        ? getQuestionsByTopic(topicId)
        : List<Question>.from(
            _questionsByTopicCache![topicId] ?? [],
          );

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
    // Primero, intentar buscar en los temas cargados
    final topic = getTopic(topicId);
    if (topic != null && topic.theoryByLevel != null) {
      // 1. Intentar con la clave de tipo Dificultad directamente (como en cta y pfrh)
      if (topic.theoryByLevel!.containsKey(nivel)) {
        return topic.theoryByLevel![nivel];
      }

      // 2. Intentar con claves en inglés 'easy', 'medium', 'hard', 'extreme' (como en reglas ortográficas y oración gramatical)
      final String englishKey;
      switch (nivel) {
        case Dificultad.facil:
          englishKey = 'easy';
          break;
        case Dificultad.medio:
          englishKey = 'medium';
          break;
        case Dificultad.dificil:
          englishKey = 'hard';
          break;
        case Dificultad.extremo:
          englishKey = 'extreme';
          break;
      }
      if (topic.theoryByLevel!.containsKey(englishKey)) {
        return topic.theoryByLevel![englishKey];
      }

      // 3. Intentar con el nombre del enum ('facil', 'medio', 'dificil', 'extremo')
      if (topic.theoryByLevel!.containsKey(nivel.name)) {
        return topic.theoryByLevel![nivel.name];
      }
    }

    if (topicId == 'cta_materia_energia') {
      return materiaEnergiaTheory[nivel];
    }
    if (topicId == 'cta_sistema_solar') {
      return sistemaSolarTheory[nivel];
    }
    if (topicId == 'cta_tabla_periodica') {
      return tablaPeriodicaTheory[nivel];
    }
    if (topicId == 'cta_vegetales_fotosintesis') {
      return vegetalesFotosintesisTheory[nivel];
    }
    if (topicId == 'cta_fenomenos_cambioclimatico') {
      return fenomenosCambioclimaticoTheory[nivel];
    }
    if (topicId == 'pfrh_persona_familia') {
      return personaFamiliaTheory[nivel];
    }
    if (topicId == 'pfrh_derechos_humanos') {
      return derechosHumanosTheory[nivel];
    }
    if (topicId == 'pfrh_identidad_normas') {
      return identidadNormasTheory[nivel];
    }
    if (topicId == 'pfrh_autoestima_autocuidado') {
      return autoestimaAutocuidadoTheory[nivel];
    }
    // Para otros tópicos aún no implementados
    return null;
  }

  /// Obtiene datos de una asignatura completa
  static Map<String, dynamic> getSubjectData(String subjectId) {
    return {
      'subject': getSubject(subjectId),
      'topics': getTopicsBySubject(subjectId),
      'questions': AppConfig.isDemoMode 
          ? getTopicsBySubject(subjectId).expand((t) => getQuestionsByTopic(t.id)).toList()
          : getQuestionsBySubject(subjectId),
    };
  }

  /// Genera un examen simulacro de 100 preguntas exactas (o 10 en demo)
  static List<Question> generateExamQuestions() {
    if (AppConfig.isDemoMode) {
      // En modo demo el simulacro consta exactamente de las 10 preguntas desbloqueadas
      final List<String> demoTopics = ['mat_1', 'com_1', 'cs_1', 'cta_1', 'pfrh_1', 'rv_1', 'rm_1'];
      final List<Question> demoExam = [];
      for (final topicId in demoTopics) {
        demoExam.addAll(getQuestionsByTopic(topicId));
      }
      demoExam.shuffle();
      return demoExam;
    }

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

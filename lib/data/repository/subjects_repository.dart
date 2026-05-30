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
  static List<Question> getQuestionsByTopic(String topicId, {bool isPremium = false}) {
    _initIndexes();
    final cached = _questionsByTopicCache![topicId] ?? [];
    List<Question> filtered = List<Question>.from(cached);

    if (AppConfig.isDemoMode && !isPremium) {
      // En modo demo, solo estos temas tienen preguntas, y están limitadas para sumar 10 exactas.
      final Map<String, int> demoLimits = {
        'mat_algebra': 2,
        'eo_pnp_reglas_ortograficas_ext_10q': 2,
        'cs_t1': 2,
        'cta_materia_energia': 1,
        'pfrh_persona_familia': 1,
        'eo_pnp_sinonimos_ext_10q': 1,
        'rm_sucesiones': 1,
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
  static Question? getQuestion(String questionId, {bool isPremium = false}) {
    _initIndexes();
    final q = _questionByIdCache![questionId];
    if (q == null) return null;

    if (AppConfig.isDemoMode && !isPremium) {
       final topicQuestions = getQuestionsByTopic(q.topicId, isPremium: isPremium);
       if (topicQuestions.any((tq) => tq.id == questionId)) {
         return q;
       }
       return null;
    }
    return q;
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
    // Usar pool completo sin filtro demo para el modo guiado
    final allQuestions = (AppConfig.isDemoMode && !isPremium)
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

    // Fallbacks hardcodeados para CTA y PFRH (por compatibilidad)
    if (topicId == 'cta_materia_energia')         return materiaEnergiaTheory[nivel];
    if (topicId == 'cta_sistema_solar')           return sistemaSolarTheory[nivel];
    if (topicId == 'cta_tabla_periodica')         return tablaPeriodicaTheory[nivel];
    if (topicId == 'cta_vegetales_fotosintesis')  return vegetalesFotosintesisTheory[nivel];
    if (topicId == 'cta_fenomenos_cambioclimatico') return fenomenosCambioclimaticoTheory[nivel];
    if (topicId == 'pfrh_persona_familia')        return personaFamiliaTheory[nivel];
    if (topicId == 'pfrh_derechos_humanos')       return derechosHumanosTheory[nivel];
    if (topicId == 'pfrh_identidad_normas')       return identidadNormasTheory[nivel];
    if (topicId == 'pfrh_autoestima_autocuidado') return autoestimaAutocuidadoTheory[nivel];

    return null;
  }

  /// Obtiene datos de una asignatura completa
  static Map<String, dynamic> getSubjectData(String subjectId, {bool isPremium = false}) {
    return {
      'subject': getSubject(subjectId),
      'topics': getTopicsBySubject(subjectId),
      'questions': (AppConfig.isDemoMode && !isPremium) 
          ? getTopicsBySubject(subjectId).expand((t) => getQuestionsByTopic(t.id, isPremium: isPremium)).toList()
          : getQuestionsBySubject(subjectId),
    };
  }

  /// Genera un examen simulacro de 100 preguntas exactas (o 10 en demo)
  static List<Question> generateExamQuestions({bool isPremium = false}) {
    if (AppConfig.isDemoMode && !isPremium) {
      // En modo demo el simulacro consta exactamente de las 10 preguntas desbloqueadas
      final List<String> demoTopics = ['mat_1', 'com_1', 'cs_1', 'cta_1', 'pfrh_1', 'rv_1', 'rm_1'];
      final List<Question> demoExam = [];
      for (final topicId in demoTopics) {
        demoExam.addAll(getQuestionsByTopic(topicId, isPremium: isPremium));
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

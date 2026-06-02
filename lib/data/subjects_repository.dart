import 'package:learn/config/app_config.dart';
import 'package:learn/data/subject_data_matematicas.dart';
import 'package:learn/data/subject_data_comunicacion.dart';
import 'package:learn/data/subject_data_sociales.dart';
import 'package:learn/data/subject_data_cta.dart';
import 'package:learn/data/subject_data_pfrh.dart';
import 'package:learn/data/subject_data_rv.dart';
import 'package:learn/data/subject_data_rm.dart';
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
    return _questionsBySubject[subjectId] ?? [];
  }

  /// Obtiene preguntas de un tópico específico
  static List<Question> getQuestionsByTopic(String topicId) {
    List<Question> filtered = [];
    for (final questions in _questionsBySubject.values) {
      filtered = questions.where((q) => q.topicId == topicId).toList();
      if (filtered.isNotEmpty) {
        break;
      }
    }

    if (AppConfig.isDemoMode) {
      // En modo demo generamos exactamente 10 preguntas
      final Map<String, int> demoLimits = {
        'mat_algebra': 2,
        'com_t1': 2,
        'cs_t1': 2,
        'cta_t1': 1,
        'pfrh_t1': 1,
        'rv_sinonimos': 1,
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
  static Question? getQuestion(String questionId) {
    for (final questions in _questionsBySubject.values) {
      try {
        final q = questions.firstWhere((q) => q.id == questionId);
        // Si estamos en demo, asegurarnos que pertenece a las 10 preguntas
        if (AppConfig.isDemoMode) {
           final topicQuestions = getQuestionsByTopic(q.topicId);
           if (topicQuestions.any((tq) => tq.id == questionId)) {
             return q;
           }
           return null;
        }
        return q;
      } catch (e) {
        // Continue searching in other subjects
      }
    }
    return null;
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
  /// Si hay menos de [count] en ese cuarto, se reciclan las del mismo cuarto
  /// para completar exactamente [count] preguntas sin repetición inmediata.
  static List<Question> getQuestionsByTopicAndLevel(
    String topicId,
    Dificultad nivel, {
    int count = 10,
  }) {
    // En demo solo se exponen las preguntas ya filtradas
    final allQuestions = AppConfig.isDemoMode
        ? getQuestionsByTopic(topicId)
        : _getRawQuestionsByTopic(topicId);

    if (allQuestions.isEmpty) return [];

    final total = allQuestions.length;
    final levelIndex = nivel.index2;
    final chunkSize = (total / 4).ceil();

    final start = (levelIndex * chunkSize).clamp(0, total - 1);
    final end = ((levelIndex + 1) * chunkSize).clamp(0, total);

    List<Question> chunk = allQuestions.sublist(start, end);

    if (chunk.isEmpty) chunk = List.from(allQuestions);

    // Reciclar para alcanzar exactamente [count] preguntas
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

  /// Obtiene preguntas crudas sin filtro de demo (uso interno para el modo guiado).
  static List<Question> _getRawQuestionsByTopic(String topicId) {
    for (final questions in _questionsBySubject.values) {
      final filtered = questions.where((q) => q.topicId == topicId).toList();
      if (filtered.isNotEmpty) return filtered;
    }
    return [];
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
      final List<String> demoTopics = ['mat_algebra', 'com_t1', 'cs_t1', 'cta_t1', 'pfrh_t1', 'rv_sinonimos', 'rm_sucesiones'];
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

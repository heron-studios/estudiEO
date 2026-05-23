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
    for (final questions in _questionsBySubject.values) {
      final filtered = questions.where((q) => q.topicId == topicId).toList();
      if (filtered.isNotEmpty) {
        return filtered;
      }
    }
    return [];
  }

  /// Obtiene una pregunta específica
  static Question? getQuestion(String questionId) {
    for (final questions in _questionsBySubject.values) {
      try {
        return questions.firstWhere((q) => q.id == questionId);
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

  /// Obtiene datos de una asignatura completa
  static Map<String, dynamic> getSubjectData(String subjectId) {
    return {
      'subject': getSubject(subjectId),
      'topics': getTopicsBySubject(subjectId),
      'questions': getQuestionsBySubject(subjectId),
    };
  }

  /// Genera un examen simulacro de 100 preguntas exactas
  static List<Question> generateExamQuestions() {
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

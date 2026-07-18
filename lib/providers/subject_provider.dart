import 'package:flutter/material.dart';
import 'package:learn/data/repository/subjects_repository.dart';
import 'package:learn/models/subject.dart';
import 'package:learn/models/topic.dart';
import 'package:learn/models/question.dart';
import 'package:learn/models/learning_level.dart';
import 'package:learn/core/services/local_storage_service.dart';

class SubjectProvider extends ChangeNotifier {
  final LocalStorageService _storage;
  late Subject? _currentSubject;
  late Topic? _currentTopic;
  late List<Subject> _allSubjects;
  List<Subject> _visibleSubjects = [];
  bool _isPremium = false;
  bool get isPremium => _isPremium;

  void setPremium(bool value) {
    if (_isPremium != value) {
      _isPremium = value;
      notifyListeners();
    }
  }

  SubjectProvider(this._storage) {
    _initSubjects();
  }

  void _initSubjects() {
    _allSubjects = SubjectsRepository.getAllSubjects()
        .where((s) => s.id != 'matematicas')
        .toList();

    _allSubjects.add(
      Subject(
        id: 'ai_custom_subject',
        name: 'Mis Flashcards',
        icon: 'psychology',
        color: '#9C27B0',
        topicIds: [],
      ),
    );

    _currentSubject = null;
    _currentTopic = null;
    updateVisibleSubjects();
  }

  List<Subject> get subjects => _visibleSubjects; // Retorna solo los visibles
  List<Subject> get allSubjects => _allSubjects;
  Subject? get currentSubject => _currentSubject;
  Topic? get currentTopic => _currentTopic;

  void updateVisibleSubjects() {
    final hiddenSubjectIds = _storage.loadHiddenSubjects();
    _visibleSubjects = _allSubjects
        .where((s) => !hiddenSubjectIds.contains(s.id))
        .toList();
    notifyListeners();
  }

  void selectSubject(String subjectId) {
    _currentSubject = getSubject(subjectId);
    _currentTopic = null;
    notifyListeners();
  }

  void selectTopic(String topicId) {
    _currentTopic = getTopic(topicId);
    notifyListeners();
  }

  List<Topic> getTopicsForCurrentSubject() {
    if (_currentSubject == null) return [];
    return getTopicsBySubject(_currentSubject!.id);
  }

  void clearSelection() {
    _currentSubject = null;
    _currentTopic = null;
    notifyListeners();
  }

  void reload() {
    _initSubjects();
  }

  // Repository Wrappers to completely decouple UI from static repository
  Subject? getSubject(String id) {
    if (id == 'ai_custom_subject') {
      return _allSubjects.where((s) => s.id == id).firstOrNull;
    }
    return SubjectsRepository.getSubject(id);
  }

  List<Topic> getTopicsBySubject(String subjectId) {
    if (subjectId == 'ai_custom_subject') {
      return _storage.loadCustomTopics();
    }
    return SubjectsRepository.getTopicsBySubject(subjectId);
  }

  Topic? getTopic(String id) {
    if (id.startsWith('ai_topic_')) {
      return _storage.loadCustomTopics().where((t) => t.id == id).firstOrNull;
    }
    return SubjectsRepository.getTopic(id);
  }

  List<Question> getQuestionsByTopic(String id) {
    if (id.startsWith('ai_topic_')) {
      return _storage
          .loadCustomQuestions()
          .where((q) => q.topicId == id)
          .toList();
    }
    return SubjectsRepository.getQuestionsByTopic(id, isPremium: _isPremium);
  }

  List<Question> generateExamQuestions() =>
      SubjectsRepository.generateExamQuestions(isPremium: _isPremium);

  List<Question> getAllQuestionsByTopicShuffled(String id) =>
      SubjectsRepository.getAllQuestionsByTopicShuffled(
        id,
        isPremium: _isPremium,
      );

  Question? getQuestion(String id) {
    if (id.startsWith('ai_gen_')) {
      return _storage.getCustomQuestion(id);
    }
    return SubjectsRepository.getQuestion(id, isPremium: _isPremium);
  }

  List<Question> getQuestionsByTopicAndLevel(
    String id,
    Dificultad nivel, {
    int count = 10,
  }) => SubjectsRepository.getQuestionsByTopicAndLevel(
    id,
    nivel,
    count: count,
    isPremium: _isPremium,
  );

  String? getTheoryByTopicAndLevel(String id, Dificultad nivel) =>
      SubjectsRepository.getTheoryByTopicAndLevel(id, nivel);
}

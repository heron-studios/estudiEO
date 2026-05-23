import 'package:flutter/material.dart';
import 'package:learn/data/subjects_repository.dart';
import 'package:learn/models/subject.dart';
import 'package:learn/models/topic.dart';

class SubjectProvider extends ChangeNotifier {
  late Subject? _currentSubject;
  late Topic? _currentTopic;
  late List<Subject> _allSubjects;
  List<Subject> _visibleSubjects = [];

  SubjectProvider() {
    _allSubjects = SubjectsRepository.getAllSubjects();
    _visibleSubjects = _allSubjects;
    _currentSubject = null;
    _currentTopic = null;
  }

  List<Subject> get subjects => _visibleSubjects; // Retorna solo los visibles
  Subject? get currentSubject => _currentSubject;
  Topic? get currentTopic => _currentTopic;

  void loadVisibleSubjects(List<String> hiddenSubjectIds) {
    _visibleSubjects = _allSubjects.where((s) => !hiddenSubjectIds.contains(s.id)).toList();
    notifyListeners();
  }

  void selectSubject(String subjectId) {
    _currentSubject = SubjectsRepository.getSubject(subjectId);
    _currentTopic = null;
    notifyListeners();
  }

  void selectTopic(String topicId) {
    _currentTopic = SubjectsRepository.getTopic(topicId);
    notifyListeners();
  }

  List<Topic> getTopicsForCurrentSubject() {
    if (_currentSubject == null) return [];
    return SubjectsRepository.getTopicsBySubject(_currentSubject!.id);
  }

  void clearSelection() {
    _currentSubject = null;
    _currentTopic = null;
    notifyListeners();
  }

  void reload() {
    _allSubjects = SubjectsRepository.getAllSubjects();
    _visibleSubjects = _allSubjects;
    notifyListeners();
  }
}

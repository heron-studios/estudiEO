import 'package:flutter_test/flutter_test.dart';
import 'package:learn/data/repository/subjects_repository.dart';

void main() {
  test('Check dummy strings in correct answers', () {
    int dummyCount = 0;
    final subjects = SubjectsRepository.getAllSubjects();
    for (var s in subjects) {
      final questions = SubjectsRepository.getQuestionsBySubject(s.id);
      for (var q in questions) {
        final answer = q.options[q.correctAnswer].trim();
        if (answer == 'Correcta' || answer == 'Opción A' || answer == 'Opción B') {
          print('Dummy answer text: "$answer" for ${q.id} in ${s.id}');
          dummyCount++;
        }
      }
    }
    print('Found $dummyCount dummy answers.');
    expect(dummyCount, 0, reason: 'Found dummy answers.');
  });
}

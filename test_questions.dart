import 'dart:io';
import 'package:learn/data/library_content.dart';
import 'package:learn/models/question.dart';

void main() {
  int invalidCount = 0;
  for (var entry in libraryQuestions.entries) {
    for (var q in entry.value) {
      if (q.correctAnswer < 0 || q.correctAnswer >= q.options.length) {
        print('Invalid question: ${q.id} in ${entry.key}. Options length: ${q.options.length}, correctAnswer: ${q.correctAnswer}');
        invalidCount++;
      }
    }
  }
  if (invalidCount == 0) {
    print('All questions are valid!');
  } else {
    print('Found $invalidCount invalid questions.');
  }
}

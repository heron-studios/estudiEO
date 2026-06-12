import 'lib/core/services/bible_service.dart';

void main() async {
  final verse = await BibleService.getDailyVerse();
  print('Result: $verse');
}

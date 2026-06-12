import 'dart:convert';
import 'package:http/http.dart' as http;

class BibleService {
  static const List<String> _dailyVerses = [
    'salmos/23/1', // 1
    'juan/3/16',   // 2
    'filipenses/4/13', // 3
    'proverbios/3/5', // 4
    'isaias/41/10', // 5
    'romanos/8/28', // 6
    'jeremias/29/11', // 7
    'salmos/46/1', // 8
    'mateo/11/28', // 9
    'josue/1/9', // 10
    'romanos/12/2', // 11
    'isaias/40/31', // 12
    'hebreos/11/1', // 13
    'salmos/119/105', // 14
    'proverbios/4/23', // 15
    '1-corintios/13/4', // 16
    '2-corintios/5/17', // 17
    'galatas/5/22', // 18
    'efesios/2/8', // 19
    'colosenses/3/23', // 20
    '1-tesalonicenses/5/16-18', // 21
    '2-timoteo/1/7', // 22
    'santiago/1/5', // 23
    '1-pedro/5/7', // 24
    '1-juan/4/8', // 25
    'apocalipsis/3/20', // 26
    'mateo/6/33', // 27
    'juan/14/6', // 28
    'romanos/6/23', // 29
    'isaias/53/5', // 30
    'salmos/121/1', // 31
  ];

  static Future<String?> getDailyVerse() async {
    try {
      final dayIndex = (DateTime.now().day - 1).clamp(0, 30);
      final ref = _dailyVerses[dayIndex];
      
      final url = Uri.parse('https://bible-api.deno.dev/api/read/rv1960/$ref');
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        String versesText = '';
        
        if (data is List) {
          if (data.isNotEmpty) {
            versesText = data.map((v) => v['verse']).join(' ');
          }
        } else if (data is Map) {
          versesText = data['verse'] ?? '';
        }

        if (versesText.isNotEmpty) {
          // Formateamos la referencia para mostrarla bonita
          final parts = ref.split('/');
          final bookName = parts[0].replaceAll('-', ' ').toUpperCase();
          final chapterVerse = parts.sublist(1).join(':');
          
          return '"$versesText"\n- $bookName $chapterVerse';
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

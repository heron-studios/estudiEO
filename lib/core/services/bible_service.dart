import 'dart:convert';
import 'package:http/http.dart' as http;

class BibleService {
  static String? _cachedVerse;
  static bool hasShownDailyVerse = false;

  static const List<String> _dailyVerses = [
    'salmos/23/1', // 1
    'filipenses/4/13', // 2
    '1-tesalonicenses/5/17', // 3
    '1-tesalonicenses/5/16', // 4
    '1-juan/4/8', // 5
    '1-juan/4/19', // 6
    'salmos/56/3', // 7
    'proverbios/3/5', // 8
    'salmos/119/105', // 9
    '1-tesalonicenses/5/18', // 10
    'hebreos/13/8', // 11
    'efesios/4/32', // 12
    'colosenses/3/20', // 13
    'salmos/37/5', // 14
    'proverbios/10/12', // 15
    'romanos/12/9', // 16
    'romanos/12/12', // 17
    'romanos/12/21', // 18
    '1-juan/5/3', // 19
    'salmos/150/6', // 20
    'santiago/4/7', // 21
    '1-pedro/5/7', // 22
    'filipenses/4/4', // 23
    'juan/10/14', // 24
    'salmos/46/10', // 25
    'salmos/27/1', // 26
    'salmos/118/24', // 27
    'proverbios/17/22', // 28
    '1-juan/3/18', // 29
    'salmos/34/8', // 30
    'colosenses/3/2', // 31
  ];

  static Future<String?> getDailyVerse() async {
    if (_cachedVerse != null) return _cachedVerse;
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
          
          _cachedVerse = '"$versesText" ($bookName $chapterVerse)';
          return _cachedVerse;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}


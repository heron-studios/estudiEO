import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class BibleService {
  static String? _cachedVerse;

  static bool get hasShownDailyVerse {
    try {
      final box = Hive.box('estudieo_data');
      final lastShownDate = box.get('last_shown_daily_verse_date') as String?;
      if (lastShownDate == null) return false;

      final todayStr = _getTodayDateString();
      return lastShownDate == todayStr;
    } catch (_) {
      return false;
    }
  }

  static set hasShownDailyVerse(bool value) {
    try {
      final box = Hive.box('estudieo_data');
      if (value) {
        box.put('last_shown_daily_verse_date', _getTodayDateString());
      } else {
        box.delete('last_shown_daily_verse_date');
      }
    } catch (_) {}
  }

  static String _getTodayDateString() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

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

  static const List<String> _fallbackTexts = [
    'Jehová es mi pastor; nada me faltará. (SALMOS 23:1)',
    'Todo lo puedo en Cristo que me fortalece. (FILIPENSES 4:13)',
    'Orad sin cesar. (1 TESALONICENSES 5:17)',
    'Estad siempre gozosos. (1 TESALONICENSES 5:16)',
    'El que no ama, no ha conocido a Dios; porque Dios es amor. (1 JUAN 4:8)',
    'Nosotros le amamos a él, porque él nos amó primero. (1 JUAN 4:19)',
    'En el día que temo, yo en ti confío. (SALMOS 56:3)',
    'Fíate de Jehová de todo tu corazón, y no te apoyes en tu propia prudencia. (PROVERBIOS 3:5)',
    'Lámpara es a mis pies tu palabra, y lumbrera a mi camino. (SALMOS 119:105)',
    'Dad gracias en todo, porque esta es la voluntad de Dios para con vosotros en Cristo Jesús. (1 TESALONICENSES 5:18)',
    'Jesucristo es el mismo ayer, y hoy, y por los siglos. (HEBREOS 13:8)',
    'Antes sed benignos unos con otros, misericordiosos, perdonándoos unos a otros, como Dios también os perdonó a vosotros en Cristo. (EFESIOS 4:32)',
    'Hijos, obedeced a vuestros padres en todo, porque esto agrada al Señor. (COLOSENSES 3:20)',
    'Encomienda a Jehová tu camino, y confía en él; y él hará. (SALMOS 37:5)',
    'El odio despierta rencillas; pero el amor cubrirá todas las faltas. (PROVERBIOS 10:12)',
    'El amor sea sin fingimiento. Aborreced lo malo, seguid lo bueno. (ROMANOS 12:9)',
    'Gozosos en la esperanza; sufridos en la tribulación; constantes en la oración. (ROMANOS 12:12)',
    'No seas vencido de lo malo, sino vence con el bien el mal. (ROMANOS 12:21)',
    'Pues este es el amor a Dios, que guardemos sus mandamientos; y sus mandamientos no son gravosos. (1 JUAN 5:3)',
    'Todo lo que respira alabe a JAH. Aleluya. (SALMOS 150:6)',
    'Someteos, pues, a Dios; resistid al diablo, y huirá de vosotros. (SANTIAGO 4:7)',
    'Echando toda vuestra ansiedad sobre él, porque él tiene cuidado de vosotros. (1 PEDRO 5:7)',
    'Regocijaos en el Señor siempre. Otra vez digo: ¡Regocijaos! (FILIPENSES 4:4)',
    'Yo soy el buen pastor; y conozco mis ovejas, y las mías me conocen. (JUAN 10:14)',
    'Estad quietos, y conoced que yo soy Dios; seré exaltado entre las naciones; enaltecido seré en la tierra. (SALMOS 46:10)',
    'Jehová es mi luz y mi salvación; ¿de quién temeré? Jehová es la fortaleza de mi vida; ¿de quién he de atemorizarme? (SALMOS 27:1)',
    'Este es el día que hizo Jehová; nos gozaremos y alegraremos en él. (SALMOS 118:24)',
    'El corazón alegre constituye buen remedio; mas el espíritu triste seca los huesos. (PROVERBIOS 17:22)',
    'Hijos míos, no amemos de palabra ni de lengua, sino de hecho y en verdad. (1 JUAN 3:18)',
    'Gustad, y ved que es bueno Jehová; dichoso el hombre que confía en él. (SALMOS 34:8)',
    'Poned la mira en las cosas de arriba, no en las de la tierra. (COLOSENSES 3:2)',
  ];

  static Future<String?> getDailyVerse() async {
    if (_cachedVerse != null) return _cachedVerse;
    final dayIndex = (DateTime.now().day - 1).clamp(0, 30);
    try {
      final ref = _dailyVerses[dayIndex];

      final url = Uri.parse('https://bible-api.deno.dev/api/read/rv1960/$ref');
      final response = await http.get(url).timeout(const Duration(seconds: 3));

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
      return _getLocalFallbackVerse(dayIndex);
    } catch (e) {
      return _getLocalFallbackVerse(dayIndex);
    }
  }

  static String _getLocalFallbackVerse(int dayIndex) {
    final text = _fallbackTexts[dayIndex % _fallbackTexts.length];
    _cachedVerse = text;
    return text;
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LimitsService {
  static const int MAX_QUESTIONS_PER_DAY = 10;
  static const int MAX_SIMULACROS_PER_WEEK = 1;
  static const int MAX_IA_PER_WEEK = 1;

  // Keys
  static const String _kQuestionsDate = 'limits_questions_date';
  static const String _kQuestionsCount = 'limits_questions_count';
  
  static const String _kSimulacroWeek = 'limits_simulacro_week';
  static const String _kSimulacroCount = 'limits_simulacro_count';
  
  static const String _kIAWeek = 'limits_ia_week';
  static const String _kIACount = 'limits_ia_count';

  /// Retorna si el usuario puede realizar otra pregunta (flashcards/trivia)
  static Future<bool> canAnswerQuestion() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    
    final savedDate = prefs.getString(_kQuestionsDate);
    if (savedDate != today) {
      // Nuevo día
      await prefs.setString(_kQuestionsDate, today);
      await prefs.setInt(_kQuestionsCount, 0);
      return true;
    }
    
    final count = prefs.getInt(_kQuestionsCount) ?? 0;
    return count < MAX_QUESTIONS_PER_DAY;
  }

  /// Incrementa el conteo de preguntas respondidas hoy
  static Future<void> incrementQuestionCount() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    
    final savedDate = prefs.getString(_kQuestionsDate);
    if (savedDate != today) {
      await prefs.setString(_kQuestionsDate, today);
      await prefs.setInt(_kQuestionsCount, 1);
    } else {
      final count = prefs.getInt(_kQuestionsCount) ?? 0;
      await prefs.setInt(_kQuestionsCount, count + 1);
    }
  }

  /// Calcula la clave semanal (ej. 2026-W30)
  static String _getCurrentWeekKey() {
    final now = DateTime.now();
    // Aproximación simple de semana
    int weekNumber = ((now.day - now.weekday + 10) / 7).floor();
    return '${now.year}-W$weekNumber-${now.month}'; // Diferenciar meses
  }

  /// Retorna si el usuario puede hacer un simulacro
  static Future<bool> canTakeSimulacro() async {
    final prefs = await SharedPreferences.getInstance();
    final weekKey = _getCurrentWeekKey();
    
    final savedWeek = prefs.getString(_kSimulacroWeek);
    if (savedWeek != weekKey) {
      await prefs.setString(_kSimulacroWeek, weekKey);
      await prefs.setInt(_kSimulacroCount, 0);
      return true;
    }
    
    final count = prefs.getInt(_kSimulacroCount) ?? 0;
    return count < MAX_SIMULACROS_PER_WEEK;
  }

  /// Incrementa el uso de simulacro
  static Future<void> incrementSimulacroCount() async {
    final prefs = await SharedPreferences.getInstance();
    final weekKey = _getCurrentWeekKey();
    
    final savedWeek = prefs.getString(_kSimulacroWeek);
    if (savedWeek != weekKey) {
      await prefs.setString(_kSimulacroWeek, weekKey);
      await prefs.setInt(_kSimulacroCount, 1);
    } else {
      final count = prefs.getInt(_kSimulacroCount) ?? 0;
      await prefs.setInt(_kSimulacroCount, count + 1);
    }
  }

  /// Retorna si el usuario puede usar la IA (Entrevista/Redacción)
  static Future<bool> canUseIA() async {
    final prefs = await SharedPreferences.getInstance();
    final weekKey = _getCurrentWeekKey();
    
    final savedWeek = prefs.getString(_kIAWeek);
    if (savedWeek != weekKey) {
      await prefs.setString(_kIAWeek, weekKey);
      await prefs.setInt(_kIACount, 0);
      return true;
    }
    
    final count = prefs.getInt(_kIACount) ?? 0;
    return count < MAX_IA_PER_WEEK;
  }

  /// Incrementa el uso de IA
  static Future<void> incrementIACount() async {
    final prefs = await SharedPreferences.getInstance();
    final weekKey = _getCurrentWeekKey();
    
    final savedWeek = prefs.getString(_kIAWeek);
    if (savedWeek != weekKey) {
      await prefs.setString(_kIAWeek, weekKey);
      await prefs.setInt(_kIACount, 1);
    } else {
      final count = prefs.getInt(_kIACount) ?? 0;
      await prefs.setInt(_kIACount, count + 1);
    }
  }
}

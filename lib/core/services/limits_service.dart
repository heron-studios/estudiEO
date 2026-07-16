import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LimitsService {
  static const int maxQuestionsPerDay = 10;
  static const int maxSimulacrosPerWeek = 1;

  // Límites IA (Tutor/Explicador)
  static const int maxTutorPerDayFree = 3;
  static const int maxTutorPerDayPremium = 50;

  // Límites IA (Entrevista/Simulador)
  static const int maxEntrevistaPerDayFree = 1;
  static const int maxEntrevistaPerDayPremium = 5; // Aunque sea premium, tiene un límite diario seguro

  // Keys
  static const String _kQuestionsDate = 'limits_questions_date';
  static const String _kQuestionsCount = 'limits_questions_count';
  
  static const String _kSimulacroWeek = 'limits_simulacro_week';
  static const String _kSimulacroCount = 'limits_simulacro_count';
  
  static const String _kTutorIADate = 'limits_tutor_ia_date';
  static const String _kTutorIACount = 'limits_tutor_ia_count';

  static const String _kEntrevistaIADate = 'limits_entrevista_ia_date';
  static const String _kEntrevistaIACount = 'limits_entrevista_ia_count';

  /// Retorna si el usuario puede realizar otra pregunta (flashcards/trivia)
  static Future<bool> canAnswerQuestion() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    
    final savedDate = prefs.getString(_kQuestionsDate);
    if (savedDate != today) {
      await prefs.setString(_kQuestionsDate, today);
      await prefs.setInt(_kQuestionsCount, 0);
      return true;
    }
    
    final count = prefs.getInt(_kQuestionsCount) ?? 0;
    return count < maxQuestionsPerDay;
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
    int weekNumber = ((now.day - now.weekday + 10) / 7).floor();
    return '${now.year}-W$weekNumber-${now.month}';
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
    return count < maxSimulacrosPerWeek;
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

  /// Retorna si el usuario puede consultar al Tutor IA
  static Future<bool> canUseTutorIA(bool isPremium) async {
    final limit = isPremium ? maxTutorPerDayPremium : maxTutorPerDayFree;
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    
    final savedDate = prefs.getString(_kTutorIADate);
    if (savedDate != today) {
      await prefs.setString(_kTutorIADate, today);
      await prefs.setInt(_kTutorIACount, 0);
      return true;
    }
    
    final count = prefs.getInt(_kTutorIACount) ?? 0;
    return count < limit;
  }

  /// Incrementa el uso del Tutor IA
  static Future<void> incrementTutorIACount() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    
    final savedDate = prefs.getString(_kTutorIADate);
    if (savedDate != today) {
      await prefs.setString(_kTutorIADate, today);
      await prefs.setInt(_kTutorIACount, 1);
    } else {
      final count = prefs.getInt(_kTutorIACount) ?? 0;
      await prefs.setInt(_kTutorIACount, count + 1);
    }
  }

  /// Retorna si el usuario puede iniciar una entrevista simulada con IA
  static Future<bool> canUseEntrevistaIA(bool isPremium) async {
    final limit = isPremium ? maxEntrevistaPerDayPremium : maxEntrevistaPerDayFree;
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    
    final savedDate = prefs.getString(_kEntrevistaIADate);
    if (savedDate != today) {
      await prefs.setString(_kEntrevistaIADate, today);
      await prefs.setInt(_kEntrevistaIACount, 0);
      return true;
    }
    
    final count = prefs.getInt(_kEntrevistaIACount) ?? 0;
    return count < limit;
  }

  /// Incrementa el uso de Entrevista simulada
  static Future<void> incrementEntrevistaIACount() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    
    final savedDate = prefs.getString(_kEntrevistaIADate);
    if (savedDate != today) {
      await prefs.setString(_kEntrevistaIADate, today);
      await prefs.setInt(_kEntrevistaIACount, 1);
    } else {
      final count = prefs.getInt(_kEntrevistaIACount) ?? 0;
      await prefs.setInt(_kEntrevistaIACount, count + 1);
    }
  }
}

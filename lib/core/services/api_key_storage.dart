import 'package:shared_preferences/shared_preferences.dart';

class ApiKeyStorage {
  static const String _keyName = 'gemini_api_key';

  /// Guarda la API Key
  static Future<void> saveKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, key);
  }

  /// Obtiene la API Key guardada
  static Future<String?> getKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName);
  }

  /// Elimina la API Key (Cerrar sesión/Eliminar ajustes)
  static Future<void> clearKey() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyName);
  }
}

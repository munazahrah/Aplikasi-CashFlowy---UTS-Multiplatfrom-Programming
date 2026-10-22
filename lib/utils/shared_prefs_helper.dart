import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _themeKey = 'isDarkMode';
  static const String _nameKey = 'username';

  // --- TEMA ---
  static Future<void> setTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }

  static Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false; // Default: Light
  }

  // --- NAMA PENGGUNA ---
  static Future<void> setUsername(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
  }

  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey) ?? 'Pengguna';
  }
}

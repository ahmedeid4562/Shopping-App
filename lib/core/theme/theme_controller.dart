import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  static final ThemeController instance = ThemeController._();
  static const String _themeKey = 'isDarkMode';
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode {
    return _isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeController._();

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    _isDarkMode = prefs.getBool(_themeKey) ?? false;

    notifyListeners();
  }

  Future<void> toggleTheme(bool value) async {
    _isDarkMode = value;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_themeKey, value);

    notifyListeners();
  }
}

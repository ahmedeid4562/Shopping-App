import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ChangeNotifier {
  LocaleController._();

  static final LocaleController instance = LocaleController._();

  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'en';

    _locale = Locale(languageCode);
    notifyListeners();
  }

  Future<void> changeLocale(String languageCode) async {
    if (languageCode != 'ar' && languageCode != 'en') return;

    _locale = Locale(languageCode);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);

    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//CLARO
ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFFFFFFF),
    accentColor: Colors.green[700],
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    cardTheme: CardTheme(
      color: Color(0xFFF1F1F1),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFFF9F9F9),
    ),
    bottomAppBarColor: Color(0xFFE6E6E6),
    bottomSheetTheme:
    BottomSheetThemeData(modalBackgroundColor: Color(0xFFF5F5F5)));

//ESCURO
ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF202022),
    accentColor: Color(0xFF1DA156),
    scaffoldBackgroundColor: Color(0xFF202022),
    cardTheme: CardTheme(
      color: Color(0xFF2A2A2C),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFF2D2D2F),
    ),
    bottomAppBarColor: Color(0xFF171719),
    bottomSheetTheme:
    BottomSheetThemeData(modalBackgroundColor: Color(0xFF202022)));

class ThemeNotifier extends ChangeNotifier {
  final String key = 'valorTema';
  late SharedPreferences prefs;
  late bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
      prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}

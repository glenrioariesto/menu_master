import 'package:flutter/material.dart';

enum ThemeType {
  light,
  dark,
}

class ThemeNotifier extends ChangeNotifier {
  ThemeType _currentTheme = ThemeType.light;

  ThemeType get currentTheme => _currentTheme;

  void setTheme(ThemeType themeType) {
    _currentTheme = themeType;
    notifyListeners();
  }
}

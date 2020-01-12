/// This file defines the themes to be used in rest of the app.
/// Any user defined theme must always return the type [ThemeData]

import 'package:flutter/material.dart' show ChangeNotifier, ThemeData;

import 'sample_theme_dark.dart';
import 'sample_theme_light.dart';

enum ThemeType { LIGHT, DARK }

/// Theme Provider
class ThemeModel extends ChangeNotifier {
  ThemeData _currentTheme = ThemeLight.themeData;
  ThemeType _themeType = ThemeType.LIGHT;

  ThemeData get currentTheme => _currentTheme;

  toggleTheme() {
    switch (_themeType) {
      case ThemeType.LIGHT:
        {
          _currentTheme = ThemeDark.themeData;
          _themeType = ThemeType.DARK;
          return notifyListeners();
        }
      case ThemeType.DARK:
        {
          _currentTheme = ThemeLight.themeData;
          _themeType = ThemeType.LIGHT;
          return notifyListeners();
        }
    }
  }
}

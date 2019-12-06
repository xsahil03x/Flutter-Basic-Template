/// This file defines the themes to be used in rest of the app.
/// Any user defined theme must always return the type [ThemeData]

import 'package:flutter/material.dart';

import 'fonts.dart';

enum ThemeType { Light, Dark }

/// Define custom themes here....
ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Color(0xfff5f5f5),
  accentColor: Color(0xff40bf7a),
  textTheme: TextTheme(
    title: TextStyle(color: Colors.black54),
    subtitle: TextStyle(color: Colors.grey),
    subhead: TextStyle(color: Colors.white),
  ),
  appBarTheme: AppBarTheme(
    color: Color(0xff1f655d),
    actionsIconTheme: IconThemeData(color: Colors.white),
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Color(0xff1f655d),
  accentColor: Color(0xff40bf7a),
  textTheme: TextTheme(
    title: TextStyle(color: Color(0xff40bf7a)),
    subtitle: TextStyle(color: Colors.white),
    subhead: TextStyle(color: Color(0xff40bf7a)),
  ),
  appBarTheme: AppBarTheme(
    color: Color(0xff1f655d),
  ),
);

/// Theme Provider
class ThemeModel extends ChangeNotifier {
  ThemeData _currentTheme = lightTheme;
  ThemeType _themeType = ThemeType.Dark;

  ThemeData get currentTheme => _currentTheme;

  toggleTheme() {
    if (_themeType == ThemeType.Dark) {
      _currentTheme = lightTheme;
      _themeType = ThemeType.Light;
      return notifyListeners();
    }

    if (_themeType == ThemeType.Light) {
      _currentTheme = darkTheme;
      _themeType = ThemeType.Dark;
      return notifyListeners();
    }
  }
}

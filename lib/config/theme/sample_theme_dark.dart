import 'package:flutter/material.dart';

import '../fonts.dart';
import 'material_color.dart';

class ThemeDark {
  static final ThemeData themeData = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: _primarySwatch,
    primaryColor: _primaryColor,
    hintColor: _hintColor,
    appBarTheme: _appBarTheme,
    fontFamily: Fonts.DEFAULT_FONT,
    scaffoldBackgroundColor: _scaffoldBackgroundColor,
    unselectedWidgetColor: _unselectedWidgetColor,
    accentColor: _primaryColor,
  );

  static final MaterialColor _primarySwatch =
      hexColor2MaterialColor(0xFF246BB3);
  static final Color _primaryColor = Color(0xFF246BB3);
  static final Color _hintColor = Color(0xffaaaaaa);
  static final Color _unselectedWidgetColor = Color(0xffcccccc);
  static final Color _scaffoldBackgroundColor = Colors.black;

  static final AppBarTheme _appBarTheme = AppBarTheme(
    color: Colors.black,
    elevation: 2,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: _primarySwatch),
    actionsIconTheme: IconThemeData(color: _primarySwatch),
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

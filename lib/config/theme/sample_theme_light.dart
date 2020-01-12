import 'package:flutter/material.dart';

import '../fonts.dart';
import 'material_color.dart';

class ThemeLight {
  static final ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    primarySwatch: _primarySwatch,
    primaryColor: _primaryColor,
    primaryColorDark: _primaryColorDark,
    hintColor: _hintColor,
    appBarTheme: _appBarTheme,
    fontFamily: Fonts.DEFAULT_FONT,
    scaffoldBackgroundColor: _scaffoldBackgroundColor,
    unselectedWidgetColor: _unselectedWidgetColor,
    accentColor: _primaryColor,
  );

  static final MaterialColor _primarySwatch =
      hexColor2MaterialColor(0xFF31B2DF);
  static final Color _primaryColor = Color(0xFF31B2DF);
  static final Color _primaryColorDark = Color(0xFF005486);
  static final Color _hintColor = Color(0xffaaaaaa);
  static final Color _unselectedWidgetColor = Color(0xffcccccc);
  static final Color _scaffoldBackgroundColor = Colors.white;

  static final AppBarTheme _appBarTheme = AppBarTheme(
    color: Colors.white,
    elevation: 2,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: _primarySwatch),
    actionsIconTheme: IconThemeData(color: _primarySwatch),
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

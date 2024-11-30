import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    surface: Color(0xFF36343A),
    primary: Color(0xFF7FABBA),
    onPrimary: Color(0xFFE4E4E4),
    secondary: Color(0xFFEC2D2D),
    onSecondary: Color(0xFF36343A),
    error: Color(0XFFFF0000),
    onError: Color(0xFFE4E4E4),
    onSurface: Color(0xFFE4E4E4),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF36343A),
  ),
);

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    brightness: Brightness.light,
    surface: Color(0xFFE4E4E4),
    primary: Color(0xFF7FABBA),
    onPrimary: Color(0xFF36343A),
    secondary: Color(0xFFEC2D2D),
    onSecondary: Color(0xFF36343A),
    error: Color(0XFFFF0000),
    onError: Color(0xFFE4E4E4),
    onSurface: Color(0xFF36343A),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFE4E4E4),
  ),
);

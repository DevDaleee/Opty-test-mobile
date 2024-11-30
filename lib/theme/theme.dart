import 'package:finance/components/helper/sizes.dart';
import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Poppins',
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    onPrimaryContainer: Color(0xFF3F6784),
    surface: Color(0xFF36343A),
    primary: Color(0xFF7FABBA),
    onPrimary: Color(0xFFE4E4E4),
    secondary: Color(0xFFEC2D2D),
    onSecondary: Color(0xFF36343A),
    error: Color(0XFFFF0000),
    onError: Color(0xFFE4E4E4),
    onSurface: Color(0xFFE4E4E4),
    inverseSurface: Color(0xFFE4E4E4),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF36343A),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xff1E1D20).withOpacity(0.75),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    hintStyle: const TextStyle(
      color: Color(0xFFF7F6F6),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(Color(0xFF3F6784)),
      fixedSize: const WidgetStatePropertyAll(Size(double.maxFinite, 54)),
      textStyle: const WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusSizes.md),
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      fixedSize: const WidgetStatePropertyAll(Size(double.maxFinite, 54)),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Color(0xFFE4E4E4),
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusSizes.md),
        ),
      ),
    ),
  ),
);

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Poppins',
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
    tertiary: Color(0xFF3F6784),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFE4E4E4),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF4F4F4).withOpacity(0.75),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    hintStyle: const TextStyle(
      color: Color(0xff1E1D20),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(Color(0xFF3F6784)),
      fixedSize: const WidgetStatePropertyAll(Size(double.maxFinite, 54)),
      textStyle: const WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusSizes.md),
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      fixedSize: const WidgetStatePropertyAll(Size(double.maxFinite, 54)),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Color(0xFFE4E4E4),
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusSizes.md),
        ),
      ),
    ),
  ),
);

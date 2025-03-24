
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFF32373C),
  primarySwatch: MaterialColor(
    0xFF32373C,
    {
      50: Color(0xFFE3E4E5),
      100: Color(0xFFB8BABC),
      200: Color(0xFF8A8D91),
      300: Color(0xFF5C5F65),
      400: Color(0xFF3C4045),
      500: Color(0xFF32373C),
      600: Color(0xFF2C3035),
      700: Color(0xFF24282C),
      800: Color(0xFF1C2023),
      900: Color(0xFF121416),
    },
  ),
  accentColor: Color(0xFFF78DA7),
  backgroundColor: Color(0xFFFFFFFF),
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF32373C),
    foregroundColor: Color(0xFFFFFFFF),
    elevation: 4,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Color(0xFFFFFFFF),
    ),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 42, fontWeight: FontWeight.normal, color: Color(0xFF000000)),
    headlineMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.normal, color: Color(0xFF000000)),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.normal, color: Color(0xFF000000)),
    bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Color(0xFF000000)),
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFF000000)),
    bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Color(0xFF000000)),
    subtitle1: TextStyle(fontSize: 24, fontWeight: FontWeight.normal, color: Color(0xFF000000)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Color(0xFF32373C),
      onPrimary: Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9999),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      textStyle: TextStyle(fontSize: 18),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Color(0xFF32373C),
      textStyle: TextStyle(fontSize: 18),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: Color(0xFF32373C),
      side: BorderSide(color: Color(0xFF32373C)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9999),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      textStyle: TextStyle(fontSize: 18),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF32373C)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFCF2E2E)),
    ),
    filled: true,
    fillColor: Color(0xFFF7F7F7),
  ),
  cardTheme: CardTheme(
    elevation: 6,
    shadowColor: Colors.black.withOpacity(0.2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    margin: EdgeInsets.all(8),
  ),
);

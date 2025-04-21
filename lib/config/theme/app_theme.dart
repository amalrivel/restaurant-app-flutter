import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColorLight = Color(0xFFFF7043);
  static const Color primaryColorDark = Color(0xFFFF5722);
  static const Color secondaryColorLight = Color(0xFF26A69A);
  static const Color secondaryColorDark = Color(0xFF009688);
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color errorColor = Color(0xFFB00020);

  // Font Family
  static const String fontFamily = 'Poppins';

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColorLight,
    fontFamily: fontFamily,
    colorScheme: ColorScheme.light(
      primary: primaryColorLight,
      secondary: secondaryColorLight,
      surface: surfaceLight,
      background: backgroundLight,
      error: errorColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColorLight,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColorLight,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primaryColorLight),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryColorLight,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColorDark,
    fontFamily: fontFamily,
    scaffoldBackgroundColor: backgroundDark,
    colorScheme: ColorScheme.dark(
      primary: primaryColorDark,
      secondary: secondaryColorDark,
      surface: surfaceDark,
      background: backgroundDark,
      error: errorColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: surfaceDark,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColorDark,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primaryColorDark),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryColorDark,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
  );
}

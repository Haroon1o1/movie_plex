import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._(); // Private constructor to prevent instantiation

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightPrimary,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightPrimary,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightAccent,
      surface: AppColors.lightBackground,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.lightTextPrimary,
    ),
    textTheme:  TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        color: AppColors.lightTextPrimary,
      ),
     
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: AppColors.lightTextPrimary,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextPrimary,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextSecondary,
      ),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkPrimary,
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkAccent,
      surface: AppColors.darkBackground,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.darkTextPrimary,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        color: AppColors.darkTextPrimary,
      ),

      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextSecondary,
      ),
    ),
  );
}

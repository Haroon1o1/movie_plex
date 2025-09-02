import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const Color lightPrimary = Color.fromARGB(
    255,
    239,
    152,
    13,
  ); // Vibrant orange, for buttons & highlights
  static const Color lightBackground = Color(0xFFF5F5F5); // Soft off-white, easy on eyes
  static const Color lightTextPrimary = Color(0xFF1a1922); // Dark text for high contrast
  static const Color lightTextSecondary = Color(0xFF757575); // Medium gray for secondary text
  static const Color lightSecondary = Color(0xFFBDBDBD); // Subtle gray for borders/icons
  static const Color lightAccent = Color(0xFFFFA726); // Accent orange for highlights

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFFFF5E00); // Same vibrant orange, stands out on dark
  static const Color darkBackground = Color(0xFF1a1922); // Dark background for OLED/eye comfort
  static const Color darkTextPrimary = Color(0xFFFFFFFF); // White text for main content
  static const Color darkTextSecondary = Color(0xFFB0B0B0); // Gray for secondary text
  static const Color darkSecondary = Color(0xFF424242); // Dark gray for borders/icons
  static const Color darkAccent = Color(0xFFFFA726); // Accent orange for buttons/highlights
}

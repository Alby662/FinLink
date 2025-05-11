import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Light theme
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: const Color(0xFF1565C0), // Blue 800
    onPrimary: Colors.white,
    secondary: const Color(0xFF00897B), // Teal 600
    onSecondary: Colors.white,
    tertiary: const Color(0xFFFFA000), // Amber 700
    error: const Color(0xFFD32F2F), // Red 700
    background: Colors.grey[50]!,
    surface: Colors.white,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF1565C0),
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    filled: true,
    fillColor: Colors.grey[100],
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
  dividerTheme: const DividerThemeData(
    thickness: 1,
    space: 24,
  ),
);

// Dark theme
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFF42A5F5), // Blue 400
    onPrimary: Colors.black,
    secondary: const Color(0xFF26A69A), // Teal 400
    onSecondary: Colors.black,
    tertiary: const Color(0xFFFFCA28), // Amber 400
    error: const Color(0xFFEF5350), // Red 400
    background: const Color(0xFF121212),
    surface: const Color(0xFF1E1E1E),
  ),
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
  ),
  cardTheme: CardTheme(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    filled: true,
    fillColor: const Color(0xFF2C2C2C),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
  dividerTheme: const DividerThemeData(
    thickness: 1,
    space: 24,
  ),
);

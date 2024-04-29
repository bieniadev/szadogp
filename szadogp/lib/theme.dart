import 'package:flutter/material.dart';

ThemeData themeDark = ThemeData(
  useMaterial3: true,
//   fontFamily: GoogleFonts.poppins().fontFamily,

  primaryColor: const Color.fromARGB(255, 98, 90, 209),
//   scaffoldBackgroundColor: const Color.fromARGB(255, 218, 127, 218),
//   primarySwatch: Colors.blue,
  colorScheme: ColorScheme.fromSeed(
    // primary: const Color.fromARGB(255, 79, 166, 237),
    seedColor: const Color.fromARGB(255, 59, 46, 161),
    background: const Color.fromARGB(255, 21, 20, 43),
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
    labelLarge: TextStyle(
      letterSpacing: 1.5,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
    ),
  ),
);

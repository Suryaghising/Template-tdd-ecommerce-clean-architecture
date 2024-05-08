import 'package:flutter/material.dart';

import 'util.dart';

final kThemeData = ThemeData().copyWith(
  primaryColor: Colors.redAccent,
  appBarTheme: const AppBarTheme().copyWith(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
  floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
  textTheme: const TextTheme().copyWith(
    bodySmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: getResponsiveFont(12),
        color: Colors.black),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: getResponsiveFont(16),
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: getResponsiveFont(16),
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: getResponsiveFont(20),
      fontWeight: FontWeight.w700,
      color: Colors.redAccent,
    ),
  ),
);

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

enum AppTheme { light, dark }

final lightTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: const Color(0xFF7E47FF),
    primaryVariant: const Color(0xFF6140D7),
    secondary: Colors.orange,
    secondaryVariant: Colors.orange[700],
    surface: Colors.white,
    background: const Color(0xFFF2F2F2),
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF7E47FF),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  scaffoldBackgroundColor: const Color(0xFFF2F2F2),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme(
    primary: Color(0xFF7E47FF),
    primaryVariant: Color(0xFF6140D7),
    secondary: Color(0xFFD43BE6),
    secondaryVariant: Color(0xFF8A2BE2),
    surface: Color(0xFF1E1E1E),
    background: Color(0xFF121212),
    error: Color(0xFFCF6679),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
    brightness: Brightness.dark,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF7E47FF),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  scaffoldBackgroundColor: const Color(0xFF121212),
);

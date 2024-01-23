import 'package:flutter/material.dart';

const colorPrimary = Color(0xFFf8927b);
const colorSecondary = Color(0xFF1A36B9);

ThemeData mainTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: colorPrimary,
        onPrimary: Colors.white,
        secondary: colorSecondary,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.black,
        onBackground: Colors.white,
        surface: Colors.black,
        onSurface: Colors.white),
    textTheme: const TextTheme(displayLarge: TextStyle(
      fontFamily: 'Kanit'
    )));

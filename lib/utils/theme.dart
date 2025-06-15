import 'package:flutter/material.dart';

ThemeData lightTheme(Color accentColor) {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: accentColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: accentColor,
      ),
    ),
    colorScheme: ColorScheme.light(
      secondary: accentColor,
    ),
  );
}

ThemeData darkTheme(Color accentColor) {
  return ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    primaryColor: Colors.blue,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      foregroundColor: accentColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: accentColor,
      ),
    ),
    colorScheme: ColorScheme.dark(
      secondary: accentColor,
    ),
  );
}
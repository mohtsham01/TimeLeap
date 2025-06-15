import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Color _accentColor = Colors.blue[700]!;
  String _accentColorName = 'Blue';
  bool _showMilliseconds = true;

  static const Map<String, Color> availableColors = {
    'Blue': Colors.blue,
    'Green': Colors.green,
    'Red': Colors.red,
    'Yellow': Colors.yellow,
    'Pink': Colors.pink,
    'Orange': Colors.orange,
    'Purple': Colors.deepPurpleAccent,
  };

  ThemeProvider() {
    _loadPreferences();
  }

  ThemeMode get themeMode => _themeMode;
  Color get accentColor => _accentColor;
  String get accentColorName => _accentColorName;
  bool get showMilliseconds => _showMilliseconds;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _saveThemeMode();
    notifyListeners();
  }

  void setAccentColor(Color color, String colorName) {
    _accentColor = color;
    _accentColorName = colorName;
    _saveAccentColor();
    notifyListeners();
  }

  void setShowMilliseconds(bool value) {
    _showMilliseconds = value;
    _saveShowMilliseconds();
    notifyListeners();
  }

  Future<void> _saveThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('themeMode', _themeMode.toString());
    } catch (e) {
      debugPrint('Error saving theme mode: $e');
    }
  }

  Future<void> _saveAccentColor() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // ignore: deprecated_member_use
      await prefs.setInt('accentColor', _accentColor.value);
      await prefs.setString('accentColorName', _accentColorName);
    } catch (e) {
      debugPrint('Error saving accent color: $e');
    }
  }

  Future<void> _saveShowMilliseconds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('showMilliseconds', _showMilliseconds);
    } catch (e) {
      debugPrint('Error saving show milliseconds: $e');
    }
  }

  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final themeString = prefs.getString('themeMode');
      if (themeString != null) {
        _themeMode = ThemeMode.values.firstWhere(
          (e) => e.toString() == themeString,
          orElse: () => ThemeMode.system,
        );
      }

      final colorValue = prefs.getInt('accentColor');
      final colorName = prefs.getString('accentColorName');
      if (colorValue != null && colorName != null) {
        _accentColor = Color(colorValue);
        _accentColorName = colorName;
      }

      final showMs = prefs.getBool('showMilliseconds');
      if (showMs != null) {
        _showMilliseconds = showMs;
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading preferences: $e');
    }
  }
}
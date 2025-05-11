import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _loading = true;
  
  // Getters
  ThemeMode get themeMode => _themeMode;
  bool get loading => _loading;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  
  // Constructor
  ThemeProvider() {
    _loadThemePreference();
  }
  
  // Load theme preference from storage
  Future<void> _loadThemePreference() async {
    try {
      _loading = true;
      notifyListeners();
      
      final prefs = await SharedPreferences.getInstance();
      final themeModeString = prefs.getString('themeMode') ?? 'system';
      
      switch (themeModeString) {
        case 'light':
          _themeMode = ThemeMode.light;
          break;
        case 'dark':
          _themeMode = ThemeMode.dark;
          break;
        default:
          _themeMode = ThemeMode.system;
      }
    } catch (e) {
      // Default to system theme if there's an error
      _themeMode = ThemeMode.system;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  
  // Set theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    
    _themeMode = mode;
    notifyListeners();
    
    // Save preference
    final prefs = await SharedPreferences.getInstance();
    String themeModeString;
    
    switch (mode) {
      case ThemeMode.light:
        themeModeString = 'light';
        break;
      case ThemeMode.dark:
        themeModeString = 'dark';
        break;
      default:
        themeModeString = 'system';
    }
    
    await prefs.setString('themeMode', themeModeString);
  }
  
  // Toggle between light and dark mode
  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      await setThemeMode(ThemeMode.dark);
    } else if (_themeMode == ThemeMode.dark) {
      await setThemeMode(ThemeMode.light);
    } else {
      // If system, check current brightness and set opposite
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      await setThemeMode(brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark);
    }
  }
}

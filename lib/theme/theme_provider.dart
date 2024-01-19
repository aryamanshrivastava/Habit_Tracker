import 'package:flutter/material.dart';
import 'package:habit_tracker/theme/light_mode.dart';

import 'dark_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData themeData = lightMode;
  ThemeData get getTheme => themeData;
  bool get isDarkMode => themeData == darkMode;
  set setTheme(ThemeData theme) {
    themeData = theme;
    notifyListeners();
  }

  void toggleTheme() {
    themeData = isDarkMode ? lightMode : darkMode;
    notifyListeners();
  }
}

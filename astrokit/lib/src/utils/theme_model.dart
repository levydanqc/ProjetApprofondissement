import 'package:flutter/material.dart';
import 'themes.dart' as theme;

class ThemeModel extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  static ThemeData darkTheme = theme.darkTheme;

  toggleTheme() {
    if (themeMode == ThemeMode.system) {
      darkTheme = theme.redTheme;
      themeMode = ThemeMode.dark;
      return notifyListeners();
    } else if (themeMode == ThemeMode.dark) {
      darkTheme = theme.darkTheme;
      themeMode = ThemeMode.system;
      return notifyListeners();
    }
  }
}

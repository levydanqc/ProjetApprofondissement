import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'themes.dart' as theme;

class ThemeModel extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  static ThemeData darkTheme = theme.darkTheme;
  static const redFilterColor = Color(0xffD93B30);

  toggleTheme() async {
    if (themeMode == ThemeMode.system) {
      darkTheme = theme.redTheme;
      themeMode = ThemeMode.dark;

      return notifyListeners();
    } else if (themeMode == ThemeMode.dark) {
      darkTheme = theme.darkTheme;
      themeMode = ThemeMode.system;

      return notifyListeners();
    }
    playLocalAsset();
  }

  bool get redModeEnabled => themeMode == ThemeMode.dark;
  Color get overlayColor =>
      darkTheme == theme.redTheme ? redFilterColor : Colors.transparent;

  Future<AudioPlayer> playLocalAsset() async {
    AudioCache cache = AudioCache();
    return await cache.play("opening.mp3");
  }
}

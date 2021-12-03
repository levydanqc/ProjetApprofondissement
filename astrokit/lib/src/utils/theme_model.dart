import 'package:astrokit/src/utils/file_manager.dart';
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  static const Color redOverlay = Color(0xffD93B30);
  static Color redFilter = Colors.transparent;

  toggleTheme() async {
    playLocalAsset("switch.mp3");
    if (redFilter == Colors.transparent) {
      redFilter = redOverlay;

      return notifyListeners();
    } else if (redFilter == redOverlay) {
      redFilter = Colors.transparent;

      return notifyListeners();
    }
  }

  Color get overlayColor => redFilter;
  bool get redModeEnabled => redFilter == redOverlay;
}

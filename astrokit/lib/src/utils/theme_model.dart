import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  static const Color redOverlay = Color(0xffD93B30);
  static Color redFilter = Colors.transparent;

  toggleTheme() async {
    if (redFilter == Colors.transparent) {
      redFilter = redOverlay;

      return notifyListeners();
    } else if (redFilter == redOverlay) {
      redFilter = Colors.transparent;

      return notifyListeners();
    }
    // playLocalAsset();
  }

  Color get overlayColor => redFilter;
  bool get redModeEnabled => redFilter == redOverlay;

  Future<AudioPlayer> playLocalAsset() async {
    AudioCache cache = AudioCache();
    return await cache.play("opening.mp3");
  }
}

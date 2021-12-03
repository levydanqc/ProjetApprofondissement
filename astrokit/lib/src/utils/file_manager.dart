import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> localFile(String fileName) async {
  final path = await localPath;
  return File('$path/$fileName.json');
}

Future<File> writeToFile(String data, String pFileName) async {
  final file = await localFile(pFileName);

  return file.writeAsString(data);
}

Future<String> readFile(String pFileName) async {
  try {
    final file = await localFile(pFileName);

    final contents = await file.readAsString();
    return contents;
  } catch (e) {
    /// Return 0 if an error occured.
    /// i.e. file does not exist.
    return "0";
  }
}

Future<ByteData> loadAsset(String pFileName) async {
  return await rootBundle.load('assets/$pFileName');
}

void playLocalAsset(String pFileName) async {
  final file = File('${(await getTemporaryDirectory()).path}/$pFileName');
  await file.writeAsBytes((await loadAsset(pFileName)).buffer.asUint8List());
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  final _ = await audioPlayer.play(file.path, isLocal: true);
}

import 'package:path_provider/path_provider.dart';
import 'dart:io';

String fileName = "";

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get localFile async {
  final path = await localPath;
  return File('$path/$fileName.json');
}

Future<File> writeToFile(String data, String pFileName) async {
  fileName = pFileName;
  final file = await localFile;

  return file.writeAsString(data);
}

Future<String> readFile(String pFileName) async {
  fileName = pFileName;
  try {
    final file = await localFile;

    final contents = await file.readAsString();
    return contents;
  } catch (e) {
    /// Return 0 if an error occured.
    return "0";
  }
}

import '../shared/CustomErrors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../.env.dart' as env;

class Forecast {
  /// Finding path to the documents directory
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  /// Returning the file
  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/forecast.json');
  }

  /// Writing to the file
  static Future<File> _writeToFile(String data) async {
    final file = await _localFile;

    return file.writeAsString(data);
  }

  /// Reading the file
  static Future<String> _readFile() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      return contents;
    } on FileSystemException {
      /// Throw an error of type [FileNotFound] if the file wasn't found.
      throw FileNotFound();
    } catch (e) {
      /// Return 0 if an error occured.
      return "0";
    }
  }

  /// Getting forecast data from API.
  ///
  /// Storing forecast data inside [data].
  static Future<Map> getForecast(double lat, double lon) async {
    Map data = {};

    // Get forecast for the next 16 days daily.
    var response = await http.get(
      Uri.parse(
          'https://rapidapi.p.rapidapi.com/forecast/daily?lon=$lon&lat=$lat'),
      headers: {
        'x-rapidapi-host': 'weatherbit-v1-mashape.p.rapidapi.com',
        'x-rapidapi-key': env.API_KEY,
      },
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);

      int now = DateTime.now().millisecondsSinceEpoch;
      data['lastUpdate'] = now;

      _writeToFile(jsonEncode(data));
    }
    return data;
  }

  static Future<Map?> loadForecast(double lat, double lon) async {
    try {
      Map data = jsonDecode(await _readFile());

      // Minimum of 24h before updating value
      if (data["lastUpdate"] + 86400000 >
          DateTime.now().millisecondsSinceEpoch) {
        data = await getForecast(lat, lon);
      }

      return data;
    } catch (e) {
      return null;
    }
  }
}

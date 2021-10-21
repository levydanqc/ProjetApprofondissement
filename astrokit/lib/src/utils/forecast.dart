import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../.env.dart' as env;
import './file_manager.dart';

class Forecast {
  static const String fileName = "forecast";

  /// Getting forecast data from API.
  /// Storing forecast data inside [data].
  static Future<Map> getForecast(double lat, double lon) async {
    Map data = {};

    // Get forecast for the next 16 days daily.
    var response = await http.get(
      Uri.parse('https://weatherbit-v1-mashape.p.rapidapi.com/forecast/daily'
          '?lon=$lon&lat=$lat'),
      headers: {
        'x-rapidapi-host': 'weatherbit-v1-mashape.p.rapidapi.com',
        'x-rapidapi-key': env.WEATHERBIT_API,
      },
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);

      int now = DateTime.now().millisecondsSinceEpoch;
      data['lastUpdate'] = now;

      writeToFile(jsonEncode(data), fileName);
    }
    return data;
  }

  static Future<Map> loadForecast(double lat, double lon) async {
    Map data;
    final path = await localPath;

    if (File('$path/forecast.json').existsSync()) {
      data = jsonDecode(await readFile(fileName));

      // Minimum of 24h before updating value
      if (data["creation"] != "File Creation." &&
          data["lastUpdate"] + 86400000 >
              DateTime.now().millisecondsSinceEpoch) {
        return data;
      }
    }

    return getForecast(lat, lon);
  }
}

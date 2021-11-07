import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class File {
  static const storage = FlutterSecureStorage();
  static const options =
      IOSOptions(accessibility: IOSAccessibility.first_unlock_this_device);

  static void write(String key, String value) async {
    return await storage.write(key: key, value: value, iOptions: options);
  }

  static Future read(String key) async {
    return await storage.read(key: key, iOptions: options);
  }
}

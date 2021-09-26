import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class File {
  late String value;
  late String key;

  static const storage = FlutterSecureStorage();
  static const options =
      IOSOptions(accessibility: IOSAccessibility.first_unlock_this_device);

  File.write(key, value) {
    _write(key, value);
  }

  File.read(this.key) {
    value = _read(key).toString();
  }

  static _write(key, value) async {
    await storage.write(key: key, value: value, iOptions: options);
  }

  static Future<String?> _read(key) async {
    return await storage.read(key: key, iOptions: options);
  }
}

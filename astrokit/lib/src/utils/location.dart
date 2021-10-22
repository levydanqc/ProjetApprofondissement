import 'dart:convert';

import 'package:astrokit/src/Screens/user_settings.dart';
import 'package:astrokit/src/utils/file_manager.dart';
import 'package:astrokit/src/utils/position.dart' as pos;
import 'package:astrokit/src/utils/round.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';

Future<void> getLocation() async {
  var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  addLocation(position);
}

Future<bool> getPermissions(location) async {
  late bool serviceEnabled;
  late LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return Future.value(true);
}

void addLocation(location) async {
  List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
      location.latitude!, location.longitude!);
  if (placemarks.isNotEmpty) {
    pos.Position selected = pos.Position(
      latitude: roundDouble(location.latitude!, 2),
      longitude: roundDouble(location.longitude!, 2),
      streetNumber: placemarks[0].subThoroughfare!,
      street: placemarks[0].thoroughfare!,
      postalCode: placemarks[0].postalCode!,
      country: placemarks[0].isoCountryCode!,
      state: placemarks[0].administrativeArea!,
      city: placemarks[0].locality!,
    );
    readFile(UserSettings.fileName).then((locationJson) {
      List list = locationJson != "0"
          ? jsonDecode(locationJson)
              .map((location) => pos.Position.fromJson(location))
              .toList()
          : [];
      if (!list.contains(selected)) {
        list.add(selected);
        writeToFile(jsonEncode(list), UserSettings.fileName);
      }
    });
  }
}

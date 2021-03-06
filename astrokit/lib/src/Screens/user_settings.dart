import 'dart:convert';

import 'package:astrokit/src/Screens/login.dart';
import 'package:astrokit/src/Shared/action_button.dart';
import 'package:astrokit/src/Shared/app_bar.dart';
import 'package:astrokit/src/Shared/error_screen.dart';
import 'package:astrokit/src/Shared/progress_indicator.dart';
import 'package:astrokit/src/Shared/snack_bar.dart';
import 'package:astrokit/src/class/position.dart';
import 'package:astrokit/src/utils/file_manager.dart';
import 'package:astrokit/src/utils/round.dart';
import 'package:astrokit/src/utils/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../.env.dart' as env;

class UserSettings extends StatefulWidget {
  final Map args;

  const UserSettings({required this.args, Key? key}) : super(key: key);

  static const routeName = "/settings";
  static const fileName = "locations";

  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: env.GOOGLE_API);
  late Future<List> _futureLocations;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _futureLocations = widget.args["_futureLocations"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(title: "Endroits", context: context, actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Switch(
            value: Provider.of<ThemeModel>(context).redModeEnabled,
            onChanged: (bool value) {
              setState(() {
                Provider.of<ThemeModel>(context, listen: false).toggleTheme();
              });
            },
            activeTrackColor: Colors.deepPurple[700],
            activeColor: Colors.deepPurple[400],
            activeThumbImage: const AssetImage("assets/images/nmode.png"),
            inactiveTrackColor: Colors.yellow[700],
            inactiveThumbColor: Colors.yellow[700],
            inactiveThumbImage: const AssetImage("assets/images/lmode.png"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: ActionButton(
            icon: Icons.logout_rounded,
            click: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool("isLogged", false);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.routeName, (Route<dynamic> route) => false);
            },
          ),
        ),
      ]),
      body: Builder(builder: (context) {
        return Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () async {
                  PlacesAutocomplete.show(
                    context: context,
                    apiKey: env.GOOGLE_API,
                    mode: Mode.overlay,
                    types: [],
                    radius: 10000000,
                    strictbounds: false,
                    language: "fr",
                    components: [Component(Component.country, "ca")],
                    sessionToken: const Uuid().v4(),
                    onError: onError,
                  ).then((value) => displayPrediction(value));
                },
                child: const Text("Chercher une adresse..."),
              ),
            ),
            FutureBuilder<List>(
              future: _futureLocations,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return locationList(snapshot.data!);
                } else if (snapshot.hasError) {
                  return errorScreen(context, UserSettings.routeName);
                }

                return progressIndicator();
              },
            )
          ],
        );
      }),
    );
  }

  Future<void> displayPrediction(Prediction? p) async {
    if (p?.placeId != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p!.placeId!);

      double lat = detail.result.geometry!.location.lat;
      double lon = detail.result.geometry!.location.lng;

      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        Position selected = Position(
          latitude: roundDouble(lat, 2),
          longitude: roundDouble(lon, 2),
          streetNumber: placemarks[0].subThoroughfare!,
          street: placemarks[0].thoroughfare!,
          postalCode: placemarks[0].postalCode!,
          country: placemarks[0].isoCountryCode!,
          state: placemarks[0].administrativeArea!,
          city: placemarks[0].locality!,
        );
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SafeArea(
              child: FractionallySizedBox(
                heightFactor: 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                          "Voulez vous ajouter cette adresse au compte ?",
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Text(selected.toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          child: const Text("Annuler"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          child: const Text("Confirmer"),
                          onPressed: () async {
                            List locations = await _futureLocations;
                            setState(() {
                              if (!locations.contains(selected)) {
                                locations.add(selected);
                                writeToFile(jsonEncode(locations),
                                    UserSettings.fileName);
                              } else {
                                snackBar(
                                    title: "Adresse d??j?? ajout??e.",
                                    message:
                                        "L'adresse fait d??j?? partie de la liste.");
                              }
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    }
  }

  void onError(PlacesAutocompleteResponse response) {
    snackBar(title: "Erreur", message: response.errorMessage!).show(context);
  }

  Widget locationList(List data) => Flexible(
        child: ListView.builder(
            controller: _scrollController,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int i) {
              if (data.length > 1) {
                data.sort((a, b) {
                  return a.creation.compareTo(b.creation);
                });
              }
              return Dismissible(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.black, width: 1),
                      ),
                      title: Text(data[i].toString()),
                      leading: const Icon(Icons.location_on_outlined)),
                ),
                key: UniqueKey(),
                background: Container(
                  decoration: BoxDecoration(
                      color: Colors.red[900],
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  alignment: AlignmentDirectional.centerEnd,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: const Icon(Icons.delete_outline_rounded,
                      color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  Position? deleted;
                  if (data.length > 1) {
                    setState(() {
                      deleted = data.removeAt(i);
                      writeToFile(jsonEncode(data), UserSettings.fileName);
                    });
                    snackBar(
                      title: "Supprim??.",
                      message: deleted.toString(),
                      action: SnackBarAction(
                        label: "Annuler",
                        onPressed: () => setState(
                          () {
                            data.add(deleted!);
                            writeToFile(
                                jsonEncode(data), UserSettings.fileName);
                          },
                        ),
                      ),
                    ).show(context);
                  } else {
                    snackBar(
                      title: "Erreur.",
                      message:
                          "Il n'est pas possible de supprimer la derni??re adresse.\nAjoutez une autre adresse avant de recommencer.",
                    ).show(context);
                    setState(() {
                      data = data;
                    });
                  }
                },
              );
            }),
      );
}

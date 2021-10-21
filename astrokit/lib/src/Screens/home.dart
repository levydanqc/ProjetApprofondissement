import 'dart:convert';

import 'package:astrokit/src/Screens/user_settings.dart';
import 'package:astrokit/src/Shared/app_bar.dart';
import 'package:astrokit/src/Shared/error_screen.dart';
import 'package:astrokit/src/Shared/list_header.dart';
import 'package:astrokit/src/Shared/day_item.dart';
import 'package:astrokit/src/Shared/progress_indicator.dart';
import 'package:astrokit/src/Shared/snack_bar.dart';
import 'package:astrokit/src/utils/file_manager.dart';
import 'package:astrokit/src/utils/forecast.dart';
import 'package:astrokit/src/utils/position.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  Home(this.lastPage, {Key? key}) : super(key: key);

  String? lastPage;
  static const routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  late Future<Map> data;
  late Future<List> _futureLocations;
  List _locations = [];
  int i = 0;

  // TODO : Add floating Go to top button

  Future<Map> getForecast(Position _location) async {
    return Forecast.loadForecast(_location.latitude, _location.longitude).then(
      (value) => value,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.lastPage == "/login_screen") {
      WidgetsBinding.instance!.addPostFrameCallback((_) =>
          snackBar(title: "Réussi", message: "Connexion réussie...")
              .show(context));
    }
    _futureLocations = getLocations();
    data = getForecast(_locations[i]);
  }

  Future<List> getLocations() async {
    return readFile(UserSettings.fileName).then((locationJson) {
      if (locationJson != "0") {
        List list = jsonDecode(locationJson);
        _locations =
            list.map((location) => Position.fromJson(location)).toList();
        return list;
      } else {
        return [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(
        context: context,
        title: _locations[i].postalCode,
        args: {"_futureLocations": _futureLocations, "_locations": _locations},
      ),
      // TODO: Check internet connection
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            setState(() {
              i = i > 0 ? i - 1 : _locations.length - 1;
            });
          } else if ((details.primaryVelocity! < 0)) {
            setState(() {
              i = i < _locations.length - 1 ? i + 1 : 0;
            });
          }
          setState(() {
            data = getForecast(_locations[i]);
          });
        },
        child: FutureBuilder<Map>(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return listDay(snapshot);
            } else if (snapshot.hasError) {
              return errorScreen(context, Home.routeName);
            }

            // TODO: use flutter_spinkit --> SpinKitChasingDots
            return progressIndicator();
          },
        ),
      ),
    );
  }

  ListView listDay(snapshot) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: snapshot.data!["data"].length,
      itemBuilder: (BuildContext context, int index) {
        // Logic for displaying the right element at the right
        // place in the list
        if (index == 0) {
          return const ListHeader("Tonight");
        } else if (index == 2) {
          return const ListHeader("Next 16 days");
        } else if (index == 1) {
          index = 0;
        } else {
          index -= 2;
        }

        return DayItem(
          day: snapshot.data!["data"][index],
          postalCode: _locations[i].postalCode,
        );
      },
    );
  }
}

import 'dart:convert';

import 'package:astrokit/src/Screens/user_settings.dart';
import 'package:astrokit/src/Shared/action_button.dart';
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
// TODO : Add floating Go to top button

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  int indice = 0;
  late Future<Map> _futureData;
  late Future<List> _futureLocations;

  @override
  void initState() {
    if (widget.lastPage == "/login_screen") {
      WidgetsBinding.instance!.addPostFrameCallback((_) =>
          snackBar(title: "Réussi", message: "Connexion réussie...")
              .show(context));
    }
    _futureLocations = getLocations();
    _futureData = getForecast();
    super.initState();
  }

  Future<Map> getForecast() async {
    List location = await _futureLocations;
    return Forecast.loadForecast(
            location[indice].latitude, location[indice].longitude)
        .then(
      (value) => value,
    );
  }

  Future<List> getLocations() async {
    return readFile(UserSettings.fileName).then((stringJson) {
      if (stringJson != "0") {
        List list = jsonDecode(stringJson)
            .map((location) => Position.fromJson(location))
            .toList();
        return list;
      }
      return [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([_futureLocations, _futureData]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List? data = snapshot.data as List?;
            return Scaffold(
              appBar: header(
                context: context,
                title: data![0].isNotEmpty
                    ? data[0][indice].postalCode
                    : "AstroKit",
                leading: ActionButton(
                    icon: Icons.manage_accounts_outlined,
                    click: () {
                      Navigator.pushNamed(context, UserSettings.routeName,
                          arguments: {"_futureLocations": _futureLocations});
                    }),
              ),
              // TODO: Check internet connection
              body: GestureDetector(
                onHorizontalDragEnd: (details) async {
                  if (details.primaryVelocity! > 0) {
                    setState(() {
                      indice = indice > 0 ? indice - 1 : data[0].length - 1;
                    });
                  } else if ((details.primaryVelocity! < 0)) {
                    setState(() {
                      indice = indice < data[0].length - 1 ? indice + 1 : 0;
                    });
                  }
                  setState(() {
                    _futureData = getForecast();
                  });
                },
                child: listDay(data),
              ),
            );
          } else if (snapshot.hasError) {
            return errorScreen(context, Home.routeName);
          }
          return progressIndicator();
        });
  }

  ListView listDay(snapshot) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: snapshot[1]["data"].length,
      itemBuilder: (BuildContext context, int index) {
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
          day: snapshot[1]["data"][index],
          postalCode: snapshot[0][indice].postalCode,
        );
      },
    );
  }
}

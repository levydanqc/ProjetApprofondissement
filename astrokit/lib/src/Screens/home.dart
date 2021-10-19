import 'package:astrokit/src/Shared/app_bar.dart';
import 'package:astrokit/src/Shared/error_screen.dart';
import 'package:astrokit/src/Shared/list_header.dart';
import 'package:astrokit/src/Shared/day_item.dart';
import 'package:astrokit/src/utils/forecast.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

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

  // TODO : Add floating Go to top button

  Future<Map> getForecast() async {
    return Forecast.loadForecast(46.81, -71.23).then((value) => value);
  }

  @override
  void initState() {
    super.initState();
    if (widget.lastPage == "/login_screen") {
      WidgetsBinding.instance!
          .addPostFrameCallback((_) => snackBar.show(context));
    }
    data = getForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context: context),
      // TODO: Check internet connection
      body: FutureBuilder<Map>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listDay(snapshot);
          } else if (snapshot.hasError) {
            return errorScreen();
          }

          // TODO: use flutter_spinkit --> SpinKitChasingDots
          return const Center(child: CircularProgressIndicator());
        },
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
        );
      },
    );
  }

  Flushbar snackBar = Flushbar(
    title: "Réussi",
    message: "Connexion réussie",
    duration: const Duration(seconds: 3),
  );
}

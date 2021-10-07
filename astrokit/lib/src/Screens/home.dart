import 'package:astrokit/src/Shared/action_button.dart';
import 'package:astrokit/src/Shared/list_header.dart';
import 'package:astrokit/src/Shared/list_item.dart';
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
  Map? data;

  @override
  Future<void> initState() async {
    super.initState();
    if (widget.lastPage == "/login_screen") {
      WidgetsBinding.instance!
          .addPostFrameCallback((_) => snackBar.show(context));
    }
    data = await Forecast.loadForecast(10, 10);

    if (data == null) {
      // TODO: Go to error page
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Scaffold()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("AstroKit")),
        leading:
            ActionButton(icon: Icons.manage_accounts_outlined, click: () {}),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: ActionButton(icon: Icons.search, click: () {}),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child:
                ActionButton(icon: Icons.help_outline_outlined, click: () {}),
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: data!["daily"].length,
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

          String date = data!["daily"][index]["valid_date"];
          List hourly = data!["hourly"]
              .where((x) => x["timestamp_local"].split("T")[0] == date)
              .toList();
          return ListItemDay(
            strDate: date,
            temp: data!["daily"][index]["temp"].toString(),
            day: data!["daily"][index],
            hourly: hourly,
            city: data!["city_name"],
          );
        },
      ),
    );
  }

  Flushbar snackBar = Flushbar(
    title: "Réussi",
    message: "Connexion réussie",
    duration: const Duration(seconds: 3),
  );
}

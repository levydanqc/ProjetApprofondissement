import 'dart:math';

import 'package:astrokit/src/Screens/list_astres.dart';
import 'package:astrokit/src/Shared/action_button.dart';
import 'package:astrokit/src/utils/capitalize.dart';
import 'package:intl/intl.dart';
import 'package:astrokit/src/Shared/app_bar.dart';
import 'package:flutter/material.dart';

class DayDetail extends StatelessWidget {
  static const routeName = '/daydetail';
  final Map dayData;

  const DayDetail({required this.dayData, Key? key}) : super(key: key);

  double roundDouble(dynamic value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(
          title: dayData["postalCode"],
          context: context,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                  icon: Image.asset("assets/images/astres/icon.png",
                      width: 25, height: 25),
                  onPressed: () {
                    Navigator.pushNamed(context, ListAstres.routeName);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child:
                  ActionButton(icon: Icons.help_outline_outlined, click: () {}),
            ),
          ]),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              DateFormat('EEEE')
                  .format(DateTime.parse(dayData["valid_date"]))
                  .capitalize(),
              style: const TextStyle(fontSize: 40, color: Colors.black),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              DateFormat('yMd')
                  .format(DateTime.parse(dayData["valid_date"]))
                  .capitalize(),
              style: const TextStyle(fontSize: 25, color: Colors.black),
            ),
          ),
          Flexible(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              children: List.generate(
                dayData.length,
                (i) => Column(
                  children: [
                    Text(
                      dayData.keys.elementAt(i),
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                    ),
                    Text(dayData.values.elementAt(i).toString())
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

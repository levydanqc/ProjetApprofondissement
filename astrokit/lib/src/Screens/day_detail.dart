import 'dart:math';

import 'package:astrokit/src/Screens/list_astres.dart';
import 'package:astrokit/src/Shared/action_button.dart';
import 'package:astrokit/src/Shared/app_bar.dart';
import 'package:astrokit/src/utils/capitalize.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          title: DateFormat('EEEE')
              .format(DateTime.parse(dayData["valid_date"]))
              .capitalize(),
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
          Container(
            child: Text(
              DateFormat('d/M/y')
                  .format(DateTime.parse(dayData["valid_date"]))
                  .capitalize(),
              style: Theme.of(context).textTheme.headline2,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            alignment: Alignment.centerLeft,
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: ListView.builder(
                itemCount: dayData.length,
                itemBuilder: (context, i) {
                  if (!["weather", "postalCode"]
                      .contains(dayData.keys.elementAt(i))) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              dayData.keys.elementAt(i),
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            const Spacer(),
                            Text(
                              dayData.values.elementAt(i).toString(),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                          height: 10,
                          thickness: 1,
                        )
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:math';

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
      appBar: header(withLeading: false, context: context),
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
              childAspectRatio: 0.6,
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

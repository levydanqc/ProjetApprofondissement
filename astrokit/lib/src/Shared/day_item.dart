import 'package:astrokit/src/Screens/day_detail.dart';
import 'package:astrokit/src/utils/capitalize.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DayItem extends StatelessWidget {
  final Map day;
  final String postalCode;

  const DayItem({
    Key? key,
    required this.postalCode,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(day["valid_date"]);
    day["postalCode"] = postalCode;
    Intl.defaultLocale = "fr_CA";
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.wb_sunny_outlined, size: 50),
        onPressed: () {
          Navigator.pushNamed(context, DayDetail.routeName, arguments: day);
        },
        label: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Text(DateFormat("EEEE").format(date).capitalize(),
                      style: Theme.of(context).textTheme.headline5),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('d MMM').format(date),
                          style: Theme.of(context).textTheme.headline3),
                      Text(
                        "${day["temp"].toString()} °C",
                        style: Theme.of(context).textTheme.headline6,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_right,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}

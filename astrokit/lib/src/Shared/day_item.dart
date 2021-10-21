import 'package:astrokit/src/Screens/day_detail.dart';
import 'package:astrokit/src/utils/capitalize.dart';
import 'package:flutter/cupertino.dart';
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
    // Intl.defaultLocale = "en_CA";
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(1),
            blurRadius: 7,
            offset: const Offset(3, 8),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF241771),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
          onPressed: () {
            Navigator.pushNamed(context, DayDetail.routeName, arguments: day);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Text(
                      DateFormat("EEEE").format(date).capitalize(),
                      style: TextStyle(color: Colors.grey[100], fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(Icons.wb_sunny_outlined, size: 50),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('d MMM').format(date),
                              style: TextStyle(
                                  color: Colors.grey[100], fontSize: 30),
                            ),
                            Text(
                              "${day["temp"].toString()} °C",
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 20),
                            )
                          ],
                        ),
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
      ),
    );
  }
}

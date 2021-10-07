import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ListItemDay extends StatelessWidget {
  late String dayOfWeek;
  final String strDate;
  late DateTime date;
  final String temp;
  final Map day;
  final List hourly;
  final String city;

  ListItemDay({
    Key? key,
    required this.strDate,
    required this.temp,
    required this.day,
    required this.hourly,
    required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    date = DateTime.parse(strDate);
    dayOfWeek = DateFormat('E').format(date);

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
            primary: Color(0xFF241771),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/detail", arguments: {
              "day": day,
              "hourly": hourly,
              "city": city,
              "withHour": hourly.isNotEmpty,
            });
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
                      DateFormat("EEEE").format(date),
                      style: TextStyle(color: Colors.grey[100], fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(CupertinoIcons.cloud_sun, size: 50),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${date.day} ${DateFormat('MMM').format(date)}",
                              style: TextStyle(
                                  color: Colors.grey[100], fontSize: 30),
                            ),
                            Text(
                              "temp °C",
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

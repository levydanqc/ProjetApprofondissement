import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: const Color(0xff1f655d),
  textTheme: const TextTheme(
    headline1: TextStyle(color: Color(0xff40bf7a)),
    headline2: TextStyle(color: Colors.white),
    headline3: TextStyle(color: Color(0xff40bf7a)),
  ),
  appBarTheme: const AppBarTheme(color: Color(0xff1A1A1A)),
);

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: const Color(0xff1f655d),
  textTheme: const TextTheme(
    headline1: TextStyle(color: Color(0xff40bf7a)),
    headline2: TextStyle(color: Colors.white),
    headline3: TextStyle(color: Color(0xff40bf7a)),
  ),
  appBarTheme: const AppBarTheme(color: Color(0xff00279A)),
);

ThemeData redTheme = ThemeData.dark().copyWith(
  primaryColor: const Color(0xff9C1A1A),
  textTheme: const TextTheme(
    headline1: TextStyle(color: Color(0xff40bf7a)),
    headline2: TextStyle(color: Colors.white),
    headline3: TextStyle(color: Color(0xff40bf7a)),
  ),
  appBarTheme: const AppBarTheme(color: Color(0xff9C1A1A)),
);

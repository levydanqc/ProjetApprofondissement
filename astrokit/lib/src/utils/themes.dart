import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color black = Color(0xff232323);
const Color white = Color(0xFFFffAFA);
const Color blue = Color(0xffA1BCFF);
const Color dBlue = Color(0xff171B57);
const Color lBg = Color(0xffFFFAF0);
const Color dBg = Color(0xff1C209C);
const Color rBg = Color(0xffFFFAF0);

ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  primaryColor: dBg,
  secondaryHeaderColor: dBlue,
  scaffoldBackgroundColor: dBg,
  textTheme: TextTheme(
    headline1: GoogleFonts.robotoMono()
        .copyWith(color: white, fontSize: 25, fontWeight: FontWeight.bold),
    headline2: GoogleFonts.robotoMono()
        .copyWith(color: white, fontSize: 20, fontWeight: FontWeight.bold),
    headline3: GoogleFonts.robotoMono()
        .copyWith(color: white, fontSize: 15, fontWeight: FontWeight.bold),
    headline4: GoogleFonts.robotoMono().copyWith(color: black, fontSize: 20),
    headline5: GoogleFonts.robotoMono().copyWith(color: white, fontSize: 20),
    headline6: GoogleFonts.robotoMono().copyWith(color: white, fontSize: 13),
    bodyText1: GoogleFonts.robotoMono().copyWith(color: white, fontSize: 15),
    bodyText2: GoogleFonts.robotoMono().copyWith(color: black, fontSize: 15),
  ),
  appBarTheme: const AppBarTheme(
      color: dBlue,
      titleTextStyle: TextStyle(color: dBg),
      shadowColor: Colors.black,
      elevation: 5),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: const Color(0xffE8D6BB),
      onPrimary: white,
      textStyle: GoogleFonts.robotoMono().copyWith(color: white),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      splashFactory: InkRipple.splashFactory,
      enableFeedback: true,
      shadowColor: Colors.black,
      elevation: 10,
      side: const BorderSide(color: Colors.black, width: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: dBg,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: dBlue,
    contentTextStyle: GoogleFonts.robotoMono(),
  ),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    enableFeedback: true,
    textColor: white,
  ),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: lBg,
  secondaryHeaderColor: blue,
  scaffoldBackgroundColor: lBg,
  textTheme: TextTheme(
    headline1: GoogleFonts.robotoMono()
        .copyWith(color: white, fontSize: 25, fontWeight: FontWeight.bold),
    headline2: GoogleFonts.robotoMono()
        .copyWith(color: black, fontSize: 20, fontWeight: FontWeight.bold),
    headline3: GoogleFonts.robotoMono()
        .copyWith(color: black, fontSize: 15, fontWeight: FontWeight.bold),
    headline4: GoogleFonts.robotoMono().copyWith(color: white, fontSize: 20),
    headline5: GoogleFonts.robotoMono().copyWith(color: black, fontSize: 20),
    headline6: GoogleFonts.robotoMono().copyWith(color: black, fontSize: 13),
    bodyText1: GoogleFonts.robotoMono().copyWith(color: black, fontSize: 15),
    bodyText2: GoogleFonts.robotoMono().copyWith(color: white, fontSize: 15),
  ),
  appBarTheme: const AppBarTheme(
      color: blue,
      titleTextStyle: TextStyle(color: lBg),
      shadowColor: Colors.white,
      elevation: 5),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: const Color(0xffE8D6BB),
      onPrimary: black,
      textStyle: GoogleFonts.robotoMono().copyWith(color: black),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      splashFactory: InkRipple.splashFactory,
      enableFeedback: true,
      shadowColor: Colors.white,
      elevation: 10,
      side: const BorderSide(color: Colors.white, width: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: lBg,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: blue,
    contentTextStyle: GoogleFonts.robotoMono(),
  ),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    enableFeedback: true,
    textColor: white,
  ),
);

ThemeData redTheme = ThemeData.dark().copyWith(
  applyElevationOverlayColor: true,
  brightness: Brightness.light,
  primaryColor: rBg,
  secondaryHeaderColor: blue,
  scaffoldBackgroundColor: rBg,
  textTheme: TextTheme(
    headline1: GoogleFonts.robotoMono()
        .copyWith(color: white, fontSize: 25, fontWeight: FontWeight.bold),
    headline2: GoogleFonts.robotoMono()
        .copyWith(color: black, fontSize: 20, fontWeight: FontWeight.bold),
    headline3: GoogleFonts.robotoMono()
        .copyWith(color: black, fontSize: 15, fontWeight: FontWeight.bold),
    headline4: GoogleFonts.robotoMono().copyWith(color: white, fontSize: 20),
    headline5: GoogleFonts.robotoMono().copyWith(color: black, fontSize: 20),
    headline6: GoogleFonts.robotoMono().copyWith(color: black, fontSize: 13),
    bodyText1: GoogleFonts.robotoMono().copyWith(color: black, fontSize: 15),
    bodyText2: GoogleFonts.robotoMono().copyWith(color: white, fontSize: 15),
  ),
  appBarTheme: const AppBarTheme(
      color: blue,
      titleTextStyle: TextStyle(color: rBg),
      shadowColor: Colors.white,
      elevation: 5),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: const Color(0xffE8D6BB),
      onPrimary: black,
      textStyle: GoogleFonts.robotoMono().copyWith(color: black),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      splashFactory: InkRipple.splashFactory,
      enableFeedback: true,
      shadowColor: Colors.white,
      elevation: 10,
      side: const BorderSide(color: Colors.white, width: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: rBg,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: blue,
    contentTextStyle: GoogleFonts.robotoMono(),
  ),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    enableFeedback: true,
    textColor: white,
  ),
);

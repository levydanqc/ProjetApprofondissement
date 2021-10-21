import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Flushbar snackBar(
        {required String title, required String message, Widget? action}) =>
    Flushbar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      mainButton: action,
    );

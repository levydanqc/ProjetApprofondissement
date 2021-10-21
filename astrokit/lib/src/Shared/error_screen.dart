import 'package:astrokit/src/Screens/home.dart';
import 'package:flutter/material.dart';

Widget errorScreen(BuildContext context, String routeName) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Center(
        child: Text(
          "Il y a eu une erreur lors de l'obtention des données...",
        ),
      ),
      ElevatedButton(
        onPressed: () => Navigator.popAndPushNamed(context, routeName),
        child: const Text("Rafraichir..."),
      ),
    ],
  );
}

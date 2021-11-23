import 'package:flutter/material.dart';
import 'package:astrokit/src/Shared/app_bar.dart';

Widget errorScreen(BuildContext context, String routeName) {
  return Scaffold(
      appBar: header(context: context, title: "Astrokit"),
      body: Column(
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
      ),
    );
}

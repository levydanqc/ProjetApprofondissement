import 'package:astrokit/src/Screens/list_astres.dart';
import 'package:astrokit/src/Shared/action_button.dart';
import 'package:flutter/material.dart';
import 'package:astrokit/src/Shared/app_bar.dart';

Widget errorScreen(BuildContext context, String routeName) {
  return Scaffold(
    appBar: header(
      context: context,
      title: const Text("Astrokit"),
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
          child: ActionButton(icon: Icons.help_outline_outlined, click: () {}),
        ),
      ],
    ),
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

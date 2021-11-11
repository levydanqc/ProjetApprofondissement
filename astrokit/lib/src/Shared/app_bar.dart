import 'package:astrokit/src/Screens/list_astres.dart';
import 'package:astrokit/src/Shared/action_button.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget header({
  required context,
  required title,
  Widget? leading,
}) {
  return AppBar(
    title: Center(
      child: Text(title),
    ),
    leading: leading,
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
  );
}

import 'package:astrokit/src/Screens/user_settings.dart';
import 'package:astrokit/src/Shared/action_button.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget header({
  required context,
  bool withLeading = true,
  Object? args,
}) {
  return AppBar(
    title: const Center(child: Text("AstroKit")),
    leading: withLeading
        ? ActionButton(
            icon: Icons.manage_accounts_outlined,
            click: () {
              Navigator.pushNamed(context, UserSettings.routeName,
                  arguments: args);
            })
        : null,
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: ActionButton(icon: Icons.search, click: () {}),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: ActionButton(icon: Icons.help_outline_outlined, click: () {}),
      ),
    ],
  );
}

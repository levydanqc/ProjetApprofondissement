import 'package:astrokit/src/utils/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

PreferredSizeWidget header({
  required context,
  required title,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    title: GestureDetector(
      onDoubleTap: () {
        Provider.of<ThemeModel>(context, listen: false).toggleTheme();
      },
      child: title is String
          ? FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(title, style: Theme.of(context).textTheme.headline1))
          : title,
    ),
    leading: leading,
    actions: actions,
  );
}

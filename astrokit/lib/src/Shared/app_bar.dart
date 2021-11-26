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
      child: title,
    ),
    leading: leading,
    actions: actions,
  );
}

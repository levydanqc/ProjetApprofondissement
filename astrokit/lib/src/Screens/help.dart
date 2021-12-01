import 'package:astrokit/src/Shared/app_bar.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);
  static const routeName = "/help";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(
        context: context,
        title: Text(
          "Aide",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: const Center(
        child: Text("Video d'aide"),
      ),
    );
  }
}

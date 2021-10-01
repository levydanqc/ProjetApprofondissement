import 'package:astrokit/src/Shared/action_button.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  Home(this.lastPage, {Key? key}) : super(key: key);

  String? lastPage;
  static const routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    if (widget.lastPage == "/login_screen") {
      WidgetsBinding.instance!.addPostFrameCallback((_) => Flushbar(
            title: "Réussi",
            message: "Connexion réussie",
            duration: const Duration(seconds: 2),
          ).show(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBar(
        title: const Center(child: Text("AstroKit")),
        leading: const ActionButton(icon: Icons.manage_accounts_outlined),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: ActionButton(icon: Icons.search),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: ActionButton(icon: Icons.help_outline_outlined),
          ),
        ],
      ),
    );
  }
}

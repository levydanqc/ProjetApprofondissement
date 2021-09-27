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
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(Icons.manage_accounts_outlined),
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(Icons.search, size: 26.0),
              )),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {},
              hoverColor: Colors.white,
              splashColor: Colors.white,
              splashRadius: 20,
              icon: const Icon(Icons.help_outline_outlined),
            ),
          ),
          // child: GestureDetector(
          //   onTap: () {},
          //   child: const Icon(Icons.help_outline_outlined),
          // )),
        ],
      ),
    );
  }
}

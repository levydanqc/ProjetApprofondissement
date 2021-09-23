import 'package:flutter/material.dart';
import '../const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _pwdError = "";
  String _emailError = "";

  Color? labelColor = Colors.black;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
              ),
            ),
          ),
          Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Image.asset('assets/images/logo.png'),
                ),
                Wrap(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextErreur(erreur: "Erreur de email"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          labelStyle: TextStyle(
                            color: brown,
                          ),
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon:
                              Icon(Icons.email_outlined, color: Colors.black),
                        ),
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                        controller: _emailController,
                      ),
                    ),
                  ],
                ),
                Wrap(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextErreur(erreur: "Erreur de password"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          labelStyle: TextStyle(
                            color: brown,
                          ),
                          border: OutlineInputBorder(),
                          labelText: "Mot de passe",
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.password_outlined,
                              color: Colors.black),
                        ),
                        onEditingComplete: () =>
                            FocusScope.of(context).unfocus(),
                        controller: _passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.grey[300],
                          ),
                          onPressed: () {},
                          child: const Text("Mot de passe oublié ?"),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.login_outlined),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: brown,
                      elevation: 10,
                      side: const BorderSide(
                        color: Colors.white,
                        width: 1.5,
                      ),
                    ),
                    onPressed: () {
                      print(_passwordController.text);
                      print(_emailController.text);
                    },
                    label: const Text("Se connecter"),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {},
                    child: const Text("Pas encore de compte ? Sign up"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class TextErreur extends StatelessWidget {
  const TextErreur({required String erreur, Key? key})
      : _erreur = erreur,
        super(key: key);

  final String _erreur;

  @override
  Widget build(BuildContext context) {
    return Text(_erreur, style: const TextStyle(color: Colors.red));
  }
}

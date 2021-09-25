import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../const.dart' as env;
import 'package:crypto/crypto.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Duration get loginTime => const Duration(milliseconds: 200);

  static const users = {
    'danlevy.ca@icloud.com': 'Test',
  };

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _hashPwd(LoginData loginData) {
    List<int> bytes = utf8.encode(loginData.password);
    Digest digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<String?>? _signup(LoginData loginData) {
    return Future.delayed(loginTime).then((_) {
      print("SignUp");
      return "SignUp";
    });
  }

  Future<String?>? _login(LoginData loginData) {
    return Future.delayed(loginTime).then((_) {
      print(_hashPwd(loginData));
      return null;
    });
  }

  String? _validateUser(String? email) {
    if (email == "") {
      return "L'adresse email ne peut être vide.";
    }
    if (!RegExp(r"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$")
        .hasMatch(email!)) {
      return "L'adresse email n'est pas valide.";
    }
    return null;
  }

  String? _validatePwd(String? pwd) {
    if (pwd == "") {
      return "Le mot de passe ne peut être vide.";
    }
    return null;
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return "L'adresse mail n'est pas inscrite.";
      }
      return "null";
    });
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Image.asset("assets/images/logo.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: FlutterLogin(
              messages: loginMessages,
              theme: LoginTheme(
                switchAuthTextColor: Colors.white,
                authButtonPadding: const EdgeInsets.symmetric(vertical: 50),
                pageColorDark: Colors.transparent,
                pageColorLight: Colors.transparent,
                primaryColor: env.brown,
                accentColor: Colors.transparent,
                buttonStyle: const TextStyle(fontSize: 15),
                buttonTheme: const LoginButtonTheme(
                  elevation: 10,
                  splashColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                cardTheme: const CardTheme(
                  color: Colors.transparent,
                  elevation: 0,
                ),
                inputTheme: const InputDecorationTheme(
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: env.brown),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                bodyStyle: const TextStyle(
                  color: Colors.black,
                ),
              ),
              onLogin: _login,
              userValidator: _validateUser,
              passwordValidator: _validatePwd,
              onSignup: _signup,
              onSubmitAnimationCompleted: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
              },
              onRecoverPassword: _recoverPassword,
            ),
          )
        ],
      ),
    );
  }
}

LoginMessages loginMessages = LoginMessages(
    userHint: "Email",
    passwordHint: "Mot de passe",
    loginButton: "Se connecter",
    signUpSuccess: "Un lien d'inscription à été envoyé",
    confirmPasswordHint: "Confirmation",
    signupButton: "S'inscrire",
    recoverPasswordSuccess: "Un email à été envoyée",
    forgotPasswordButton: "Mot de passe oublié ?",
    recoverPasswordIntro: "Réinitialiser le mot de passe",
    recoverPasswordDescription:
        "Vous recevrez un lien par email pour réinitialiser votre mot de passe",
    recoverPasswordButton: "Réinitialiser",
    goBackButton: "Retour",
    flushbarTitleSuccess: "Réussi",
    flushbarTitleError: "Erreur");

import 'package:astrokit/src/Screens/home.dart';
import 'package:astrokit/src/class/astres.dart';
import 'package:astrokit/src/utils/location.dart';
import 'package:astrokit/src/utils/user_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../const.dart' as env;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
    _firstRun().then((value) {
      if (value) {
        Astre.loadAstres();
      }
    });
    _isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, Home.routeName);
      }
    });
  }

  Future<bool> _isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<bool> _firstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool("first_run") ?? true;
    if (value) {
      prefs.setBool("first_run", false);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage("assets/images/background.png"),
              ),
            ),
          ),
          SafeArea(
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Image.asset("assets/images/logo.png"),
            ),
          ),
          FlutterLogin(
            messages: loginMessages,
            logo: null,
            theme: LoginTheme(
              errorColor: Colors.redAccent.shade400,
              switchAuthTextColor: Colors.black,
              authButtonPadding: const EdgeInsets.symmetric(vertical: 10),
              pageColorDark: Colors.transparent,
              pageColorLight: Colors.transparent,
              primaryColor: env.brown,
              accentColor: Colors.transparent,
              buttonStyle: const TextStyle(fontSize: 17),
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
                margin: EdgeInsets.only(top: 30),
              ),
              textFieldStyle: const TextStyle(color: Colors.white),
              inputTheme: const InputDecorationTheme(
                labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                fillColor: Colors.white,
                filled: false,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: env.brown),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              bodyStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
            onLogin: login,
            userValidator: validateUser,
            passwordValidator: validatePwd,
            onSignup: signup,
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Home(LoginScreen.routeName),
              ));
            },
            onRecoverPassword: recoverPassword,
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
  confirmPasswordError: "Les mots de passe ne correspondent pas.",
  signupButton: "S'inscrire",
  recoverPasswordSuccess: "Un email à été envoyée",
  forgotPasswordButton: "Mot de passe oublié ?",
  recoverPasswordIntro: "Réinitialiser le mot de passe",
  recoverPasswordDescription:
      "Vous recevrez un lien par email pour réinitialiser votre mot de passe",
  recoverPasswordButton: "Réinitialiser",
  goBackButton: "Retour",
  flushbarTitleSuccess: "Réussi",
  flushbarTitleError: "Erreur",
);

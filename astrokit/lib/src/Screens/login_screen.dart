import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../const.dart' as env;

import '../Shared/user_validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Image.asset("assets/images/logo.png"),
          ),
          FlutterLogin(
            
            messages: loginMessages,
            theme: LoginTheme(
              errorColor: Colors.redAccent.shade400,
              switchAuthTextColor: Colors.white,
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
                margin: EdgeInsets.only(top: 50),
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
            onLogin: Validation.login,
            userValidator: Validation.validateUser,
            passwordValidator: Validation.validatePwd,
            onSignup: Validation.signup,
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ));
            },
            onRecoverPassword: Validation.recoverPassword,
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

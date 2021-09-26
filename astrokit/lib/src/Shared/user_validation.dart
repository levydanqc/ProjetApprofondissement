import 'package:flutter_login/flutter_login.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Validation {
  static Duration get loginTime => const Duration(milliseconds: 200);

  static const users = {
    'danlevy.ca@icloud.com':
        'e7cf3ef4f17c3999a94f2c6f612e8a888e5b1026878e4e19398b23bd38ec221a',
  };

  static String hashPwd(LoginData loginData) {
    List<int> bytes = utf8.encode(loginData.password);
    Digest digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<String?>? signup(LoginData loginData) {
    return Future.delayed(loginTime).then((_) {
      return "SignUp";
    });
  }

  static bool verifyPassword(LoginData loginData, String pwd) {
    return users[loginData.name] == pwd;
  }

  static Future<String?>? login(LoginData loginData) {
    return Future.delayed(loginTime).then((_) {
      String pwd = hashPwd(loginData);
      bool hasMatch = verifyPassword(loginData, pwd);
      if (hasMatch) {
        return null;
      }
      return "L'adresse mail et le mot de passe ne correspondent pas.";
    });
  }

  static String? validateUser(String? email) {
    if (email == "") {
      return "L'adresse email ne peut être vide.";
    }
    if (!RegExp(r"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$")
        .hasMatch(email!)) {
      return "L'adresse email n'est pas valide.";
    }
    if (!users.containsKey(email)) {
      return "Aucun compte n'est relié à cet email.";
    }
    return null;
  }

  static String? validatePwd(String? pwd) {
    if (pwd == "") {
      return "Le mot de passe ne peut être vide.";
    }
    if (pwd!.length < 4) {
      return "Le mot de passe doit contenir\nau minimum 4 caractères.";
    }
    if (RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
        .hasMatch(pwd)) {
      return "Le mot de passe doit contenir :\n- Une majuscule\n- Une minuscule\n- Un chiffre\n- Un caractère spécial\n- Au minimum 8 caractères";
    }

    return null;
  }

  static Future<String?>? recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return "Aucun compte n'est relié à cet email.";
      }
      return null;
    });
  }
}

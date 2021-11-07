import 'package:flutter_login/flutter_login.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../class/credentials_manager.dart';

Duration get loginTime => const Duration(milliseconds: 200);

String hashPwd(String pwd) {
  List<int> bytes = utf8.encode(pwd);
  Digest digest = sha256.convert(bytes);
  return digest.toString();
}

Future<String?>? signup(LoginData loginData) {
  return Future.delayed(loginTime).then((_) {
    File.read(loginData.name).then((value) {
      if (value != null) {
        return "Un compte est déjà relié à cet email.";
      }
    });

    String pwd = hashPwd(loginData.password);
    File.write(loginData.name, pwd);

    return null;
  });
}

Future<String?>? login(LoginData loginData) {
  return File.read(loginData.name).then((value) {
    if (value == null) {
      return "Aucun compte n'est relié à cet email.";
    }
    String pwd = hashPwd(loginData.password);
    if (value != pwd) {
      return "L'adresse mail et le mot de passe ne correspondent pas.";
    }

    return null;
  });
}

String? validateUser(String? email) {
  if (email == "") {
    return "L'adresse email ne peut être vide.";
  }
  if (!RegExp(r"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$")
      .hasMatch(email!)) {
    return "L'adresse email n'est pas valide.";
  }

  return null;
}

String? validatePwd(String? pwd) {
  if (pwd == "") {
    return "Le mot de passe ne peut être vide.";
  }
  if (pwd!.length < 4) {
    return "Le mot de passe doit contenir au\nminimum 4 caractères.";
  }
  if (!RegExp(r"(?=.*?[A-Z])").hasMatch(pwd)) {
    return "Le mot de passe doit contenir :\n-Une majuscule";
  }
  if (!RegExp(r"(?=.*?[a-z])").hasMatch(pwd)) {
    return "Le mot de passe doit contenir :\n-Une minuscule";
  }
  if (!RegExp(r"(?=.*?[0-9])").hasMatch(pwd)) {
    return "Le mot de passe doit contenir :\n-Un chiffre";
  }
  if (!RegExp(r"(?=.*?[!@#\$&*~])").hasMatch(pwd)) {
    return "Le mot de passe doit contenir :\n- Un caractère spécial";
  }

  return null;
}

Future<String?>? recoverPassword(String name) {
  return File.read(name).then((value) {
    if (value == null) {
      return "Aucun compte n'est relié à cet email.";
    }
    return null;
  });
}

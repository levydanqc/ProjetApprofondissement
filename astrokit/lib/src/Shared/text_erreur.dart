import 'package:flutter/material.dart';

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

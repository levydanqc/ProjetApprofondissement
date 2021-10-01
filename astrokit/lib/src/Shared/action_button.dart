import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.icon,
    Key? key,
  }) : super(key: key);

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      hoverColor: Colors.white,
      splashColor: Colors.white,
      splashRadius: 20,
      icon: Icon(icon),
    );
  }
}

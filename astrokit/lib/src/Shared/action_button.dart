import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.icon,
    required this.click,
    Key? key,
  }) : super(key: key);

  final IconData? icon;
  final VoidCallback click;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      hoverColor: Colors.white,
      splashColor: Colors.white,
      splashRadius: 20,
      icon: Icon(icon),
      onPressed: click,
    );
  }
}

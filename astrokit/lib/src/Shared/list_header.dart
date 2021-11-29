import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  final String title;

  const ListHeader(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
      child: Text(title, style: Theme.of(context).textTheme.headline2),
    );
  }
}

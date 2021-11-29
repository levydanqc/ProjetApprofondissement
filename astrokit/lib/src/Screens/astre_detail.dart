import 'package:astrokit/src/Shared/app_bar.dart';
import 'package:astrokit/src/utils/capitalize.dart';
import 'package:flutter/material.dart';

class AstreDetail extends StatefulWidget {
  final Map astre;

  const AstreDetail({Key? key, required this.astre}) : super(key: key);

  static const String routeName = '/astredetail';

  @override
  _AstreDetailState createState() => _AstreDetailState();
}

class _AstreDetailState extends State<AstreDetail> {
  final Map _astreDetail = {};

  @override
  Widget build(BuildContext context) {
    widget.astre.forEach((key, value) {
      if (!["nom", "description", "category", "hasRing", "fav"].contains(key)) {
        _astreDetail[key.toString().capitalize()] =
            value.toString().capitalize();
      }
    });

    return Scaffold(
      appBar: header(
        context: context,
        title: widget.astre['nom'],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Hero(
            tag: widget.astre['nom'],
            child: Container(
              child: Image.asset('assets/images/astres/moon.jpg', height: 250),
              decoration: const BoxDecoration(color: Colors.black),
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            ),
          ),
          ListView.builder(
            itemCount: _astreDetail.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: index % 2 == 0
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).secondaryHeaderColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_astreDetail.keys.elementAt(index),
                          style: Theme.of(context).textTheme.headline3),
                      Text(_astreDetail.values.elementAt(index),
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Text(
              widget.astre['description'].join('\n'),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 50),
              alignment: Alignment.bottomRight,
              child: Text(
                widget.astre['categorie'] == "satellite"
                    ? "* La distance est relative au corps central du satellite."
                    : "",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          )
        ],
      ),
    );
  }
}

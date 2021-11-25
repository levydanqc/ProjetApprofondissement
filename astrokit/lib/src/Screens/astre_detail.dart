import 'package:astrokit/src/Shared/app_bar.dart';
import 'package:astrokit/src/class/astres.dart';
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
  Map _astreDetail = {};

  @override
  Widget build(BuildContext context) {
    widget.astre.forEach((key, value) {
      if (!["nom", "description", "category", "hasRing", "fav"].contains(key)) {
        _astreDetail[key.toString().capitalize()] =
            value.toString().capitalize();
      }
    });

    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
      appBar: header(
        context: context,
        title: Text(widget.astre['nom']),
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
                      ? Colors.deepPurple[900]
                      : Colors.deepPurple[300],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _astreDetail.keys.elementAt(index),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        _astreDetail.values.elementAt(index),
                        style: const TextStyle(color: Colors.white),
                      ),
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
              style: const TextStyle(color: Colors.white),
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
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

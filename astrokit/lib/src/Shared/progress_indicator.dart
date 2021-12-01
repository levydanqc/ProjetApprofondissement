import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget progressIndicator() => const Center(child: SpinKitChasingDots(
            color: Colors.white,
            size: 100.0,
          ),);

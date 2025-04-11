
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget bgWidget({Widget? child }) {
  return Container(
    decoration: BoxDecoration(
      gradient:  LinearGradient(
        colors: [Color(0xFF8E2DE2), Colors.black],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: child,
    // color: Colors.black,
    //padding: const EdgeInsets.all(12),
  );

}


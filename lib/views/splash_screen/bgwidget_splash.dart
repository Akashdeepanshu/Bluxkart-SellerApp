
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget bgWidget_splash() {
  return Container(
      decoration: BoxDecoration(
        gradient:  LinearGradient(
          colors: [Color(0xFF8E2DE2), Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      // color: Colors.black,
      //padding: const EdgeInsets.all(12),
      child: SafeArea(child: Align(
          alignment: Alignment.center,
          child: Image.asset("assets/icons/Main_logo-removebg-preview.png",))
      ));

}

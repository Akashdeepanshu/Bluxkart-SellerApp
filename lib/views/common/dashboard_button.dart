import 'package:bluxkart_seller/constants/consts.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget dashboardButton(BuildContext context, {required String title, required String count , required String icon}) {
  var size = MediaQuery.of(context).size;

  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            title.text.size(16).bold.make(),
            count.text.size(20).make(),
          ],
        ),
      ),
      Image.asset(icon, width: 40),
    ],
  ).box.white.rounded.size(size.width * 0.4, 80).padding(const EdgeInsets.all(8)).make();
}



import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderPlacedDetails(title1,title2,detail1,detail2){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title1.toString().text.bold.white.make(),
            detail1.toString().text.white.bold.make(),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            title2.toString().text.bold.white.make(),
            detail2.toString().text.white.bold.make(),
          ],
        ),

      ],
    ),
  );

}
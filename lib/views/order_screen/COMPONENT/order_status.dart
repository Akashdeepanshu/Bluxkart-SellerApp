
import 'package:bluxkart_seller/constants/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget orderStatus({icon,color,title,showDone}){
  return ListTile(
    leading: Icon(icon,color: color,) .box.border(color:color).rounded.padding(const EdgeInsets.all(8)).make(),
    trailing: SizedBox(
      width: 120,
      height: 100,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         "$title".text.color(Colors.white).make(),
          showDone? Icon(Icons.done_all_rounded,color: Colors.orangeAccent,):Container()
      ]
        ),
    ),
  );
}
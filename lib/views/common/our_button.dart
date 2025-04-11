
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ourButton({onPress , color , texTcolor, title}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.all(12 ),


        // backgroundColor: color,
        // padding: EdgeInsets.all(18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 3,
         shadowColor: Colors.black,
        // textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        // foregroundColor: Colors.white,
        // minimumSize: Size(double.infinity, 50),
         //side: BorderSide(color: Colors.black, width: 2),



      ),
      onPressed: onPress, child: Text(title,style: TextStyle(
    color: texTcolor,
    fontWeight: FontWeight.bold
  ),)
  );
}
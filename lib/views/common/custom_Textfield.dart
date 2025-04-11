import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customTextField({
  required String hint,
  required String title,
  required Color Textcolor,
  required bool isPass,
  required TextEditingController controller,
  int maxLine = 1,
  IconData? prefixIcon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title.text.color(Textcolor).semiBold.size(14).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        obscureText: isPass,
        maxLines: maxLine,
        style: TextStyle(color: Textcolor),
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.white70)
              : null,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white54),
          filled: true,
          fillColor: Colors.white10,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white30),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ],
  );
}

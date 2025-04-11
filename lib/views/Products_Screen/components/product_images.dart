import 'package:bluxkart_seller/constants/consts.dart';
Widget productImages({ required label,  onPress}) {
  return "$label"
      .text.bold
      .color(Colors.black)
      .size(16)
      .makeCentered()
      .box
      .white
      .roundedSM
      .size(100, 100)
      .make();
}

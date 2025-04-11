

import 'package:bluxkart_seller/constants/consts.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
Widget productDropdown(String title, List<String> list, RxString selectedValue) {
  return Obx(() => DropdownButtonHideUnderline(
    child: DropdownButton<String>(
      value: selectedValue.value.isEmpty ? null : selectedValue.value,
      isExpanded: true,
      hint: title.text.color(Colors.black).make(),
      items: list.map((e) => DropdownMenuItem<String>(
        child: e.text.make(),
        value: e,
      )).toList(),
      onChanged: (newValue) {
        if (newValue != null) {
          selectedValue.value = newValue;  // ✅ Properly updates selected value
        }
      },
    ),
  ).box.white.rounded.padding(EdgeInsets.symmetric(horizontal: 4)).make());
}

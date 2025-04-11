import 'package:bluxkart_seller/Controllers/productController.dart';
import 'package:bluxkart_seller/constants/firebase_const.dart';
import 'package:bluxkart_seller/services/StoreService.dart';
import 'package:bluxkart_seller/views/Products_Screen/product_details.dart';
import 'package:bluxkart_seller/views/common/bg_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/consts.dart';
import 'addProduct.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());

    return bgWidget(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => addProduct());
          },
          tooltip: "Add Product",
          child: Icon(Icons.add, color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 4,
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Products".text.white.bold.size(20).make(),
          centerTitle: true,
          elevation: 3,
          backgroundColor: Colors.transparent,
        ),
        body: StreamBuilder(
            stream: StoreService.getProducts(currentuser!.uid),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
              } else {
                var data = snapshot.data!.docs;

                if (data.isEmpty) {
                  return Center(
                      child: "No products found"
                          .text
                          .white
                          .semiBold
                          .size(16)
                          .make());
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => Divider(color: Colors.white24),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        tileColor: Colors.white.withOpacity(0.05),
                        onTap: () {
                          Get.to(() => ProductDetails(data: data[index]));
                        },
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            data[index]['p_images'][0],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: "${data[index]['p_name']}"
                            .text
                            .white
                            .bold
                            .size(16)
                            .make(),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                () {
                              final price = double.tryParse(data[index]["p_price"].toString()) ?? 0;
                              final discount = double.tryParse(data[index]["p_discount"].toString()) ?? 0;
                              final discountedPrice = price - ((price * discount) ~/ 100);

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (discount > 0)
                                    Row(
                                      children: [
                                        "\$${price.toStringAsFixed(2)}"
                                            .text
                                            .lineThrough
                                            .color(Colors.redAccent)
                                            .size(13)
                                            .make(),
                                        6.widthBox,
                                        "-${discount.toInt()}%".text.color(Colors.orangeAccent).size(13).make(),
                                      ],
                                    ),
                                  "\$${discountedPrice.toStringAsFixed(2)}"
                                      .text
                                      .color(Colors.greenAccent)
                                      .semiBold
                                      .size(15)
                                      .make(),
                                ],
                              );
                            }(),
                            if (data[index]['p_quantity'] != null)
                              "Stock: ${data[index]['p_quantity']}"
                                  .text
                                  .white
                                  .size(12)
                                  .make(),
                          ],
                        ),
                        trailing: VxPopupMenu(
                          child: Icon(Icons.more_vert, color: Colors.white),
                          menuBuilder: () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              popupMenuTiles.length,
                                  (menuIndex) => Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(popupMenuIcons[menuIndex], color: Colors.black),
                                    8.widthBox,
                                    "${popupMenuTiles[menuIndex]}".text.black.make(),
                                  ],
                                ).onTap(() {
                                  switch (popupMenuTiles[menuIndex]) {
                                    case featured:
                                      break;
                                    case edit:
                                      break;
                                    case remove:
                                      controller.removeProduct(data[index].id);
                                      VxToast.show(context, msg: "Product Removed Successfully");
                                      break;
                                  }
                                }),
                              ),
                            ),
                          ).box.white.rounded.width(200).make(),
                          clickType: VxClickType.singleClick,
                        ),
                      );
                    },
                  ),
                );
              }
            }),
      ),
    );
  }
}
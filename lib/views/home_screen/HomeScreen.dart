import 'package:bluxkart_seller/services/StoreService.dart';
import 'package:bluxkart_seller/views/common/bg_widget.dart';
import 'package:bluxkart_seller/views/common/dashboard_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/consts.dart';
import '../../constants/firebase_const.dart';
import '../Products_Screen/product_details.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
          stream: StoreService.getProducts(currentuser!.uid),
          builder: (context, AsyncSnapshot<QuerySnapshot> productSnapshot) {
            if (!productSnapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            var products = productSnapshot.data!.docs;


            products.sort((a, b) =>
                (b['p_wishlist'] as List).length.compareTo((a['p_wishlist'] as List).length));


            var popularProducts = products.take(3).toList();

            return StreamBuilder(
              stream: StoreService.getOrders(currentuser!.uid),
              builder: (context, AsyncSnapshot<QuerySnapshot> orderSnapshot) {
                if (!orderSnapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                var orders = orderSnapshot.data!.docs;
                double totalSales = 0.0;
                double totalRating = 0.0;
                int ratingCount = 0;

                for (var order in orders) {
                  var data = order.data() as Map<String, dynamic>;
                  totalSales += double.tryParse(data['total_price'].toString()) ?? 0.0;
                }

                for (var product in products) {
                  var data = product.data() as Map<String, dynamic>;
                  totalRating += double.tryParse(data['p_rating'].toString()) ?? 0.0;
                  ratingCount++;
                }

                double avgRating = ratingCount > 0 ? totalRating / ratingCount : 0.0;

                return SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 200,
                            child: Image.asset("assets/icons/Main_logo-removebg-preview.png")
                                .scale200(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            dashboardButton(context,
                                title: "Products",
                                count: "${products.length}",
                                icon: "assets/images/products.png"),
                            dashboardButton(context,
                                title: "Orders",
                                count: "${orders.length}",
                                icon: "assets/images/orders.png"),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            dashboardButton(context,
                                title: "Rating",
                                count: avgRating.toStringAsFixed(1),
                                icon: "assets/images/star.png"),
                            dashboardButton(context,
                                title: "Total Sales",
                                count: "\$${totalSales.toStringAsFixed(2)}",
                                icon: "assets/images/orders.png"),
                          ],
                        ),

                        20.heightBox,
                        const Divider(color: Colors.white54),
                        10.heightBox,

                        "Popular Products".text.white.xl.bold.size(18).make(),
                        10.heightBox,

                        popularProducts.isEmpty
                            ? "No products yet.".text.white.makeCentered()
                            : Column(
                          children: popularProducts.map((product) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => ProductDetails(data: product));
                              },
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      product['p_images'][0],
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    product['p_name'],
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                          () {
                                        final price = double.tryParse(product["p_price"].toString()) ?? 0;
                                        final discount = double.tryParse(product["p_discount"].toString()) ?? 0;
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
                                      Text(
                                        "${(product['p_wishlist'] as List).length} wishlists",
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                  trailing:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

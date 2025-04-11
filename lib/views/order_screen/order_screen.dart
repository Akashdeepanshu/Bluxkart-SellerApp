import 'package:bluxkart_seller/services/StoreService.dart';
import 'package:bluxkart_seller/views/common/bg_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../Controllers/order_controller.dart';
import '../../constants/consts.dart';
import '../../constants/firebase_const.dart';
import 'orderdetails.dart';

class orderScreen extends StatelessWidget {
  const orderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(orderController());

    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Orders".text.white.bold.make(),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: StreamBuilder(
          stream: StoreService.getOrders(currentuser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            } else {
              var data = snapshot.data!.docs;

              if (data.isEmpty) {
                return Center(child: "No orders found.".text.white.make());
              }

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.length,
                  separatorBuilder: (_, __) => 12.heightBox,
                  itemBuilder: (context, index) {
                    var order = data[index];
                    var orderDate = order['order_date'].toDate();
                    var formattedDate = intl.DateFormat.yMMMd().format(orderDate);

                    return GestureDetector(
                      onTap: () {
                        Get.to(() => orderDetails(data: order));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Colors.white,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Order Code
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order #${order['order_code']}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.black54),
                                ],
                              ),
                              10.heightBox,

                              // Date
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month, size: 18, color: Colors.grey),
                                  8.widthBox,
                                  Text(
                                    formattedDate,
                                    style: const TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                              5.heightBox,

                              // Payment Method
                              Row(
                                children: [
                                  const Icon(Icons.payment_outlined, size: 18, color: Colors.grey),
                                  8.widthBox,
                                  Text(
                                    "${order['payment_method']}",
                                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

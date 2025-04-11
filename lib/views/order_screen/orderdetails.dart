import 'package:bluxkart_seller/views/common/bg_widget.dart';
import 'package:bluxkart_seller/views/common/our_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../Controllers/order_controller.dart';
import '../../constants/consts.dart';
import 'COMPONENT/order_placed_details.dart';

class orderDetails extends StatefulWidget {
  final dynamic data;
  const orderDetails({super.key, this.data});

  @override
  State<orderDetails> createState() => _orderDetailsState();
}

class _orderDetailsState extends State<orderDetails> {
  Color parseColor(String colorString) {
    try {
      return Color(int.parse("0x$colorString"));
    } catch (e) {
      return Colors.grey;
    }
  }

  var controller = Get.find<orderController>();

  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirm'];
    controller.onDelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
    controller.ordercancel.value = widget.data['order_cancel'];
    controller.orderrefund.value = widget.data['order_refunded'];
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Obx(
            () => Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: "Order Details".text.white.bold.make(),
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          bottomNavigationBar: Obx(() {
            if (!controller.confirmed.value && !controller.ordercancel.value) {
              return ourButton(
                color: Colors.green,
                onPress: () {
                  controller.confirmed(true);
                  controller.changeStatus(
                    title: 'order_confirm',
                    status: controller.confirmed.value,
                    docID: widget.data.id,
                  );
                },
                texTcolor: Colors.white,
                title: "Confirm Order",
              ).box.height(60).make();
            } else if (controller.confirmed.value &&
                controller.ordercancel.value &&
                !controller.orderrefund.value) {
              return ourButton(
                color: Colors.red,
                onPress: () {
                  controller.orderrefund(true);
                  controller.changeStatus(
                    title: 'order_refunded',
                    status: controller.orderrefund.value,
                    docID: widget.data.id,
                  );
                },
                texTcolor: Colors.white,
                title: "Refund",
              ).box.height(60).make();
            } else {
              return const SizedBox();
            }
          }),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Refund or Cancel Banner
                if (controller.orderrefund.value && controller.ordercancel.value)
                  Column(
                    children: [
                      const Icon(Icons.currency_rupee_rounded, color: Colors.green, size: 160),
                      "Refunded".text.bold.green500.size(18).make(),
                    ],
                  )
                else if (controller.ordercancel.value && !controller.orderrefund.value)
                  Column(
                    children: [
                      const Icon(Icons.cancel_outlined, color: Colors.red, size: 160),
                      "Cancelled".text.bold.red500.size(18).make(),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Order Status".text.bold.white.size(16).make(),
                      Divider(color: Colors.white24),
                      SwitchListTile(
                        activeColor: Colors.green,
                        value: true,
                        onChanged: null,
                        title: "Placed".text.white.make(),
                      ),
                      SwitchListTile(
                        activeColor: Colors.green,
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          controller.confirmed.value = value;
                          controller.changeStatus(
                            title: 'order_confirm',
                            status: value,
                            docID: widget.data.id,
                          );
                        },
                        title: "Confirmed".text.white.make(),
                      ),
                      SwitchListTile(
                        activeColor: Colors.orange,
                        value: controller.onDelivery.value,
                        onChanged: (value) {
                          controller.onDelivery.value = value;
                          controller.changeStatus(
                            title: 'order_on_delivery',
                            status: value,
                            docID: widget.data.id,
                          );
                        },
                        title: "On Delivery".text.white.make(),
                      ),
                      SwitchListTile(
                        activeColor: Colors.blue,
                        value: controller.delivered.value,
                        onChanged: (value) {
                          controller.delivered.value = value;
                          controller.changeStatus(
                            title: 'order_delivered',
                            status: value,
                            docID: widget.data.id,
                          );
                        },
                        title: "Delivered".text.white.make(),
                      ),
                    ],
                  ).box.padding(const EdgeInsets.all(16)).rounded.color(Colors.white.withOpacity(0.1)).shadowSm.make(),

                16.heightBox,

                // Order Metadata
                orderPlacedDetails(
                  "Order Date",
                  "Order Code",
                  intl.DateFormat().add_yMd().format(widget.data['order_date'].toDate()),
                  "${widget.data['order_code']}",
                ),
                10.heightBox,
                orderPlacedDetails(
                  "Payment Status",
                  "Payment Method",
                  "Paid",
                  "${widget.data['payment_method']}",
                ),

                20.heightBox,

                // Shipping & Total
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Shipping Address".text.extraBold.white.make(),
                      10.heightBox,
                      Text("${widget.data['order_by_name']}", style: const TextStyle(color: Colors.white)),
                      Text("${widget.data['order_by_email']}", style: const TextStyle(color: Colors.white)),
                      Text("${widget.data['order_by_address']}, ${widget.data['order_by_city']}", style: const TextStyle(color: Colors.white)),
                      Text("${widget.data['order_by_state']} - ${widget.data['order_by_zipcode']}", style: const TextStyle(color: Colors.white)),
                      Text("${widget.data['order_by_phone']}", style: const TextStyle(color: Colors.white)),
                      10.heightBox,
                      Divider(color: Colors.white24),
                      "Total Amount".text.bold.white.make(),
                      "\$${widget.data['order_total_amount']}".text.xl.white.make(),
                    ],
                  ),
                ),

                20.heightBox,
                Divider(color: Colors.white24),

                // Ordered Products
                "Ordered Products".text.size(18).white.bold.make(),
                10.heightBox,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.orders.length,
                  itemBuilder: (context, index) {
                    var product = controller.orders[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlacedDetails(
                          "${product['title']}",
                          "${product['size']}",
                          "${product['qty']}x",
                          "\$${product['tprice']}",
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: 30,
                            height: 10,
                            decoration: BoxDecoration(
                              color: parseColor(product['color']),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        10.heightBox,
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

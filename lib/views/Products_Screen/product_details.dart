import 'package:bluxkart_seller/views/common/bg_widget.dart';
import 'package:get/get.dart';
import '../../constants/consts.dart';
import '../common/our_button.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Color parseColor(String colorString) {
      try {
        return Color(int.parse("0x$colorString"));
      } catch (e) {
        print("Color parse failed: $colorString");
        return Colors.grey;
      }
    }

    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: "${data['p_name']}".text.white.bold.make(),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(12),
          child: ourButton(
            color: Colors.purple,
            onPress: () {},
            texTcolor: Colors.white,
            title: "Edit Product",
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                      itemCount: data['p_images'].length,
                      autoPlay: true,
                      height: 300,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      itemBuilder: (context, index) {
                        return Image.network(
                          data['p_images'][index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ).box.rounded.clip(Clip.antiAlias).make();
                      },
                    ),
                    20.heightBox,

                    // Product Name & Rating
                    "${data['p_name']}".text.size(22).white.bold.make(),
                    10.heightBox,
                    VxRating(
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: Colors.grey,
                      selectionColor: Vx.red500,
                      count: 5,
                      size: 24,
                      isSelectable: false,
                    ),

                    10.heightBox,

                    // Categories
                    Row(
                      children: [
                        "Category: ${data['p_category']}".text.white.make(),
                        20.widthBox,
                        "Sub: ${data['p_subcat']}".text.white.make(),
                      ],
                    ),

                    20.heightBox,


                        () {
                      final price = double.tryParse(data["p_price"].toString()) ?? 0;
                      final discount = double.tryParse(data["p_discount"].toString()) ?? 0;
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

                    20.heightBox,


                    "Color".text.white.bold.size(18).make(),
                    10.heightBox,
                    Wrap(
                      spacing: 10,
                      children: List.generate(
                        data['p_colors'].length,
                            (index) => VxBox()
                            .size(40, 40)
                            .roundedFull
                            .color(parseColor(data['p_colors'][index]))
                            .border(color: Colors.white)
                            .make(),
                      ),
                    ),
                    20.heightBox,

                    // Sizes
                    "Size".text.white.bold.size(18).make(),
                    10.heightBox,
                    Wrap(
                      spacing: 10,
                      children: List.generate(
                        data['p_size'].length,
                            (index) => VxBox(
                          child: "${data['p_size'][index]}".text.white.bold.makeCentered(),
                        )
                            .size(50, 30)
                            .roundedSM
                            .border(color: Colors.white)
                            .make(),
                      ),
                    ),

                    20.heightBox,


                    "Quantity".text.white.bold.size(18).make(),
                    10.heightBox,
                    "${data['p_quantity']}".text.white.make(),

                    20.heightBox,

                    // Description
                    "Description".text.white.bold.size(20).make(),
                    10.heightBox,
                    "${data['p_desc']}".text.white.size(16).make().box.padding(const EdgeInsets.all(8)).color(Vx.gray700).roundedSM.make(),
                    20.heightBox,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

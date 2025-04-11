import 'package:bluxkart_seller/views/common/bg_widget.dart';
import 'package:bluxkart_seller/views/common/loading_indicator.dart';
import 'package:get/get.dart';
import '../../Controllers/productController.dart';
import '../../constants/consts.dart';
import '../common/custom_Textfield.dart';
import 'components/product_dropdown.dart';
import 'components/product_images.dart';

class addProduct extends StatelessWidget {
  const addProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());

    return bgWidget(
      child: Obx(() => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              controller.resetProductForm();
              Get.back();
            },
          ),
          actions: [
            controller.isloading.value
                ? loadingIndicator()
                : IconButton(
              icon: const Icon(Icons.check, color: Colors.white),
              onPressed: () async {
                controller.isloading.value = true;
                await controller.uploadImages();
                await controller.uploadProduct(context);
                controller.resetProductForm();
                Get.back();
              },
            ),
          ],
          title: "Add Product".text.white.bold.make(),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                sectionTitle("Product Info"),
                customTextField(
                    hint: "Product Name",
                    title: "Product Name",
                    Textcolor: Colors.white,
                    isPass: false,
                    controller: controller.pnamecontroller),
                10.heightBox,
                customTextField(
                    hint: "Description",
                    title: "Description",
                    Textcolor: Colors.white,
                    isPass: false,
                    maxLine: 5,
                    controller: controller.pdescriptioncontroller),
                10.heightBox,

                Row(
                  children: [
                    Expanded(
                      child: customTextField(
                          hint: "Quantity",
                          title: "Qty",
                          Textcolor: Colors.white,
                          isPass: false,
                          controller: controller.pquantitycontroller),
                    ),
                    10.widthBox,
                    Expanded(
                      child: customTextField(
                          hint: "Price",
                          title: "Price",
                          Textcolor: Colors.white,
                          isPass: false,
                          controller: controller.ppricecontroller),
                    ),
                    10.widthBox,
                    Expanded(
                      child: customTextField(
                          hint: "Discount %",
                          title: "Discount",
                          Textcolor: Colors.white,
                          isPass: false,
                          controller: controller.pdiscountcontroller),
                    ),
                  ],
                ),

                20.heightBox,

                // === Categories ===
                sectionTitle("Category"),
                productDropdown("Select Category", CategoryList,
                    controller.selectedCategory),
                10.heightBox,
                productDropdown("Select Sub Category", SubCategoryList,
                    controller.selectedSubCategory),

                20.heightBox,

                // === Images ===
                sectionTitle("Product Images"),
                Obx(() => Column(
                  children: [
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(
                        controller.pImagesList.length,
                            (index) => controller.pImagesList[index] != null
                            ? Stack(
                          children: [
                            Image.file(
                              controller.pImagesList[index],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ).onTap(() =>
                                controller.pickImage(index, context)),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Icon(Icons.close,
                                  color: Colors.red)
                                  .onTap(() =>
                                  controller.removeImageSlot(index)),
                            ),
                          ],
                        )
                            : productImages(label: "${index + 1}").onTap(
                                () => controller.pickImage(index, context)),
                      ),
                    ),
                    10.heightBox,
                    ElevatedButton.icon(
                      onPressed: controller.addImageSlot,
                      icon: const Icon(Icons.add),
                      label: "Add Image Slot".text.make(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                    ),
                  ],
                )),

                20.heightBox,

                // === Colors ===
                sectionTitle("Available Colors"),
                Obx(() => Wrap(
                  spacing: 10,
                  children: List.generate(
                    colorList.length,
                        (index) => Stack(
                      alignment: Alignment.center,
                      children: [
                        VxBox()
                            .color(colorList[index])
                            .roundedFull
                            .size(50, 50)
                            .border(color: Colors.white, width: 2)
                            .make()
                            .onTap(() {
                          if (controller.selectedColors
                              .contains(colorList[index])) {
                            controller.selectedColors
                                .remove(colorList[index]);
                          } else {
                            controller.selectedColors
                                .add(colorList[index]);
                          }
                        }),
                        controller.selectedColors
                            .contains(colorList[index])
                            ? const Icon(Icons.done, color: Colors.white)
                            : const SizedBox(),
                      ],
                    ),
                  ),
                )),

                20.heightBox,

                // === Sizes ===
                sectionTitle("Available Sizes"),
                Obx(() => Wrap(
                  spacing: 10,
                  children: List.generate(
                    sizelist.length,
                        (index) => GestureDetector(
                      onTap: () {
                        if (controller.selectedSizeIndices
                            .contains(index)) {
                          controller.selectedSizeIndices.remove(index);
                        } else {
                          controller.selectedSizeIndices.add(index);
                        }
                      },
                      child: VxBox(
                        child: sizelist[index]
                            .text
                            .white
                            .bold
                            .makeCentered(),
                      )
                          .size(60, 30)
                          .rounded
                          .border(
                          color: controller.selectedSizeIndices
                              .contains(index)
                              ? Colors.green
                              : Colors.white,
                          width: 2)
                          .make(),
                    ),
                  ),
                )),
                20.heightBox,
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget sectionTitle(String title) {
    return title.text.bold.size(18).color(Colors.white).make().pOnly(bottom: 8);
  }
}

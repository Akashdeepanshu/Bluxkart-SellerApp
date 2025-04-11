import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/consts.dart';
import '../constants/firebase_const.dart';

class ProductsController extends GetxController{

  var isloading = false.obs;

  var pnamecontroller = TextEditingController();
  var pdescriptioncontroller = TextEditingController();
  var pquantitycontroller = TextEditingController();
  var ppricecontroller = TextEditingController();
  var pdiscountcontroller = TextEditingController();


  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;


  List<Category> category = [];

  var pImagesList = <dynamic>[].obs;
  var pImagesUrlList = <dynamic>[].obs;


  var selectedCategory = ''.obs;
  var selectedSubCategory = ''.obs;

  var selectedColors = <Color>[].obs;
  var selectedSizeIndices = <int>[].obs;


  void addImageSlot() {
    pImagesList.add(null);
    pImagesUrlList.add(null);
  }

  void removeImageSlot(int index) {
    if (index >= 0 && index < pImagesList.length) {
      pImagesList.removeAt(index);
      pImagesUrlList.removeAt(index);
    }
  }
  void resetProductForm() {
    pnamecontroller.clear();
    pdescriptioncontroller.clear();
    pquantitycontroller.clear();
    ppricecontroller.clear();
    pdiscountcontroller.clear();

    selectedCategory.value = '';
    selectedSubCategory.value = '';
    selectedColors.clear();
    selectedSizeIndices.clear();
    pImagesList.clear();
    pImagesUrlList.clear();


    addImageSlot();

    isloading.value = false;
  }




  pickImage(index,context)async{
  try{
    final img = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 80);
    if(img == null) {return;}
    else{
      pImagesList[index] = File(img.path);
    }
  }catch(e){
    VxToast.show(context, msg: e.toString());


  }

}

  uploadImages() async {
    pImagesUrlList.clear();
    for (var item in pImagesList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/vendors/${currentuser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        pImagesUrlList.add(await ref.getDownloadURL());
      }
    }
    pImagesList.clear();
  }

uploadProduct(context)async{
  var store = firestore.collection(productsCollection).doc();
  await store.set({
    'p_category':selectedCategory.value,
    'p_subcat':selectedSubCategory.value,
    'p_discount':pdiscountcontroller.text,
    'p_name':pnamecontroller.text,
    'p_desc':pdescriptioncontroller.text,
    'p_quantity': int.parse(pquantitycontroller.text),
    'p_price':ppricecontroller.text,
    'p_colors': FieldValue.arrayUnion(selectedColors.map((color) => color.value.toRadixString(16)).toList()),
    'p_size': FieldValue.arrayUnion(selectedSizeIndices.map((index) => sizelist[index]).toList()),
    'p_images':FieldValue.arrayUnion(pImagesUrlList),
    'vendor_id':currentuser!.uid,
    'p_wishlist':FieldValue.arrayUnion([]),
    'p_rating':"5.0",

  });

  VxToast.show(context, msg: "Product Added Successfully");
  isloading.value = false;


}



  removeProduct(String docId) async {
    await firestore.collection(productsCollection).doc(docId).delete();
  }






}

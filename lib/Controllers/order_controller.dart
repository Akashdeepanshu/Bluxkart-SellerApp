import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../constants/firebase_const.dart';

class orderController extends GetxController{
var orders = [];
var confirmed = false.obs;
var onDelivery = false.obs;
var delivered = false.obs;
var ordercancel = false.obs;
var orderrefund = false.obs;

  getOrders(data){
    orders.clear();
  for (var item in data['orders']){
    if (item ['vendor_id'] == currentuser!.uid) {
      orders.add(item);
    }

  }
  }

  changeStatus({title,status, docID})async{
    var store = firestore.collection(ordersCollection).doc(docID);
    await store.set({
      title:status
    },
    SetOptions(
      merge: true
    )
    );
  }



}
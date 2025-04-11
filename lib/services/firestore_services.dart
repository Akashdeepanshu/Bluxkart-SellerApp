
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firebase_const.dart';

class FirestoreServices {


  static Stream<QuerySnapshot> getVendor(String uid) {
    return firestore.collection(vendorCollection).where('id', isEqualTo: uid).snapshots();
  }



  static getProducts(category){
    return firestore.collection(productsCollection).where('p_category',isEqualTo: category).snapshots();
  }

  static getProductsbysubcat(subcategory){
    return firestore.collection(productsCollection).where('p_subcat',isEqualTo: subcategory).snapshots();

  }
  
  // get cart

  static getCart(uid){
    return firestore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
  }

  static deleteDocument(dicId){
    return firestore.collection(cartCollection).doc(dicId).delete();

  }

  static getOrders(){
    return firestore.collection(ordersCollection).where('order_by',isEqualTo:currentuser!.uid).snapshots();

  }
  
  static wishlist(){
    return firestore.collection(productsCollection).where('p_wishlist', arrayContains: currentuser!.uid).snapshots();
  }

  static getorderlist(){
    return firestore.collection(ordersCollection).where('order_by',isEqualTo: currentuser!.uid).snapshots();
  }

  static getorderID(){
    return firestore.collection(ordersCollection).where('order_code',isEqualTo: currentuser!.uid).snapshots();

  }
  static getoderdetail(){
    return firestore.collection(ordersCollection).where('order_confirm',isEqualTo: currentuser!.uid).snapshots();

  }

  static shippingMethod(){
    return firestore.collection(ordersCollection).where('shipping method',isEqualTo: currentuser!.uid).snapshots();

  }
  static getCount() async{
    var res= await Future.wait([
      firestore.collection(cartCollection).where('added_by',isEqualTo: currentuser!.uid).get().then((value) => value.docs.length),

      firestore.collection(productsCollection).where('p_wishlist', isEqualTo: currentuser!.uid).get().then((value) => value.docs.length),
      firestore.collection(ordersCollection).where('order_by',isEqualTo: currentuser!.uid).get().then((value) => value.docs.length),
    ]);

  }



}
import '../constants/firebase_const.dart';

class StoreService {
  static getProfile(uid){
    return firestore.collection(vendorCollection).where('id', isEqualTo: uid).get();
  }

  static getOrders(uid){
    return firestore.collection(ordersCollection).where('vendor', arrayContains: uid).snapshots();


  }

  static getProducts(uid){
    return firestore.collection(productsCollection).where('vendor_id', isEqualTo: uid).snapshots();

  }
  static getPopularProducts(uid){
    return firestore.collection(productsCollection).where('vendor_id', isEqualTo: uid).orderBy('p_wishlist'.length);
  }

}
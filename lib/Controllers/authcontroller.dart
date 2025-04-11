import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../constants/consts.dart';
import '../constants/firebase_const.dart';

class Authcontroller extends GetxController {

  var isloading = false.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  Future<UserCredential?> loginMethod({required String email, required String password, required BuildContext context}) async {
    try {
      // Authenticate user
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Ensure user is not null
      if (userCredential.user == null) {
        VxToast.show(context, msg: "Login failed! Please try again.");
        return null;
      }

      // Check if the user is a vendor
      final vendorDoc = await firestore.collection(vendorCollection)
          .where('id', isEqualTo: userCredential.user!.uid)
          .get();

      if (vendorDoc.docs.isEmpty) {
        await auth.signOut();
        VxToast.show(context, msg: "Access Denied! You are not a vendor.");
        return null;
      }

      VxToast.show(context, msg: "Login Successful!");
      return userCredential; // Vendor login success

    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? "Login failed");
      return null;
    }
  }



  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }



}
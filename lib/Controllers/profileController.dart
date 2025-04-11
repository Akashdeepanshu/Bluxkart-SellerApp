
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;

import '../constants/firebase_const.dart';


class ProfileController extends GetxController {

  late QueryDocumentSnapshot snapshotData;

  var isloading = false.obs;

  var namecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var confirmpasswordcontroller = TextEditingController();





  updateProfile({name,password}) async {
    var store = firestore.collection(vendorCollection).doc(currentuser!.uid);
    await store.set({
      'vendor_name': name,
      'password': password,
      // 'imageUrl': profileImgPath.value,
    },SetOptions(merge: true));
    isloading.value = false;

  }

  changeAuthPassword({email,password,newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);

    await  currentuser!.reauthenticateWithCredential(cred).then((value){
      currentuser!.updatePassword(newpassword);
    }).catchError((error){
      print(error.toString());

    });
  }

}
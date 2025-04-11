import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Controllers/profileController.dart';
import '../auth_screen/Login_screen.dart';
import '../home_screen/home.dart';
import 'bgwidget_splash.dart';
import '../../constants/firebase_const.dart'; // Import Firestore reference

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance; // Firebase Auth instance

  void changeScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    User? user = auth.currentUser; // Get current user
    if (user == null) {
      // No user logged in, go to login screen
      Get.off(() => const LoginScreen());
    } else {
      // Check if the user is a vendor
      bool isVendor = await checkIfVendor(user.uid);
      if (isVendor) {
        Get.lazyPut(() => ProfileController());
        Get.off(() => const Home()); // Navigate to Vendor Home Screen
      } else {
        await auth.signOut(); // Logout user if not a vendor
        Get.off(() => const LoginScreen());
      }
    }
  }

  /// Checks Firestore if the logged-in user is a vendor
  Future<bool> checkIfVendor(String uid) async {
    try {
      var vendorDoc = await firestore
          .collection(vendorCollection) // Check vendor collection
          .where('id', isEqualTo: uid)
          .get();

      return vendorDoc.docs.isNotEmpty; // If vendor exists, return true
    } catch (e) {
      print("Error checking vendor: $e");
      return false; // Default to false in case of error
    }
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget_splash();
  }
}

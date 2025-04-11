import 'package:bluxkart_seller/constants/firebase_const.dart';
import 'package:bluxkart_seller/views/splash_screen/splash_screen_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bluxkart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        splashColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            actionsIconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent

        ),
      ),
      home: SplashScreen(),


    );

  }
}

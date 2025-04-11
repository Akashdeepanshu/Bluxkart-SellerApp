import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentuser = auth.currentUser;

// collection

const productsCollection = "products";
const usersCollection = "users";
const cartCollection = "cart";
const vendorCollection = "Vendor";
const ordersCollection = "orders";


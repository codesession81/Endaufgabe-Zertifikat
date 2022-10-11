import 'package:cloud_firestore/cloud_firestore.dart';

class Collections{

  //Collections
  static final CollectionReference customersRef = FirebaseFirestore.instance.collection('customers');
  static final CollectionReference cartsRef = FirebaseFirestore.instance.collection("carts");
  static final CollectionReference productsRef = FirebaseFirestore.instance.collection('products');
  

  //SubCollections
  static const String items ="items";
}
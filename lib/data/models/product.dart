import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? artikelId;
  final String? title;
  final num? price;
  final String? description;
  final String? category;
  final String? image;

  Product({this.artikelId,this.title,this.price,this.description,this.category,this.image});

  factory Product.fromJson(DocumentSnapshot doc){
    return Product(
      artikelId: doc['id'],
      title: doc['title'],
      price: doc['price'],
      description: doc['description'],
      category: doc['category'],
      image: doc['image'],
    );
  }
}
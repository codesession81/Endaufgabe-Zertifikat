import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp/data/consts/model_fields/product_fields.dart';

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
      artikelId: doc[ProductFields.artikelId],
      title: doc[ProductFields.title],
      price: doc[ProductFields.price],
      description: doc[ProductFields.description],
      category: doc[ProductFields.category],
      image: doc[ProductFields.image],
    );
  }
}
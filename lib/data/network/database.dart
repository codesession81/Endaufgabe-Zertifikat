import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp/data/global/global_data.dart';
import 'package:shopapp/data/models/shopping_cart.dart';
import 'package:shopapp/data/models/product.dart';

class DatabaseService {

  //Reference to the customer-collection
  final CollectionReference customersRef = FirebaseFirestore.instance.collection('customers');

  //Reference to the carts
  final CollectionReference cartsRef = FirebaseFirestore.instance.collection("carts");

  //Reference to the products-collection
  final CollectionReference productsRef = FirebaseFirestore.instance.collection('products');

  //set customer registration-data to customer collection
  Future setCustomerRegistrationData(String uid,String email,String password,String vorname,String nachname,String alter,String strasse,String hausnr,String stadt)async {
    try{
      return await customersRef.doc(uid).set({
        'uid':uid,
        'email': email,
        'password':password,
        'vorname': vorname,
        'nachname': nachname,
        'alter': int.parse(alter),
        'strasse': strasse,
        'stadt': stadt,
        'hausnr': hausnr,
      });
    }catch(error){
      print(error.toString());
    }
  }

  //Add a single product to the currentUser's shopping cart
  Future<void> addProductToShoppingCart(String artikelId,String currentUserId,String title,int menge,num summe,String image,num price){
    Future<void> result = cartsRef.doc(currentUserId).collection("items").doc(artikelId.toString()).set({
      'title':title,
      'menge':menge,
      'summe': summe,
      'price':price,
      'image':image,
      'artikelId': artikelId
    });
    return result;
  }

  //Create a list of products from query snapshot
  List<Product> _productsListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Product(
        artikelId: doc['id'],
        title: doc['title'],
        price: doc['price'],
        description: doc['description'],
        category: doc['category'],
        image: doc['image'],
      );
    }).toList();
  }

  //Convert list of products to a stream
  Stream<List<Product>> get productStream => productsRef.snapshots().map(_productsListFromSnapshot);

  List<ShoppingCart> _cartListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return ShoppingCart(
          titel: doc['title'],
          menge: doc['menge'],
          summe: doc['summe'],
          price: doc['price'],
          image: doc['image'],
          artikelId: doc['artikelId']
      );
    }).toList();
  }

  //Generate a stream that conatins a list of shoppingcarts
  Stream<List<ShoppingCart>> get cartStream =>cartsRef.doc(GlobalData.currentUserId).collection("items").snapshots().map(_cartListFromSnapshot);


  //Delete articel from cart collection
  Future<void>deleteProduct(String artikelId) async{
    final DocumentSnapshot doc = await cartsRef.doc(GlobalData.currentUserId).collection("items").doc(artikelId).get();
    if(doc.exists){
      doc.reference.delete();
    }
  }
}
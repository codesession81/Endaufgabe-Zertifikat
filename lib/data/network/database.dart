import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp/data/consts/collections/collections.dart';
import 'package:shopapp/data/consts/model_fields/custumer_fields.dart';
import 'package:shopapp/data/consts/model_fields/product_fields.dart';
import 'package:shopapp/data/consts/model_fields/shopping_cart_fields.dart';
import 'package:shopapp/data/global/global_data.dart';
import 'package:shopapp/data/models/product.dart';
import 'package:shopapp/data/models/shopping_cart.dart';

class DatabaseService {
  
  Future setCustomerRegistrationData({String? uid,String? email,String? vorname,String? nachname,String? alter,String? strasse,String? hausnr,String? stadt})async {
    try{
      await Collections.customersRef.doc(uid).set({
        CustomerFields.uid:uid,
        CustomerFields.email: email,
        CustomerFields.vorname: vorname,
        CustomerFields.nachname: nachname,
        CustomerFields.alter: int.parse(alter!),
        CustomerFields.strasse: strasse,
        CustomerFields.stadt: stadt,
        CustomerFields.hausnr: hausnr,
      });
    }catch(error){
      print(error.toString());
    }
  }

  //Add a single product to the currentUser's shopping cart
  Future<void> addProductToShoppingCart(String artikelId,String currentUserId,String titel,int menge,num summe,String image,num price){
    Future<void> result = Collections.cartsRef.doc(currentUserId).collection(Collections.items).doc(artikelId.toString()).set({
      ShoppingCardFields.titel:titel,
      ShoppingCardFields.menge:menge,
      ShoppingCardFields.summe: summe,
      ShoppingCardFields.price:price,
      ShoppingCardFields.image:image,
      ShoppingCardFields.artikelId: artikelId
    });
    return result;
  }

  //Create a list of products from query snapshot
  List<Product> _productsListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Product(
        artikelId: doc[ProductFields.artikelId],
        title: doc[ProductFields.title],
        price: doc[ProductFields.price],
        description: doc[ProductFields.description],
        category: doc[ProductFields.category],
        image: doc[ProductFields.image],
      );
    }).toList();
  }

  //Convert list of products to a stream
  Stream<List<Product>> get productStream => Collections.productsRef.snapshots().map(_productsListFromSnapshot);

  List<ShoppingCart> _cartListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return ShoppingCart(
          titel: doc[ShoppingCardFields.titel],
          menge: doc[ShoppingCardFields.menge],
          summe: doc[ShoppingCardFields.summe],
          price: doc[ShoppingCardFields.price],
          image: doc[ShoppingCardFields.image],
          artikelId: doc[ShoppingCardFields.artikelId]
      );
    }).toList();
  }

  //Generate a stream that conatins a list of shoppingcarts
  Stream<List<ShoppingCart>> get cartStream =>Collections.cartsRef.doc(GlobalData.currentUserId).collection(Collections.items).snapshots().map(_cartListFromSnapshot);


  //Delete articel from cart collection
  Future<void>deleteProduct(String artikelId) async{
    final DocumentSnapshot doc = await Collections.cartsRef.doc(GlobalData.currentUserId).collection(Collections.items).doc(artikelId).get();
    if(doc.exists){
      doc.reference.delete();
    }
  }
}
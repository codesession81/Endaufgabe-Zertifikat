import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/data/models/product.dart';
import 'package:shopapp/data/models/shopping_cart.dart';
import 'package:shopapp/processor/authentication/auth_service.dart';
import 'package:shopapp/visible/data_layouts/grid/grid_layout.dart';
import 'package:shopapp/visible/data_layouts/list/list_layout.dart';
import 'package:shopapp/visible/pages/authentication/login.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final AuthService _authService = AuthService();
  bool isGridLayoutSet=true;
  late num cartSize;

  @override
  Widget build(BuildContext context) {
    List<Product> allProductsList = [];
    List<ShoppingCart> allShoppingCartList = [];

    final products = Provider.of<List<Product>>(context);
    final shoppingCards = Provider.of<List<ShoppingCart>>(context);

    if(products!=null){
      for (var product in products) {
        allProductsList.add(Product(artikelId: product.artikelId,image: product.image,title: product.title, price:product.price,description: product.description,category: product.category));
      }
    }

    if(shoppingCards!=null){
      for(var shoppingCard in shoppingCards){
        allShoppingCartList.add(ShoppingCart(summe: shoppingCard.summe));
      }
      setState(() {
        cartSize = allShoppingCartList.length;
      });
    }

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isGridLayoutSet = false;
                  });
                },
                icon: const Icon(Icons.grid_on_rounded,color: Colors.grey)
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    isGridLayoutSet = true;
                  });
                },
                icon: const Icon(Icons.list,color: Colors.grey)
            ),
            Stack(
              children: <Widget>[
                IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.shopping_cart,color: Colors.grey)
                ),
                Positioned(
                  bottom: 20,
                  left: 6,
                    child:Text("$cartSize",style: const TextStyle(color: Colors.red),)
                ),
              ],
            ),
            IconButton(
                onPressed: (){
                  _authService.logout();
                  Navigator.push((context),MaterialPageRoute(builder: (context)=>const Login()));
                  },
                icon: const Icon(Icons.logout,color: Colors.grey)
            ),
          ],
          backgroundColor: Colors.white,
        ),
      body:isGridLayoutSet?ListLayout(allProductsList):GridLayout(allProductsList)
    );
  }
}

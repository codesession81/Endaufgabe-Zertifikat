import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/data/models/product.dart';
import 'package:shopapp/data/models/shopping_cart.dart';
import 'package:shopapp/data/network/database.dart';
import 'package:shopapp/visible/pages/private/navigationPages/cart_list.dart';
import 'package:shopapp/visible/pages/private/navigationPages/products.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController pageController;
  int pageIndex =0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
    );
  }

  onPageChanged(int pageIndex){
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex){
    pageController.jumpToPage(
      pageIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamProvider<List<Product>>.value(
        value: DatabaseService().productStream,
        initialData: [],
        child: StreamProvider<List<ShoppingCart>>.value(
          initialData: [],
          value: DatabaseService().cartStream,
          child: Scaffold(
            body: PageView(
              children:const <Widget> [
                Products(),
                CartList(),
              ],
              controller: pageController,
              onPageChanged: onPageChanged,
            ),
            bottomNavigationBar: CupertinoTabBar(
              currentIndex: pageIndex,
              onTap: onTap,
              activeColor: Colors.red,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined),label: "Artikel"),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),label: "Cart"),
              ],
            ),
          ),
        )
      )
    );
  }
}

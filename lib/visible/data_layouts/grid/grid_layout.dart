import 'package:flutter/material.dart';
import 'package:shopapp/data/models/product.dart';
import 'package:shopapp/visible/pages/private/navigationPages/product_details.dart';

class GridLayout extends StatefulWidget {
  List<Product> allProductsList = [];
  GridLayout(this.allProductsList, {Key? key}) : super(key: key);

  @override
  _GridLayoutState createState() => _GridLayoutState();
}

class _GridLayoutState extends State<GridLayout> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: widget.allProductsList.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => ProductDetails(artikelId:widget.allProductsList[index].artikelId ,title: widget.allProductsList[index].title,category: widget.allProductsList[index].category,description: widget.allProductsList[index].description,price: widget.allProductsList[index].price,image: widget.allProductsList[index].image,),),),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 2.0, 2.0),
              child: Stack(
                children:<Widget> [
                    CircleAvatar(
                      radius: 90.0,
                      backgroundImage: NetworkImage(widget.allProductsList[index].image!),
                      backgroundColor: Colors.transparent,
                    ),
                  Positioned(
                    bottom: -10,
                    left: 5,
                    child: Text(widget.allProductsList[index].title.toString(),style: const TextStyle(color: Colors.red,fontSize: 10)),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

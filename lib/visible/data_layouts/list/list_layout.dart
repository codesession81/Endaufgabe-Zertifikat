import 'package:flutter/material.dart';
import 'package:shopapp/data/models/product.dart';
import 'package:shopapp/visible/pages/private/navigationPages/product_details.dart';

class ListLayout extends StatefulWidget {
  List<Product> allProductsList = [];
  ListLayout(this.allProductsList, {Key? key}) : super(key: key);

  @override
  _ListLayoutState createState() => _ListLayoutState();
}

class _ListLayoutState extends State<ListLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: widget.allProductsList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetails(artikelId:widget.allProductsList[index].artikelId ,title: widget.allProductsList[index].title,category: widget.allProductsList[index].category,description: widget.allProductsList[index].description,price: widget.allProductsList[index].price,image: widget.allProductsList[index].image,))),
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                      NetworkImage(widget.allProductsList[index].image!),
                    ),
                    title: Text("${widget.allProductsList[index].title}"),
                    subtitle: Wrap(
                      children: [
                        Text("Preis ${widget.allProductsList[index].price} Euro"),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

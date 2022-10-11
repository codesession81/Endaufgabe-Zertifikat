import 'package:flutter/material.dart';
import 'package:shopapp/data/global/global_data.dart';
import 'package:shopapp/data/network/database.dart';

class ProductDetails extends StatefulWidget {
  final String? artikelId;
  final String? title;
  final num? price;
  final String? description;
  final String? category;
  final String? image;

  const ProductDetails({Key? key,this.artikelId,this.title,this.price,this.description,this.category,this.image}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final DatabaseService _databaseService = DatabaseService();
  int menge =0;
  num summe=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.grey, //change your color here
        ),
        backgroundColor: Colors.white,
        title: const Text("Detailansicht",style: TextStyle(color: Colors.grey)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30,30,30,0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(widget.title!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircleAvatar(
                  radius: 150,
                  backgroundImage:NetworkImage(widget.image!),
                ),
              ),
              Text("Kategorie ${widget.category!}",style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(widget.description!),
              const SizedBox(height: 15),
              Text("Stückpreis ${widget.price.toString()} Euro",style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FloatingActionButton.small(
                      child: const Icon(Icons.remove),
                      heroTag: "btn2",
                      onPressed: (){
                        if(menge>0){
                          setState(() {
                            menge--;
                          });
                        }
                      }
                  ),
                  menge==0? const Text("Warenkorb leer",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),):Text("$menge Stück im Warenkorb",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  FloatingActionButton.small(
                      child: const Icon(Icons.add),
                      heroTag: "btn1",
                      onPressed: (){
                        setState(() {
                          menge++;
                        });
                      }),
                ],
              ),
              const SizedBox(height: 15),
              Text("Gesamtbetrag: ${(summe=menge*widget.price!).toStringAsFixed(2)} Euro",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: ()async{
                  if(menge!=0){
                    GlobalData.artikelId = widget.artikelId;
                    if(GlobalData.currentUserId!=null){
                      try {
                        Future<void> result = _databaseService.addProductToShoppingCart(widget.artikelId!,GlobalData.currentUserId!,widget.title!,menge,summe, widget.image!,widget.price!);
                        result.then((value) => {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("In den Warenkorb gelegt"),
                        ))
                        });
                      } on Exception catch (e) {
                        print("Fehlermeldung $e");
                      }
                    }
                  }
              }, child: const Text("In den Warenkorb"),),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

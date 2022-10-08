import 'package:flutter/material.dart';
import 'package:shopapp/data/models/shopping_cart.dart';
import 'package:shopapp/data/network/database.dart';
import 'package:shopapp/visible/loading/loading.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {

  final DatabaseService _db = DatabaseService();
  num summe=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _db.cartStream,
        builder: (BuildContext context, AsyncSnapshot<List<ShoppingCart>> snapshot){
          if(snapshot.hasData){
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context,index){
                      summe+= snapshot.data![index].summe!;
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data![index].image!),
                          ),
                          title: Text("Stückpreis ${snapshot.data![index].price} Euro"),
                          subtitle: Wrap(
                            children: [
                              Text("Menge ${snapshot.data![index].menge}"),
                              const SizedBox(width: 5),
                              Text("Summe ${snapshot.data![index].summe!.toStringAsFixed(2)} Euro"),
                            ],
                          ),
                          trailing: IconButton(
                              onPressed: (){
                                showDialog(
                                    context:context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("Artikel ${snapshot.data![index].titel}"),
                                        content: const Text("aus Cart löschen?"),
                                        actions: [
                                          TextButton(
                                            child: const Text("Ja,endgültig löschen"),
                                            onPressed: (){
                                             _db.deleteProduct(snapshot.data![index].artikelId!);
                                             Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("Abbrechen"),
                                            onPressed: ()=>Navigator.of(context).pop()
                                            ,
                                          ),
                                        ],
                                      );
                                    }
                                );
                              },
                              icon: const Icon(Icons.delete_forever, color: Colors.red)),
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text("Gesamtbetrag immer noch falsch!:${summe.toStringAsFixed(2)} Euro"),
                    const SizedBox(height: 20)
                  ],
                )
              ],
            );
          }else{
            return const Loading();
          }
        },
      ),
    );
  }
}



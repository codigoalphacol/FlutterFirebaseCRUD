import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:flutter_app_products/ui/product_screen.dart';
import 'package:flutter_app_products/ui/product_information.dart';
import 'package:flutter_app_products/model/product.dart';

class ListViewProduct extends StatefulWidget {
  @override
  _ListViewProductState createState() => _ListViewProductState();
}

final productReference = FirebaseDatabase.instance.reference().child('product');

class _ListViewProductState extends State<ListViewProduct> {

  List<Product> items;
  StreamSubscription<Event> _onProductAddedSubscription;
  StreamSubscription<Event> _onProductChangedSubscription;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = new List();
    _onProductAddedSubscription = productReference.onChildAdded.listen(_onProductAdded);
    _onProductChangedSubscription = productReference.onChildChanged.listen(_onProductUpdate);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onProductAddedSubscription.cancel();
    _onProductChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product DB',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product List'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.only(top: 12.0),
              itemBuilder: (context, position){
                return Column(
                  children: <Widget>[
                    Divider(height: 7.0,),
                    Row(
                      children: <Widget>[
                        Expanded(child: ListTile(title: Text('${items[position].name}',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 21.0,
                          ),
                        ),
                            subtitle:
                            Text('${items[position].description}',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 21.0,
                              ),
                            ),
                            leading: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.amberAccent,
                                  radius: 17.0,
                                  child: Text('${position + 1}',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 21.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () => _navigateToProductInformation(context, items[position])),),
                        IconButton(
                            icon: Icon(Icons.delete, color: Colors.red,),
                              onPressed: ()=>_showDialog(context, position)),
                            //onPressed: () => _deleteProduct(context, items[position],position)),
                        IconButton(
                            icon: Icon(Icons.remove_red_eye, color: Colors.blueAccent,),
                            onPressed: () => _navigateToProduct(context, items[position])),
                      ],
                    ),

                  ],
                );
              }
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: () => _createNewProduct(context),
        ),
      ),
    );
  }


  void _showDialog(context, position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.delete, color: Colors.purple,),
                onPressed: () => _deleteProduct(context, items[position],position)),
            new FlatButton(
              child: Text('Cancel'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  void _onProductAdded(Event event){
    setState(() {
      items.add(new Product.fromSnapShot(event.snapshot));
    });
  }

  void _onProductUpdate(Event event){
    var oldProductValue = items.singleWhere((product) => product.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldProductValue)] = new Product.fromSnapShot(event.snapshot);
    });
  }

  void _deleteProduct(BuildContext context, Product product,int position)async{
    await productReference.child(product.id).remove().then((_){
      setState(() {
        items.removeAt(position);
      });
    });

  }

  void _navigateToProductInformation(BuildContext context, Product product)async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => ProductScreen(product)),
    );
  }

  void _navigateToProduct(BuildContext context, Product product)async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => ProductInformation(product)),
    );
  }

  void _createNewProduct(BuildContext context)async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => ProductScreen(Product(null,'','','','',''))),
    );
  }


}
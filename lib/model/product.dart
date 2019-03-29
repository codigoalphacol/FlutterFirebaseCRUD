import 'package:firebase_database/firebase_database.dart';


class Product {
  String _id;
  String _name;
  String _codebar;
  String _description;
  String _price;
  String _stock;
  String _productImage;

  Product(this._id,this._name,this._codebar,this._description,
      this._price,this._stock,this._productImage);

  Product.map(dynamic obj){
    this._name = obj['name'];
    this._codebar = obj['codebar'];
    this._description = obj['description'];
    this._price = obj['price'];
    this._stock = obj['stock'];
    this._productImage = obj['ProductImage'];
  }

  String get id => _id;
  String get name => _name;
  String get codebar => _codebar;
  String get description => _description;
  String get price => _price;
  String get stock => _stock;
  String get productImage => _productImage;

  Product.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _codebar = snapshot.value['codebar'];
    _description = snapshot.value['description'];
    _price = snapshot.value['price'];
    _stock = snapshot.value['stock'];
    _productImage = snapshot.value['ProductImage'];
  }
}

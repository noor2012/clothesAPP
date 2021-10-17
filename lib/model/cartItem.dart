import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier{
  var id;
  var title;
  var qty;
  var price;
  var grandTotal;
  var img;
  CartItem(){}


  CartItem.fromJson(Map<dynamic, dynamic> json){
     id = json["id"];
     title = json["title"];
     qty = json["qty"];
     price = json["price"];
     grandTotal = json["grandTotal"];
     img = json["img"];

  }


  Map<String, dynamic> toJson() {
    return {
    "id" : id,
    "title" : title,
    "qty" : qty,
    "price" : price,
    "grandTotal" : grandTotal,
    "img" : img,
    };
  }
}


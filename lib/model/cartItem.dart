// class cartItem {
//   var productId;
//   var qty;
//   var price;
//   var grandTotal;
// }
import 'package:flutter/material.dart';

class CartItemTile extends StatelessWidget {
  final String img;
  final String price;
  final int pQuantity;
  final String title;

  // totalPrice() {
  //   int _price = int.parse(price);
  //   int _quantity = quantity;
  //   return _price * _quantity;
  // }

  CartItemTile({required this.img, required this.price, required this.pQuantity, required this.title});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: FittedBox(
            child: Text('\$$img'),
          ),
        ),
        title: Text(title),
        subtitle: Text("\$${price}"),
        trailing: Text('$pQuantity'),
      ),
    );
  }
}


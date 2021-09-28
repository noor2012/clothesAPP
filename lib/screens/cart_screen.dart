import 'package:clothesapp/model/cart.dart';
import 'package:clothesapp/model/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  var product;
  var title;
  var price;
  var pQuantity;

  CartScreen({
   this.product,
   this.title,
   this.pQuantity,
    this.price});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
List<CartItems> cart =[];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    CartItems cart = Provider.of<CartItems>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart Page',
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: size.width * 0.07,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF006FFF),
      ),
      // Column(
      //   children: [
      //     Expanded(
      //       child: ListView.builder(
      //         itemCount: cart.items.length,
      //         itemBuilder: (ctx, i) => CartItemTile(
      //           img: cart.items.keys.toList()[i],
      //           price: cart.items.values.toList()[i].price.toString(),
      //           pQuantity: cart.items.values.toList()[i].pQuantity,
      //           title: cart.items.values.toList()[i].title,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(left: 8, right: 8, bottom: 5),
                width: size.width * 0.8,
                height: size.height*0.24,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Card(
                    child: Stack(
                      children: [
                        Image.network(
                        widget.product[0],
                        fit: BoxFit.fill,
                        height: size.height,
                        width: size.width * .5,
                        ),
                        Positioned(
                          left: size.height * .29,
                          bottom: size.height * .12,
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                                fontSize: size.width * 0.06),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Positioned(
                          right: size.height * .15,
                          bottom: size.height * .001,
                          child: Text(
                            widget.price.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                                color: Colors.grey[600],
                                fontSize: size.width * 0.05),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Positioned(
                          right: size.height * .01,
                          bottom: size.height * .039,
                          child: Text(
                            widget.pQuantity,
                            style: TextStyle(
                                fontFamily: 'Pacifico',
                                color: Colors.green.shade200,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.05),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

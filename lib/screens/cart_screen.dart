import 'dart:convert';
import 'package:clothesapp/model/cartItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  var product;
  var title;
  var price;
  var pQuantity;
  var size;

  CartScreen({this.product, this.title, this.pQuantity, this.price, this.size});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cart = [];
  num totalPrice = 0;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _buildCartItems(widget.size);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //  CartItem cart = Provider.of<CartItem>(context);
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
      body: Scaffold(
        body: Container(
            child: Column(
          children: [
            Expanded(
                child: ListView(
              children: items,
              padding: EdgeInsets.only(top: 10, bottom: 50),
            )),
            if (cart.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Total Price: " + totalPrice.toString() + " \$"),
              ),
            if (cart.isNotEmpty)
              RaisedButton(
                color: Color(0xFF0000).withOpacity(0.6),
                child: Text(
                  'Confirm',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.05),
                ),
                onPressed: () async {
                  String uid = FirebaseAuth.instance.currentUser!.uid;
                  String userEmail = FirebaseAuth.instance.currentUser!.email!;
                  DocumentReference orderRef = await FirebaseFirestore.instance
                      .collection("users")
                      .doc(uid)
                      .collection("cart")
                      .add({});
                  Map<String, dynamic> order = {
                    "orderID": orderRef.id,
                    "userID": uid,
                    "userEmail": userEmail,
                  };
                  orderRef.set(order);
                  SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  await _prefs.remove("cart");

                  setState(() {
                    totalPrice = 0;
                    cart = [];
                    items = [];
                  });
                },
              )
          ],
        )),
      ),
    );
  }

  List<Widget> items = [];
  _buildCartItems(Size size) async {
    await _prefs.then((value) {
      if (value.containsKey('cart')) {
        List dynamicCart = json.decode(value.getString("cart")!);
        cart = dynamicCart.map((e) => CartItem.fromJson(e)).toList();
        List<Widget> items = [];
        totalPrice = 0;
        cart.forEach((value) {
          items.add(_CartItemWidget(size, value));
          totalPrice += value.grandTotal;
        });
        setState(() {
          this.items = items;
        });
      }
    });
  }

  _CartItemWidget(Size size, CartItem item) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 5),
      width: size.width * 0.8,
      height: size.height * 0.24,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Card(
          child: Stack(
            children: [
              Image.network(
                item.img[0],
                fit: BoxFit.fill,
                height: size.height,
                width: size.width * .5,
              ),
              Positioned(
                left: size.height * .29,
                bottom: size.height * .12,
                child: Text(
                  item.title,
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
                  item.price.toString(),
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
                  item.qty.toString(),
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.green.shade200,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.05),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      cart.removeWhere(((element) => element.id == item.id));
                      _prefs.then((value) {
                        List tempDynamicCart =
                            json.decode(value.getString("cart")!);
                        List tempCart = tempDynamicCart
                            .map((e) => CartItem.fromJson(e))
                            .toList();
                        tempCart
                            .removeWhere(((element) => element.id == item.id));
                        value.setString("cart", json.encode(tempCart));
                        _buildCartItems(size);
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:clothesapp/model/cartItem.dart';
import 'package:clothesapp/screens/cart_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DetailsScreen extends StatefulWidget {
  final String productId;
  var product;
  var pQuantity;
  String title;
  String storeName;
  String des;
  String discount;
  var price;
  double rat;

  DetailsScreen(
      {required this.productId,
      this.product,
      this.pQuantity,
      required this.title,
      required this.storeName,
      required this.des,
      required this.rat,
      required this.discount,
      required this.price});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

List _total_carts = [];

class _DetailsScreenState extends State<DetailsScreen> {
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("users");

  // Future addToCart()async{
  //   return userRef.doc().collection('cart').doc(widget.productId).set({
  //     'title':widget.title
  //   });
  // }

  int _index = 0;
  int _quantity = 1;
  List<CartItem> items = [];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    // CartItems cart = Provider.of<CartItems>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.9,
                child: CarouselSlider(
                  items: widget.product
                      .map<Widget>(
                        (item) => Padding(
                          padding: const EdgeInsets.only(left: 1, right: 1),
                          child: Container(
                            height: size.height * .03,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(item), fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                      viewportFraction: 1,
                      initialPage: 0,
                      autoPlay: true,
                      height: size.height * 0.3,
                      onPageChanged: (int i, carouselPageChangedReason) {
                        setState(() {
                          _index = i;
                        });
                      }),
                ),
              ),
              Positioned(
                top: size.height * .0001,
                left: size.height * .01,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: size.width * .07,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: size.width * .06,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: size.height * .04,
                  width: size.width * .40,
                  color: Color(0xFF0000).withOpacity(0.6),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.storeName,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.04),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              widget.des,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: size.width * .06,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5, top: 10),
                child: RatingBarIndicator(
                  rating: double.parse(widget.rat.toString()),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: size.width * 0.08,
                  direction: Axis.horizontal,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  right: 5,
                ),
                height: size.height * .04,
                width: size.width * .10,
                color: Colors.amber.withOpacity(0.8),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.discount,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.04),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10),
            child: Text(
              widget.price.toString(),
              style: TextStyle(
                  fontFamily: 'Cairo',
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.07),
            ),
          ),
          // SizedBox(
          //   height: size.height * .01,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Material(
                    color: Colors.amber.withOpacity(0.8),
                    child: GestureDetector(
                      onTap: add,
                      child: SizedBox(
                        child: Icon(Icons.add),
                        height: 32,
                        width: 32,
                      ),
                    ),
                  ),
                ),
                Text(
                  _quantity.toString(),
                  style: TextStyle(fontSize: 50),
                ),
                ClipOval(
                  child: Material(
                    color: Colors.amber.withOpacity(0.8),
                    child: GestureDetector(
                      onTap: subtract,
                      child: SizedBox(
                        child: Icon(Icons.remove),
                        height: 32,
                        width: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),
          Container(
            height: size.height * .07,
            margin: EdgeInsets.only(left: 5, right: 5),
            child: RaisedButton(
              color: Color(0xFF0000).withOpacity(0.6),
              child: Text(
                'Add to Cart',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.05),
              ),
              onPressed: () {
                _prefs.then((value) async {
                  if (value.containsKey("cart")) {
                  } else {
                    List totalCart = [];
                    CartItem cart = CartItem();
                    cart.price = widget.price.toString();
                    cart.qty = _quantity;
                    cart.title = widget.title;
                    cart.grandTotal = widget.price * _quantity;
                    totalCart.add(cart);
                    value.setString('cart', json.encode(cart.price).toString());
                   
                  }
                  final ScaffoldMessengerState addToCartMsg =
                      ScaffoldMessenger.of(context);
                  addToCartMsg.showSnackBar(
                    const SnackBar(content: Text('Product added sucessfully')),
                  );
                  // await addToCart();
                  // Navigator.push(context, MaterialPageRoute(builder: (_)=>CartScreen(
                  //   product: widget.product[0],
                  //   title: widget.title,
                  //   price: widget.price,
                  //   pQuantity: _quantity,
                  // )));
                  // for (int i = 0; i < _total_carts.length; i++) {
                  //   cart.addItem(
                  //       _total_carts[i]['${widget.product[0]}'],
                  //       _total_carts[i]['${widget.title}'],
                  //       _total_carts[i]['${widget.price}']);
                  // }
                  // print(cart);
                });
              },
              // for (int i = 0; i < items.length; i++){
              //   Provider.of<Cart>(context).add(items[i]);
              // }
              // cart.add(items[i]);
            ),
          ),
        ],
      ),
    );
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        print(_quantity);
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
      print(_quantity);
    });
  }
}

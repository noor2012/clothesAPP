import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailsScreen extends StatefulWidget {
  var product;
  String title;
  String storeName;
  String des;
  String discount;
  String price;
  int rat;

  DetailsScreen(
      {this.product,
      required this.title,
      required this.storeName,
      required this.des,
      required this.rat,
      required this.discount,
      required this.price});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
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
                  width: size.width * .24,
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
              widget.price,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  color: Color(0xFF006FFF),
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.07),
            ),
          ),
          SizedBox(
            height: size.height * .07,
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
                onPressed: () {}),
          ),
        ],
      ),
    );
  }
}

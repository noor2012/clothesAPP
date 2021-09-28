import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clothesapp/model/cart.dart';
import 'package:clothesapp/screens/details_factory.dart';
import 'package:clothesapp/screens/details_screen.dart';
import 'package:clothesapp/screens/factory_clothes.dart';
import 'package:clothesapp/screens/searchTap.dart';
import 'package:clothesapp/screens/topProduct.dart';
import 'package:clothesapp/widgets/category.dart';
import 'package:clothesapp/widgets/myDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'cart_screen.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}
List _total_carts = [];
class _HomePageState extends State<HomePage> {
  List<Item> _items =[];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
          appBar: AppBar(
            actions: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      // padding: EdgeInsets.only(left: size.height*0.003),
                      height: size.height*0.03,
                      width: size.width*0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white30
                      ),
                      child: Consumer<CartItems>(builder: (context,cart,child){
                        return Text("${cart.itemCount}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: size.width * 0.03,
                              fontWeight: FontWeight.bold),
                        );
                      },)
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (_) => CartScreen()));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SearchTab()));
                },
              )
            ],
            title: Text(
              'Home Page',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: size.width * 0.07,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Color(0xFF006FFF),
          ),
          backgroundColor: Colors.white,
          body: getBody(),
          drawer: MyDrawer(),
        );
  }

  int _index = 0;
  int _dataLength = 1;

  @override
  void initState() {
    getSliderImageFromDb();
    super.initState();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getSliderImageFromDb() async {
    var _fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _fireStore.collection('slider').get();
    if (mounted) {
      setState(() {
        _dataLength = snapshot.docs.length;
      });
    }
    return snapshot.docs;
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        if (_dataLength != 0)
          FutureBuilder(
            future: getSliderImageFromDb(),
            builder: (_,
                AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
                    snapShot) {
              return snapShot.data == null
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: CarouselSlider.builder(
                        itemCount: snapShot.data!.length,
                        itemBuilder: (BuildContext context, index, int) {
                          DocumentSnapshot<Map<String, dynamic>> sliderImage =
                              snapShot.data![index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: size.width * 0.9,
                              child: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(sliderImage['image']),
                              ),
                            ),
                          );
                        },
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
                    );
            },
          ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Categories",
                  style: TextStyle(
                      fontSize: size.width * .06,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo')),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Category(),
        SizedBox(
          height: size.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Factory Clothes",
                style: TextStyle(
                    fontSize: size.width * .06,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo'),
              ),
              Row(
                children: [
                  // SizedBox(
                  //   width: size.width * 0.001,
                  // ),
                  Text(
                    "All",
                    style: TextStyle(
                        color: Colors.grey, fontSize: size.height * .03),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => FactoryClothes()));
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: size.height * 0.03,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('factory').snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    decoration: BoxDecoration(color: Colors.white60),
                    height: size.height * 0.3,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, i) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=> DetailsFactory(
                                product: snapshot.data!.docs[i]['img-product'],
                                title: snapshot.data!.docs[i]['title'],
                                storeName: snapshot.data!.docs[i]['storeName'],
                                des: snapshot.data!.docs[i]['des'],
                                discount: snapshot.data!.docs[i]['discount'],
                                rat: snapshot.data!.docs[i]['rat'],
                                price: snapshot.data!.docs[i]['price'],
                              )));
                            },
                            child: Container(
                              decoration: BoxDecoration(),
                              margin: EdgeInsets.only(left: 8, right: 8),
                              width: size.width * 0.8,
                              child: Card(
                                elevation: 2,
                                child: Stack(
                                  children: [
                                    Image.network(
                                      snapshot.data!.docs[i]['img'],
                                      fit: BoxFit.fill,
                                      height: size.height,
                                      width: size.width,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        color: Colors.white.withOpacity(0.7),
                                        height: size.height * .05,
                                        width: size.width * .80,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              snapshot.data!.docs[i]['title'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Cairo',
                                                  fontSize: size.width * 0.05),
                                            ),
                                            Text(
                                              snapshot.data!.docs[i]['storeName'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[800],
                                                  fontFamily: 'Cairo',
                                                  fontSize: size.width * 0.05),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }));
              } else {
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                );
              }
            }),
        SizedBox(
          height: size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top Products",
                style: TextStyle(
                    fontSize: size.width * .06,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo'),
              ),
              Row(
                children: [
                  Text("All",
                      style: TextStyle(
                          color: Colors.grey, fontSize: size.height * .03)),
                  SizedBox(
                    width: size.width * 0.001,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => TopProduct()));
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: size.height * 0.03,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('topProduct').snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: size.height * 0.8,
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, i) {
                      List _total_carts = [];
                      _total_carts  = snapshot.data!.docs;
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => DetailsScreen(
                                productId: snapshot.data!.docs[i].id,
                                product: _total_carts[i]['product-img'],
                                title: _total_carts[i]['title'],
                                storeName: _total_carts[i]['storeName'],
                                des: _total_carts[i]['des'],
                                rat: _total_carts[i]['rat'],
                                discount: _total_carts[i]['discount'],
                                price: _total_carts[i]['price'],                              )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 8, right: 8, bottom: 5),
                          width: size.width * 0.8,
                          height: size.height,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Card(
                              child: Stack(
                                children: [
                                  Image.network(
                                    _total_carts[i]['img'],
                                    fit: BoxFit.fill,
                                    height: size.height,
                                    width: size.width * .5,
                                  ),
                                  Positioned(
                                    left: size.height * .29,
                                    bottom: size.height * .12,
                                    child: Text(
                                      _total_carts[i]['title'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo',
                                          fontSize: size.width * 0.06),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Positioned(
                                    top: size.height * .040,
                                    right: size.height * .001,
                                    child: Container(
                                      height: size.height * .04,
                                      width: size.width * .10,
                                      color: Colors.amber.withOpacity(0.7),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          _total_carts[i]['discount'],
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width * 0.04),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: size.height * .15,
                                    bottom: size.height * .001,
                                    child: Text(
                                      _total_carts[i]['price'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo',
                                          color: Colors.grey[600],
                                          fontSize: size.width * 0.05),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      height: size.height * .04,
                                      width: size.width * .44,
                                      color: Color(0xFF0000).withOpacity(0.6),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          _total_carts[i]['storeName'],
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width * 0.04),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: size.height * .29,
                                    bottom: size.height * .06,
                                    child: Container(
                                      child: RatingBarIndicator(
                                        rating: double.parse(_total_carts[i]["rat"]
                                            .toString()),
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: size.width * 0.08,
                                        direction: Axis.horizontal,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 5,
                                    child: Container(
                                      width: size.width*0.0,
                                      child: MaterialButton(
                                        onPressed: (){},
                                        child: Text('Add To Cart'),
                                      ),
                                    ),
                                  )
                                  // Positioned(
                                  //   right: size.height * .01,
                                  //   bottom: size.height * .039,
                                  //   child: Text(
                                  //     snapshot.data!.docs[i]['price'],
                                  //     style: TextStyle(
                                  //         fontFamily: 'Pacifico',
                                  //         color: Colors.green.shade200,
                                  //         fontWeight: FontWeight.bold,
                                  //         fontSize: size.width * 0.05),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, childAspectRatio: 2 / 1),
                  ),
                );
              } else {
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                );
              }
            }),
      ],
    );
  }
}

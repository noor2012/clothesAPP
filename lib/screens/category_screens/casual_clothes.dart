import 'package:clothesapp/screens/details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CasualClothes extends StatefulWidget {
  const CasualClothes({Key? key}) : super(key: key);

  @override
  _CasualClothesState createState() => _CasualClothesState();
}

class _CasualClothesState extends State<CasualClothes> {

  List _products = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Casual Clothes',
          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Cairo', fontSize: size.width * 0.06),
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream:
            FirebaseFirestore.instance.collection('casual clothesMen').snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: size.height,
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, i) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> DetailsScreen(
                              product: snapshot.data!.docs[i]['product-img'],
                              title: snapshot.data!.docs[i]['title'],
                              storeName: snapshot.data!.docs[i]['storeName'],
                              des: snapshot.data!.docs[i]['des'],
                              rat: snapshot.data!.docs[i]['rat'],
                              discount: snapshot.data!.docs[i]['discount'],
                              price: snapshot.data!.docs[i]['price'],
                            )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                            ),
                            margin: EdgeInsets.only(left: 8, right: 8,bottom: 5),
                            width: size.width * 0.8,
                            height: size.height,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Card(
                                child: Stack(
                                  children: [
                                    Image.network(
                                      snapshot.data!.docs[i]['img'],
                                      fit: BoxFit.fill,
                                      height: size.height ,
                                      width: size.width * .5,
                                    ),
                                    Positioned(
                                      left: size.height * .30,
                                      bottom: size.height * .12,
                                      child: Text(
                                        snapshot.data!.docs[i]['title'],
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
                                            snapshot.data!.docs[i]['discount'],
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
                                        snapshot.data!.docs[i]['price'],
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
                                            snapshot.data!.docs[i]['storeName'],
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
                                          rating: double.parse(snapshot.data!
                                              .docs[i]["rat"].toString()),
                                          itemBuilder:
                                              (context, index) =>
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                          itemCount: 5,
                                          itemSize: size.width * 0.08,
                                          direction: Axis.horizontal,
                                        ),
                                      ),
                                    ),
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
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 2/1),
                  ),
                );
              } else {
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                );
              }
            }),
      ),

    );
  }
}

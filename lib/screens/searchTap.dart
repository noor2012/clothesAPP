import 'package:clothesapp/screens/details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('search');
  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: TextField(
              onSubmitted: (value) {
                setState(() {
                  _searchString = value;
                });
              },
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: Colors.white, fontSize: size.width * 0.05,fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                  hintText: "Search Here ...",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 17,
                  )),
            ),
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            if (_searchString.isEmpty)
              Center(
                child: Container(
                    child: Text("Search Results",
                        style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.bold))),
              )
            else
              FutureBuilder<QuerySnapshot>(
                future: productsRef.orderBy("title").startAt(
                    [_searchString]).endAt(["$_searchString\uf8ff"]).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error ${snapshot.error}"),
                      ),
                    );
                  }
                  //collection data ready to display
                  if (snapshot.connectionState == ConnectionState.done) {
                    //display the data inside a list view
                    return ListView(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      children: snapshot.data!.docs.map((document) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        productId:document.id,
                                        rat: document['rat'],
                                        storeName: document['storeName'],
                                        title: document['title'],
                                        price: document['price'],
                                        discount: document['discount'],
                                        des: document['des'],
                                        product: document['img'],
                                      )));
                            },
                            child:  Container(
                              margin: EdgeInsets.only(left: 8, right: 8, bottom: 5),
                              width: size.width * 0.8,
                              height: size.height * .24,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Card(
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        document['img'][0],
                                        fit: BoxFit.fill,
                                        height: size.height,
                                        width: size.width * .5,
                                      ),
                                      Positioned(
                                        left: size.height * .29,
                                        bottom: size.height * .12,
                                        child: Text(
                                          document['title'],
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
                                              document['discount'],
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
                                          document['price'],
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
                                          width: size.width * .41,
                                          color: Color(0xFF0000).withOpacity(0.6),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              document['storeName'],
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
                                            rating: double.parse(document["rat"]
                                                .toString()),
                                            itemBuilder: (context, index) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: size.width * 0.07,
                                            direction: Axis.horizontal,
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   bottom: 0,
                                      //   right: 5,
                                      //   child: MaterialButton(
                                      //     onPressed: (){},
                                      //     child: Text('Add To Cart'),
                                      //   ),
                                      // )
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
                      }).toList(),
                    );
                  }
                  //loading state
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 30),
            //   child: CustomInput(
            //     hintText: "Search here...",
            //     onSubmitted: (value){
            //       setState(() {
            //         _searchString = value;
            //       });
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

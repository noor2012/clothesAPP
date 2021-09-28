import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'details_factory.dart';

class FactoryClothes extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Factory Clothes',style:TextStyle(
            fontFamily: 'Cairo',
            fontSize: size.width * 0.07,
            fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF006FFF),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: StreamBuilder<QuerySnapshot>(
            stream:
            FirebaseFirestore.instance.collection('factory').snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    decoration: BoxDecoration(color: Colors.white60),
                    height: size.height ,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, i) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailsFactory(
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
                                      fit: BoxFit.cover,
                                      height: size.height * .29,
                                      width: size.width * .95,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        color: Colors.white.withOpacity(0.7),
                                        height: size.height * .05,
                                        width: size.width * .99,
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
      ),
    );
  }
}

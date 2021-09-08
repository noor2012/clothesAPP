import 'package:clothesapp/screens/category/kids.dart';
import 'package:clothesapp/screens/category/men.dart';
import 'package:clothesapp/screens/category/women.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> Men()));
                },
                child: Container(
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(blurRadius: 3, color: Colors.blueGrey)
                    ],
                  ),
                  width: size.width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: <Widget>[
                          Image.network(
                            'https://www.next.co.uk/nxtcms/resource/image/4263630/portrait_ratio4x5/320/400/20743eb5e7b332ff3b7afa6be08262c6/Wv/men.jpg',
                            fit: BoxFit.cover,
                            width: size.width * 0.5,
                            height: size.height * 0.4,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10, top: 5),
                            child: Text(
                              'Men',
                              style: TextStyle(
                                  fontSize: size.width * 0.07,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> Women()));
                },
                child: Container(
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(blurRadius: 3, color: Colors.blueGrey)
                    ],
                  ),
                  width: size.width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: <Widget>[
                          Image.network(
                            'https://pantaloons.imgix.net/resources/img/pantaloons/mobile/Pantaloons%20Women%2001-02-2021-1400.jpg?w=382&auto=format',
                            fit: BoxFit.cover,
                            width: size.width * 0.5,
                            height: size.height * 0.4,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10, top: 5),
                            child: Text(
                              'Women',
                              style: TextStyle(
                                  fontSize: size.width * 0.07,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 10),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> Kids()));
                },
                child: Container(
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(blurRadius: 3, color: Colors.blueGrey)
                    ],
                  ),
                  width: size.width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: <Widget>[
                          Image.network(
                            'https://www.lifethrumyeyes.com/wp-content/uploads/2021/05/59b014f21400001f00fa8442.jpeg',
                            fit: BoxFit.cover,
                            width: size.width * 0.5,
                            height: size.height * 0.4,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10, top: 5),
                            child: Text(
                              'Kids',
                              style: TextStyle(
                                  fontSize: size.width * 0.07,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}

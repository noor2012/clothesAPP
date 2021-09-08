import 'package:clothesapp/screens/category_screens/casual_clothes.dart';
import 'package:flutter/material.dart';

class Men extends StatefulWidget {
  const Men({Key? key}) : super(key: key);

  @override
  _MenState createState() => _MenState();
}

class _MenState extends State<Men> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Men',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
              fontSize: size.width * 0.06),
        ),
        backgroundColor: Color(0xFF006FFF),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Casual Clothes',
              style: TextStyle(
                  fontSize: size.height * 0.03,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo'),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> CasualClothes()));
            },
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            title: Text(
              'Underwear',
              style: TextStyle(
                  fontSize: size.height * 0.03,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo'),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            title: Text(
              'Sports Clothes',
              style: TextStyle(
                  fontSize: size.height * 0.03,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo'),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            title: Text(
              'Shoes',
              style: TextStyle(
                  fontSize: size.height * 0.03,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo'),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            title: Text(
              'Classic Clothes',
              style: TextStyle(
                  fontSize: size.height * 0.03,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo'),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            title: Text(
              'Accessories',
              style: TextStyle(
                  fontSize: size.height * 0.03,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo'),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

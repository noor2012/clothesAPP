import 'package:flutter/material.dart';

class Women extends StatefulWidget {
  const Women({Key? key}) : super(key: key);

  @override
  _WomenState createState() => _WomenState();
}

class _WomenState extends State<Women> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Women',
          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Cairo', fontSize: size.width * 0.06),
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
                  fontFamily: 'Cairo'
              ),
            ),
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
                  fontFamily: 'Cairo'
              ),
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
                  fontFamily: 'Cairo'
              ),
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
                  fontFamily: 'Cairo'
              ),
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
                  fontFamily: 'Cairo'
              ),
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
                  fontFamily: 'Cairo'
              ),
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

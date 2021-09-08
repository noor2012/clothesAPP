import 'package:clothesapp/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          ListTile(
            title: Text(
              'Home Page',
              style: TextStyle(
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo'),
            ),
            leading: Icon(
              Icons.home,
              color: Colors.black87,
              size: size.width * 0.08,
            ),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          ListTile(
            title: Text(
              'Categories',
              style: TextStyle(
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo'),
            ),
            leading: Icon(
              Icons.view_list_sharp,
              color: Colors.black87,
              size: size.width * 0.08,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          ListTile(
            title: Text('Cart',
                  style: TextStyle(
              fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo'),
            ),
            leading: Icon(Icons.shopping_cart,color: Colors.black87,size: size.width * 0.08,),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          ListTile(
            title: Text('Language',
              style: TextStyle(
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo'),
            ),
            leading: Icon(Icons.language,color: Colors.black87,size: size.width * 0.08,),
          ),
          // SizedBox(
          //   height: size.height * 0.01,
          // ),
          // ListTile(
          //   title: Text('Favorite',
          //     style: TextStyle(
          //         fontSize: size.width * 0.05,
          //         fontWeight: FontWeight.bold,
          //         fontFamily: 'Cairo'),
          //   ),
          //   leading: Icon(Icons.favorite,color: Color(0xFF0000).withOpacity(0.8),size: size.width * 0.08,),
          // ),
          SizedBox(
            height: size.height * 0.01,
          ),
          ListTile(
            title: Text(
              'Contact With Us',
              style: TextStyle(
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo'),
            ),
            leading: Icon(
              Icons.contact_support,
              color: Colors.black87,
              size: size.width * 0.08,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          ListTile(
            title: Text('Sign Out',
              style: TextStyle(
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo'),
            ),
            leading: Icon(Icons.exit_to_app,color: Colors.black87,size: size.width * 0.08,),
            onTap: () {
              auth.signOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SigninScreen()));
            },
          ),
        ],
      ),
    );
  }
}

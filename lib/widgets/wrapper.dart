import 'package:clothesapp/screens/homePage.dart';
import 'package:clothesapp/screens/login.dart';
import 'package:clothesapp/service/auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final auth= Auth();
    if(auth != null){
      return HomePage();
    }else{
      return SigninScreen();
    }
  }
}

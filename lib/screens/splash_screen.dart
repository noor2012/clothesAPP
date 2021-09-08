import 'dart:async';
import 'package:clothesapp/widgets/wrapper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Wrapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF006FFF),
                Color(0xFF005FFF),
                Color(0xFF006FFF),
              ]),
        ),
        child: Center(
          child: Text(
            'Go Fashion',
            style: TextStyle(
                fontFamily: 'pacifico',
                fontSize: size.width * 0.10,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
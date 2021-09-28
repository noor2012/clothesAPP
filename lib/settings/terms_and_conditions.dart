import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../screens/homePage.dart';

class TermsAndCond extends StatefulWidget {

  @override
  _TermsAndCondState createState() => _TermsAndCondState();
}

class _TermsAndCondState extends State<TermsAndCond> {

  String _url = "https://drive.google.com/file/d/14xdS-KCR8mIOgt2wytYFK90rR9ZQkwzD/view";


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              languageName=="ar"?"الشروط و الاحكام":'Terms And Conditions',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: size.width * 0.07,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Color(0xFF006FFF),
          ),
       backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top:size.height*0.03),
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height*0.3,
            ),
            InkWell(
              onTap: ()async{
                // _launchURL();
              },
              child: Text(languageName=="ar"?"قرأة الشروط و الاحكام":"Read Terms And Conditions",
              textAlign: TextAlign.center,style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                  fontSize: size.width*0.04
                ),),
            ),
            SizedBox(
              height: size.height*0.1,
            ),
            MaterialButton(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.2,vertical: size.height*0.01),
              color: Color(0xFF0000).withOpacity(0.6),
              onPressed: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isAccepted', true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
            child: Text(languageName=="ar"?"اقبل":"Accept",style: TextStyle(
              color: Colors.white,
              fontSize: size.width*0.07,
            ),),
            )
          ],
        ),
      ),
    ));
  }
  //
  // void _launchURL() async =>
  //     await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}

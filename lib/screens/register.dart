import 'package:clothesapp/screens/homePage.dart';
import 'package:clothesapp/screens/login.dart';
import 'package:clothesapp/widgets/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key,}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> globalKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoding = false;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF006FFF),
                  Color(0xFF008FFF),
                  Color(0xFF006FFF),
            ]),
        ),
        child: Form(
          key: globalKey,
          child: Stack(
            children: [
              // Container(
              //   height:size.height ,
              //   width: size.width,
              //   child:Image.asset("images/Screenshot - 03_08_2021 , 06_05_11 م.png",fit: BoxFit.fill,) ,
              // ),
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.14,
                        ),
                        Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontStyle: FontStyle.italic,
                              fontSize: size.width * 0.13,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        CustomTextField(
                          errortext: 'E-mail can not be empty!',
                          controller: email,
                          text: "E-mail",
                          iconData: Icons.email,
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        CustomTextField(
                          errortext: 'Password can not be empty!',
                          controller: password,
                          text: "Password",
                          iconData: Icons.lock,
                          icon: Icons.remove_red_eye,
                        ),
                        SizedBox(
                          height: size.height * 0.09,
                        ),
                        MaterialButton(
                          elevation: 6,
                          color: Colors.white,
                          padding:
                          const EdgeInsets.symmetric(horizontal: 100.0,vertical: 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: () {
                            if(globalKey.currentState!.validate()){
                              auth.createUserWithEmailAndPassword(email:email.text, password: password.text);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                                  scaffoldKey.currentState!.showSnackBar(
                                  new SnackBar(duration: new Duration(seconds: 4), content:
                                  new Row(
                                    children: <Widget>[
                                      new CircularProgressIndicator(),
                                      new Text("please wait...")
                                    ],
                                  ),
                                  ),
                              );
                            }
                            // if (globalKey.currentState!.validate()) {
                            //   globalKey.currentState!.save();
                            //   try {
                            //     auth.SignIn(
                            //         email.text, password.text);
                            //
                            //     Navigator.pushReplacement(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 HomePage()));
                            //   } catch (e) {
                            //     Scaffold.of(context).showSnackBar(SnackBar(
                            //       backgroundColor: Colors.white,
                            //       content: Text(
                            //         "invalid!",
                            //         style: TextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.bold,
                            //             fontSize: 16),
                            //       ),),);
                            //   }
                            // }
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: size.width * 0.06,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.05),
                            ),
                            SizedBox(width: size.width * 0.02,),
                            GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SigninScreen()));
                                },
                                child: Text(
                                  "Signin",
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.05),
                                )),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

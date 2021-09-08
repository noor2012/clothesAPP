import 'package:clothesapp/screens/homePage.dart';
import 'package:clothesapp/screens/register.dart';
import 'package:clothesapp/widgets/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key,}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormState> globalKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final auth = Auth();
    bool isLodaing = false;
    FirebaseAuth auth =FirebaseAuth.instance;

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
              // Color(0xFFFF8F00),
            ])),
        child: Form(
          key: globalKey,
          child:ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.16,
                    ),
                    // Container(
                    //   height: size.height * .2,
                    //   width: size.width * .85,
                    //
                    //   // child: SvgPicture.asset("images/undraw_portfolio_feedback_6r17.svg")
                    // ),
                    Text(
                      "Login",
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
                      controller: email,
                      errortext: 'E-mail can not be empty!',
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
                      height: size.height * 0.07,
                    ),
                    isLodaing
                        ? Container(
                      width: size.width * 0.2,
                      height: size.width * 0.2,
                      child: Center(child: CircularProgressIndicator()),
                    )
                        :
                     MaterialButton(
                        elevation: 6,
                        color: Colors.white,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 120.0,vertical: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          if(globalKey.currentState!.validate()){
                            auth.signInWithEmailAndPassword(email:email.text, password: password.text);
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
                          //     auth.Signin(
                          //         email.text, password.text);
                          //
                          //     Navigator.pushReplacement(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 HomePage()));
                          //   } catch (e) {
                          //     Scaffold.of(context).showSnackBar(SnackBar(
                          //         backgroundColor: Colors.white,
                          //         content: Text(
                          //           "invalid!",
                          //           style: TextStyle(
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold,
                          //               fontSize: 16),
                          //         ),
                          //     ),
                          //     );
                          //   }
                          // }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: size.width * 0.06,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Do not have an account ?",
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.05),
                        ),
                        SizedBox(width: size.width * 0.02,),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                            },
                            child: Text(
                              "Sign Up",
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

        ),
      )
    );
  }
}

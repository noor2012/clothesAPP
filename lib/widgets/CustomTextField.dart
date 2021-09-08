 import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? text;
  final String? errortext;
  final String? errorstyletext;
  final IconData? iconData;
  final IconData? icon;
  final TextEditingController controller;


  const CustomTextField({Key? key, this.text,this.errortext,this.errorstyletext, this.iconData, this.icon, required this.controller}) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool cc = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      validator: ( val)
      {
        if(val!.isEmpty&&widget.text=="E-mail")
        {
          return "invaled email";
        }else if(val.isEmpty&&widget.text=="Password")
        {
          return "invaled password";
        }else if(val.isEmpty&&widget.text=="Name")
        {
          return "invaled Name";
        }
      },


      obscureText:cc? widget.text=="Password"?false:true:widget.text=="Password"?true:false ,
      controller: widget.controller,

      cursorColor: Colors.white,

      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        errorText: widget.errortext,
        errorStyle: TextStyle(
          color: Colors.white,
          fontSize: 14
        ),
        labelText: widget.text,
        prefixIcon:Icon(widget.iconData,color: Colors.white,) ,
        suffixIcon:GestureDetector(
            onTap: ()
            {
              setState(() {
                cc=!cc;
              });
            },
            child: Icon(widget.icon,color: Colors.grey[900],)) ,
        labelStyle: TextStyle(color: Colors.white,fontFamily: 'Cairo',fontSize: 20),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}

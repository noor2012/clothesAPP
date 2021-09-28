import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedValue = "ar";
  late SharedPreferences _preferences;

  @override
  void initState() {

    super.initState();
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
      selectedValue = _preferences.getString("languageName") ?? 'ar';
      print(selectedValue);
    }).whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Directionality(
      textDirection:
          languageName == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Language',
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: size.width * 0.07,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFF006FFF),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: size.height * 0.3,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  languageName == "ar" ? "اختار اللغة" : 'Select language',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      languageName == "ar" ? "العربية" : "Arabic",
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Radio(
                      activeColor: Colors.green[700],
                      groupValue: selectedValue,
                      value: "ar",
                      onChanged: (value) {
                        setState(() {
                          // selectedValue = value;
                          // _preferences.setString(value,"languageName");
                        });
                      },
                    ),
                    Text(
                      languageName == "ar" ? "الانجليزية" : "English",
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Radio(
                      activeColor: Colors.green[700],
                      groupValue: selectedValue,
                      value: "en",
                      onChanged: (value) {
                        setState(() {
                          // value = selectedValue;
                          // _preferences.setString(selectedValue,"languageName");
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                MaterialButton(
                  onPressed: () {
                    Phoenix.rebirth(context);
                  },
                  height: size.height * 0.06,
                  minWidth: size.width * 0.6,
                  color: Colors.green[700],
                  child: Text(
                    languageName == "ar" ? "اعادة التشغبل" : "Restart app",
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

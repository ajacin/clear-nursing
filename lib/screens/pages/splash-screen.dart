import 'package:flutter/material.dart';
import 'package:clearnursing/screens/pages/home-page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clearnursing/screens/pages/google-sign-in.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<String> currentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("pullign pref------------->");
    print(preferences.getString("user"));
    var image = await preferences.getString("imageUrl");
    var userid = await preferences.getString("uid");
    // imageUrl = await preferences.getString("imageUrl");
    // uid=preferences.getString("uid");
    if (image != null && userid != null) {
      //name will be checked later
      imageUrl = image;
      uid = userid;
      return preferences.getString("user");
    } else if (image == null && userid == null) {
      return null;
    }
  }

  @override
  initState() {
    currentUser()
        .then((result) => {
              print('result to be printed'),
              print(result),
              if (result == null){
                  Timer(Duration(seconds: 5), () {
 Navigator.pushReplacementNamed(context, "/login");
})
                  
                  }
              // else{
              //   Navigator.pushReplacementNamed(context, "/login")
              // }
              else{
                  print("user logged " + result),
                  name = result,
                  Timer(Duration(seconds: 5), () {
 Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                title: "Clear Nursing",
                                // uid: authResult.user.uid,
                              )));
})
                  
                }
            })
        .catchError((err) => print(err));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Icon(
                Icons.local_hospital,
                color: Theme.of(context).highlightColor,
                size: 55,
              ),
              Text(
                "Clear Nursing",
                style: GoogleFonts.megrim(
                  textStyle: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .5),
                ),
              ),
            ])),
      ),
    );
  }
}

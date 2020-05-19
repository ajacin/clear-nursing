import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clearnursing/screens/pages/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clearnursing/screens/pages/SIgnIn.dart';


class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  initState() {
    Future<String> currentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("pullign pref------------->");
    print(preferences.getString("user"));
    imageUrl = preferences.getString("imageUrl");
    uid=preferences.getString("uid");
    return preferences.getString("user");
    // return null;
  }
        currentUser()
        .then((result) => {
          print('result to be printed'),
          print(result),
              if (result == null)
                {Navigator.pushReplacementNamed(context, "/login")}
              // else{
              //   Navigator.pushReplacementNamed(context, "/login")
              // }
              else
                {
                  print("user logged "+result),
                  name = result,
                  Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        title: "Clear Nursing",
                                        // uid: authResult.user.uid,
                                      )))
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
            children:<Widget>[
              Icon(Icons.local_hospital),
              Text("Clear Nursing",
        style: GoogleFonts.roboto(
          fontSize: 25.0,
          fontWeight: FontWeight.bold),)
            ]
          )
        ),
      ),
    );
  }
}
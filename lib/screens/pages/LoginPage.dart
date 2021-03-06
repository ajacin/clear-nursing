import 'package:flutter/material.dart';
import 'package:clearnursing/screens/pages/FIrstScreen.dart';
import 'package:clearnursing/screens/pages/HomePage.dart';
import 'package:clearnursing/screens/pages/SIgnIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity/connectivity.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _loginStatusMessage = "";

  @override
  void initState() {
    super.initState();
  }

  Future<int> checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return 1;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return 1;
    } else {
      return 0;
    }
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
        final network = await checkNetwork();
        print(network);
        if (network == 0) {
          setState(() {
            _loginStatusMessage = "No network connection";
          });
        }
        try {
          signInWithGoogle().whenComplete(() {
            print('completed signIn');
            print(name);
            print(imageUrl);
            print(email);
            if (name != null && imageUrl != null && email != null) {
              saveSharedPref();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return HomePage(title: "Clear Nursing");
                  },
                ),
              );
            }
          });
        } catch (e) {
          print(e);
          print('exception');
          _signInButton();
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image(
                      image: AssetImage(
                        'assets/google.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 20,
                  width: 25,
                ),
                Text(
                  'Continue with Google',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> saveSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('imageUrl', imageUrl);
    await preferences.setString('uid', uid);
    return await preferences.setString('user', name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    Icon(Icons.local_hospital),
                    Text(
                      "Clear Nursing",
                      style: GoogleFonts.roboto(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    )
                  ])),
              SizedBox(height: 150),
              _signInButton(),
              Text(_loginStatusMessage,
              style: TextStyle(
                color:Colors.red,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}

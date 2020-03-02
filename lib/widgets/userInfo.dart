import 'package:flutter/material.dart';
import 'package:clearnursing/screens/pages/FIrstScreen.dart';
import 'package:clearnursing/screens/pages/HomePage.dart';
import 'package:clearnursing/screens/pages/SIgnIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  // Widget _signInButton() {
  //   return OutlineButton(
  //     splashColor: Colors.grey,
  //     onPressed: () {
  //       signInWithGoogle().whenComplete(() {
  //         saveSharedPref();
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (context) {
  //               return HomePage(title: "Clear Nursing");
  //             },
  //           ),
  //         );
  //       });
  //     },
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //     highlightElevation: 0,
  //     borderSide: BorderSide(color: Colors.grey),
  //     child: Padding(
  //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           // Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 10),
  //             child: Text(
  //               'Sign in with Google',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future<bool> saveSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('user', name);
  }

  Future<String> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("name");
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
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 40,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 50),
              Text(name),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                    children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 15,bottom: 5),
                      child: Text('Current Score',
                      style: TextStyle(
                        color: Colors.black54
                      ),),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text("332",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16
                      ),),
                    )
                  ],
                  ),
                  Column(
                    children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 15,bottom: 5),
                      child: Text('Current Score',
                      style: TextStyle(
                        color: Colors.black54
                      ),),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text("332",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16
                      ),),
                    )
                  ],
                  ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

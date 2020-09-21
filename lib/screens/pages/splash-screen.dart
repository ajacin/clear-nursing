import 'package:flutter/material.dart';
import 'package:clearnursing/screens/pages/home-page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clearnursing/screens/pages/google-sign-in.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  StreamSubscription iosSubscription; //this is for ios

  Future<String> currentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
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
      return null; // remove if this is causing problems
    }
    return null;
  }

  @override
  initState() {
    currentUser()
        .then((result) => {
              print('result to be printed'),
              print(result),
              if (result == null)
                {
                  Timer(Duration(seconds: 5), () {
                    Navigator.pushReplacementNamed(context, "/login");
                  })
                }
              // else{
              //   Navigator.pushReplacementNamed(context, "/login")
              // }
              else
                {
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
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        print(data);
        _saveDeviceToken();
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      _saveDeviceToken();
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // final snackbar = SnackBar(
        //   content: Text(message['notification']['title']),
        //   action: SnackBarAction(
        //     label: 'Go',
        //     onPressed: () => null,
        //   ),
        // );

        // Scaffold.of(context).showSnackBar(snackbar);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.amber,
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
  }

  @override
  void dispose() {
    if (iosSubscription != null) iosSubscription.cancel();
    super.dispose();
  }

  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    // Get the current user
    String uid = 'jeffd23';
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('users')
          .document(uid)
          .collection('tokens')
          .document(fcmToken);

      await tokens.setData({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }

  /// Subscribe the user to a topic
  _subscribeToTopic() async {
    // Subscribe the user to a topic
    _fcm.subscribeToTopic('puppies');
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

import 'package:flutter/material.dart';
import 'package:clearnursing/screens/pages/FIrstScreen.dart';
import 'package:clearnursing/screens/pages/HomePage.dart';
import 'package:clearnursing/screens/pages/SIgnIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clearnursing/screens/pages/LoginPage.dart';
import 'package:clearnursing/screens/pages/AboutDeveloper.dart';

class Settings extends StatelessWidget {
  static final String path = "lib/src/pages/settings/settings2.dart";
  // final TextStyle whiteText = TextStyle(
  //   color: Theme.of(context).primaryColor,
  // );
  // final TextStyle greyTExt = TextStyle(
  //   color: Theme.of(context).accentColor,
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Theme(
        data: Theme.of(context).copyWith(
          brightness: Brightness.dark,
          primaryColor: Theme.of(context).highlightColor,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: Theme.of(context).highlightColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ListTile(
                  title: Text("Theme"),
                  subtitle: Text(
                    "System Default",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Theme.of(context).accentColor,
                  ),
                  onTap: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Theme automatically changes according to your device\'s dark mode settings.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Theme.of(context).highlightColor,
                    ));
                  },
                ),
                ListTile(
                  title: Text("Profile Settings"),
                  subtitle: Text(
                    name,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Theme.of(context).accentColor,
                  ),
                  onTap: () {},
                ),
                SwitchListTile(
                  title: Text("Notify updates"),
                  subtitle: Text(
                    "On",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  value: true,
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  title: Text("Practice reminder"),
                  subtitle: Text(
                    "Off",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  value: false,
                  onChanged: (val) {},
                ),
                ListTile(
                  title: Text("About"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutDeveloper()),
                    );
                  },
                ),
                ListTile(
                  title: Text("Logout"),
                  onTap: () {
                    signOutGoogle();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }), ModalRoute.withName('/'));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

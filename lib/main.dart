import 'package:clearnursing/screens/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clearnursing/screens/pages/HomePage.dart';
import 'package:clearnursing/screens/pages/SplashPage.dart';

void main() => runApp(ClearNursing());

class ClearNursing extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.white,
            accentColor: Colors.black,
            errorColor: Colors.red[800],
            highlightColor: Color(0xFFFF4F79),
            accentColorBrightness: Brightness.light
            ),
        darkTheme: ThemeData(
            brightness: Brightness.dark, 
            primaryColor: Colors.black87,
            accentColor: Colors.grey,
            errorColor: Colors.red[800],
            highlightColor: Color(0xFFFF4F79),
            accentColorBrightness: Brightness.dark),
        home: SplashPage(),
        routes: <String, WidgetBuilder>{
          // '/task': (BuildContext context) => TaskPage(title: 'Task'),
          '/home': (BuildContext context) => HomePage(title: 'Home'),
          '/login': (BuildContext context) => LoginPage(),
          // '/register': (BuildContext context) => RegisterPage(),
        });
  }
}

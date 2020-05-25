import 'package:clearnursing/screens/pages/login-page.dart';
import 'package:flutter/material.dart';
import 'package:clearnursing/screens/pages/home-page.dart';
import 'package:clearnursing/screens/pages/splash-screen.dart';

void main() => runApp(ClearNursing());

class ClearNursing extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Clear Nursing',
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
            primaryColor: Color(0xff1b262c),
            accentColor: Color(0xffbbe1fa),
            errorColor: Colors.red[800],
            highlightColor: Color(0xff3282b8),
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

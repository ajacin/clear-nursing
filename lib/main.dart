import 'package:clearnursing/screens/pages/login-page.dart';
import 'package:flutter/material.dart';
import 'package:clearnursing/screens/pages/home-page.dart';
import 'package:clearnursing/screens/pages/splash-screen.dart';
void main() => runApp(ClearNursing());

class ClearNursing extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _ClearNursingState createState() => _ClearNursingState();
}

class _ClearNursingState extends State<ClearNursing> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Clear Nursing',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xffFFFFFF),
            accentColor: Color(0xff00147A),
            errorColor: Colors.red[800],
            highlightColor: Color(0xFF1C83F1),
            accentColorBrightness: Brightness.light),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Color(0xff333A54),
            accentColor: Color(0xffFFFFFF),
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

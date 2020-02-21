import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clearnursing/screens/pages/home.dart';

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
          accentColorBrightness: Brightness.dark),
      home: HomeScreen(title: 'Clear Nursing'),
    );
  }
}

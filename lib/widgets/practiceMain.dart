import 'package:flutter/material.dart';
import 'package:clearnursing/screens/pages/FIrstScreen.dart';
import 'package:clearnursing/screens/pages/HomePage.dart';
import 'package:clearnursing/screens/pages/SIgnIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clearnursing/widgets/IconTextWidget.dart';

class practiceMain extends StatefulWidget {
  @override
  _practiceMainState createState() => _practiceMainState();
}

class _practiceMainState extends State<practiceMain> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Select a Category',
                style: GoogleFonts.roboto(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconTextWidget(text: "Fundamental Skills"),
                    IconTextWidget(text: "Nursing Sciences"),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconTextWidget(text: "Pediatric Nursing"),
                    IconTextWidget(text: "Maternity Nursing"),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class IconTextWidget extends StatefulWidget {
  IconTextWidget({this.icon,this.text});
  final String icon;
  final String text;
  @override
  _IconTextWidgetState createState() => _IconTextWidgetState();
}

class _IconTextWidgetState extends State<IconTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(
                  1.0,
                  4.0,
                ),
              )
            ],
          ),
          height: 60,
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.local_hospital,
                size: 30,
              ),
              Text(widget.text),
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';

class FeatureRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Text('AJ'),
            ),
            const SizedBox(height: 20.0),
            Text(
              "Have a new idea for us?",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              "Something bothering you?",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                  "If you have a suggestion for how to improve or enhance this application, your input is always welcome."),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                  "Is Clear-Nursing missing something you need? Is there a behavior quirk that is causing you lots of headaches? Let us know! "),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                  "clearnursing@ajac.in"),
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Back to Clear Nursing',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: <Widget>[
      //     FloatingActionButton.extended(
      //       onPressed: () {
      //         // Add your onPressed code here!
      //       },
      //       label: Text('Rate us on playstore'),
      //       icon: Image(
      //                 image: AssetImage(
      //                   'assets/play.png',
      //                 ),
      //                 height: 30,
      //                 // fit: BoxFit.cover,
      //               ),
      //       backgroundColor: Theme.of(context).accentColor,
      //     ),
      //     const SizedBox(height: 20.0),
      //   ],
      // ),
    );
  }
}

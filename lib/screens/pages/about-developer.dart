import 'package:flutter/material.dart';

class AboutDeveloper extends StatelessWidget {
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
              "ARUN JACOB",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                  "Clear-Nursing application provides handy access to a handful of picked questions to brush up knowledge related to the nursing subject. As a developer, I have tried to provide easy to use features with a no-nonsense approach. "),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                  "I am a software and application developer based in India. Your support is the essential fuel that drives me to contribute more. If you liked this application, spend some time to review this application in the Playstore. Kindly share your valuable suggestions and feedback directly using the form below."),
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            onPressed: () {
              // Add your onPressed code here!
            },
            label: Text('Rate us on playstore'),
            icon: Image(
                      image: AssetImage(
                        'assets/play.png',
                      ),
                      height: 30,
                      // fit: BoxFit.cover,
                    ),
            backgroundColor: Theme.of(context).accentColor,
          ),
          const SizedBox(height: 20.0),
          // FloatingActionButton.extended(
          //   onPressed: () {
          //     // Add your onPressed code here!
          //   },
          //   label: Text('Buy me a coffee today!'),
          //   icon: Padding(
          //     padding: const EdgeInsets.only(left:8.0,right: 7.0),
          //     child: Icon(
          //       FontAwesomeIcons.coffee,
          //       size: 15.0,
          //       color: Theme.of(context).primaryColor,
          //     ),
          //   ),
          //   backgroundColor: Theme.of(context).accentColor,
          // ),
        ],
      ),
    );
  }
}

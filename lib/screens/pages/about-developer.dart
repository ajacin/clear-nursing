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
              "ARJACOB/JIROY",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                  "Clear-Nursing application provides access to a handful of carefully picked questions to brush up your knowledge in the nursing subjects. A no-nonsense approach is the primary focus of development. You, as a user, can focus on the questions. Your feedbacks are important for us to provide more quality contents."),
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

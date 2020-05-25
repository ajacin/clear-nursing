import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clearnursing/widgets/practice-main.dart';
import 'package:clearnursing/widgets/settings.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  Future<String> loadSharedPrefData(key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
}
  @override
  _HomePageState createState() => _HomePageState(
  );
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    // Text(
    //   name
    // ),
    PracticeMain(),
    Settings()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        titleSpacing: 0.0,
        leading: Icon(Icons.local_hospital),
        title: Text(
          widget.title,
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.school),
          //   title: Text('Learn'),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            title: Text('Questions'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).highlightColor,
        onTap: _onItemTapped,
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   label: Text('Take a Test'),
      //   icon: Icon(Icons.dvr),
      // ), // This traili
    );
  }
}

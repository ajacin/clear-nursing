import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
  Text(
    'Index 0: LEARN1',
  ),
  Text(
     'Index 1: PRACTICE',
  ),
  Text(
     'Index 2: MORE',
  ),
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
        title: Text(widget.title,
        style: GoogleFonts.roboto(
          fontSize: 25.0,
          fontWeight: FontWeight.bold),),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child:_widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('Learn'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text('Practice'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_vert),
          title: Text('More'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).highlightColor,
      onTap: _onItemTapped,
    ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Take a Test'),
        icon: Icon(Icons.dvr),
      ), // This traili
    );
  }
}

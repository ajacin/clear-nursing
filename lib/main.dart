import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      home: MyHomePage(title: 'Clear Nursing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
  Text(
    'Index 0: LEARN',
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
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
        onPressed: _incrementCounter,
        label: Text('Take a Test'),
        icon: Icon(Icons.dvr),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

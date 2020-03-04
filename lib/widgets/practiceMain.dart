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



class practiceMain extends StatefulWidget {
  @override
  _practiceMainState createState() => _practiceMainState();
}

class _practiceMainState extends State<practiceMain> {

  bool isSwitched = true;

  Future<bool> saveSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('user', name);
  }

  Future<String> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("name");
  }

  Future<List<Note>> _getNotes() async {
    var data = await http
        .get('https://my-json-server.typicode.com/ajacin/data/notedetails');
    var jsonData = json.decode(data.body);

    List<Note> notes = [];
    for (var n in jsonData) {
      Note note = Note(n["id"], n["title"], n["note"], n["completed"], n["important"]);
      notes.add(note);
    }
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Select a Category',
                style: GoogleFonts.roboto(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              FutureBuilder(
              future: _getNotes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AwesomeLoader(
                          loaderType: AwesomeLoader.AwesomeLoader3,
                          color: Colors.green,
                        ),
                        Text("Loading Notes/Tasks"),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: const Card(child: Text('ajacin')),
                        )
                      ],
                    )),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.error,
                            color: snapshot.data[index].important
                                ? Colors.red
                                : Colors.white,
                          ),
                          title: Text(snapshot.data[index].title),
                          subtitle: Text(snapshot.data[index].note),
                          trailing: Icon(
                            Icons.done_outline,
                            color: snapshot.data[index].completed
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class Note {
  final int id;
  final String title;
  final String note;
  final bool completed;
  final bool important;

  Note(this.id, this.title, this.note, this.completed,this.important);
}
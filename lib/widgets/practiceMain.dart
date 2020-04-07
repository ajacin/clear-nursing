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
import 'package:cloud_firestore/cloud_firestore.dart';

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  snapshot.shuffle();
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Record.fromSnapshot(data);

  return Padding(
    key: ValueKey(record.question),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color: Theme.of(context).accentColor),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0, // soften the shadow
              spreadRadius: 2.0, //extend the shadow
              offset: Offset(
                2.0, // Move to right 10  horizontally
                2.0, // Move to bottom 10 Vertically
              ),
            )
          ],
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(record.hashCode.toString()),
                Icon(
                  Icons.bookmark_border,
                  color: Colors.blueAccent,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(record.question),
            ),
            Card(
              key: ValueKey(record.question),
              child: ListTile(
                leading: Icon(Icons.arrow_right),
                title: Text(record.option1),
                onTap: () {
                  // record.reference.updateData({'remarks': "This remarks updated"});
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(record.question),
                          actions: [
                            FlatButton(
                              child: Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                          content: Column(children: <Widget>[
                            Card(
                              color: record.answer == 1
                                  ? Colors.green[100]
                                  : Colors.redAccent[100],
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option1),
                              ),
                            ),
                            Card(
                              color: record.answer == 2
                                  ? Colors.green[100]
                                  : Colors.white,
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option2),
                              ),
                            ),
                            Card(
                              color: record.answer == 3
                                  ? Colors.green[100]
                                  : Colors.white,
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option3),
                              ),
                            ),
                            Card(
                              color: record.answer == 4
                                  ? Colors.green[100]
                                  : Colors.white,
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option4),
                              ),
                            ),
                            SizedBox(height: 40),
                            Text(record.remarks)
                          ]),
                        );
                      });

                  // Scaffold.of(context).dialog;
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.arrow_right),
                title: Text(record.option2),
                onTap: () {
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(record.question),
                          actions: [
                            FlatButton(
                              child: Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                          content: Column(children: <Widget>[
                            Card(
                              color: record.answer == 1
                                  ? Colors.green[100]
                                  : Colors.white,
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option1),
                              ),
                            ),
                            Card(
                              color: record.answer == 2
                                  ? Colors.green[100]
                                  : Colors.redAccent[100],
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option2),
                              ),
                            ),
                            Card(
                              color: record.answer == 3
                                  ? Colors.green[100]
                                  : Colors.white,
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option3),
                              ),
                            ),
                            Card(
                              color: record.answer == 4
                                  ? Colors.green[100]
                                  : Colors.white,
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option4),
                              ),
                            ),
                            SizedBox(height: 40),
                            Text(record.remarks)
                          ]),
                        );
                      });

                  // Scaffold.of(context).dialog;
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.arrow_right),
                title: Text(record.option3),
                onTap: () {
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(record.question),
                          actions: [
                            FlatButton(
                              child: Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                          content: Column(children: <Widget>[
                            Card(
                              color: record.answer == 1
                                  ? Colors.green[100]
                                  : Colors.white,
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option1),
                              ),
                            ),
                            Card(
                              color: record.answer == 2
                                  ? Colors.green[100]
                                  : Colors.white,
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option2),
                              ),
                            ),
                            Card(
                              color: record.answer == 3
                                  ? Colors.green[100]
                                  : Colors.redAccent[100],
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option3),
                              ),
                            ),
                            Card(
                              color: record.answer == 4
                                  ? Colors.green[100]
                                  : Colors.white,
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option4),
                              ),
                            ),
                            SizedBox(height: 40),
                            Text(record.remarks)
                          ]),
                        );
                      });

                  // Scaffold.of(context).dialog;
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.arrow_right),
                title: Text(record.option4),
                onTap: () {
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(record.question),
                          actions: [
                            FlatButton(
                              child: Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                          content: Column(children: <Widget>[
                            Card(
                              color: record.answer == 1
                                  ? Colors.green[100]
                                  : Colors.white,
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option1),
                              ),
                            ),
                            Card(
                              color: record.answer == 2
                                  ? Colors.green[100]
                                  : Colors.white,
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option2),
                              ),
                            ),
                            Card(
                              color: record.answer == 3
                                  ? Colors.green[100]
                                  : Colors.white,
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option3),
                              ),
                            ),
                            Card(
                              color: record.answer == 4
                                  ? Colors.green[100]
                                  : Colors.redAccent[100],
                              child: ListTile(
                                leading: Icon(Icons.arrow_right),
                                title: Text(record.option4),
                              ),
                            ),
                            SizedBox(height: 40),
                            Text(record.remarks)
                          ]),
                        );
                      });

                  // Scaffold.of(context).dialog;
                },
              ),
            ),
          ],
        )
        //  child: ListTile(
        //    title: Text(record.question),
        //    trailing: Text(record.option1.toString()),
        //    onTap: () => print(record),
        //  ),
        ),
  );
}

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
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('questions').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();

              return _buildList(context, snapshot.data.documents);
            },
          ),
        ),
      ),
    );
  }
}

class Record {
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final int answer;
  final String remarks;

  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['question'] != null),
        assert(map['option1'] != null),
        assert(map['option2'] != null),
        assert(map['option3'] != null),
        assert(map['option4'] != null),
        assert(map['answer'] != null),
        assert(map['remarks'] != null),
        question = map['question'],
        option1 = map['option1'],
        option2 = map['option2'],
        option3 = map['option3'],
        option4 = map['option4'],
        answer = map['answer'],
        remarks = map['remarks'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$question:$option1>";
}

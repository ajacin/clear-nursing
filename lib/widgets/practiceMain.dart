import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot, int length) {
  snapshot.shuffle();
  print("Length is");
  print(length);
  int serial=1;
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data,length, serial++)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data, length,serial) {
  final record = Record.fromSnapshot(data);
  return Padding(
    key: ValueKey(record.question),
    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
    child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color: Colors.grey[300]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                // Text(record.reference.toString(),
                Icon(
                  Icons.stop,
                  color: Theme.of(context).highlightColor,
                ),
                Text("Q "+serial.toString())
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  record.question,
                  style: TextStyle(
                      color: Colors.blue[500],
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            Card(
              color: Theme.of(context).primaryColor,
              key: ValueKey(record.question),
              child: ListTile(
                leading: Icon(Icons.trip_origin,),
                title: Text(
                  record.option1,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                onTap: () {
                  // record.reference.updateData({'remarks': "This remarks updated"});

                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            record.question,
                            style: TextStyle(
                                color: Colors.blue[500],
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          actions: [
                            OutlineButton(
                              child: Text(
                                "Dismiss",
                                style: TextStyle(
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 10),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                          content: SingleChildScrollView(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Card(
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 1
                                        ? Colors.green
                                        : Colors.red
                                      ),
                                      title: Text(
                                        record.option1,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 2
                                        ? Colors.green
                                        : Colors.grey,),
                                      title: Text(
                                        record.option2,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 3
                                        ? Colors.green
                                        : Colors.grey,),
                                      title: Text(
                                        record.option3,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 4
                                        ? Colors.green
                                        : Colors.grey,),
                                      title: Text(
                                        record.option4,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        );
                      });

                  // Scaffold.of(context).dialog;
                },
              ),
            ),
            Card(
              color: Theme.of(context).primaryColor,
              child: ListTile(
                leading: Icon(Icons.trip_origin),
                title: Text(
                  record.option2,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                onTap: () {
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(record.question),
                          actions: [
                            OutlineButton(
                              child: Text(
                                "Dismiss",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                          content: SingleChildScrollView(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Card(
                                    
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 1
                                        ? Colors.green
                                        : Colors.grey,),
                                      title: Text(
                                        record.option1,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 2
                                        ? Colors.green
                                        : Colors.red),
                                      title: Text(
                                        record.option2,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 3
                                        ? Colors.green
                                        : Colors.grey,),
                                      title: Text(
                                        record.option3,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 4
                                        ? Colors.green
                                        : Colors.grey,),
                                      title: Text(
                                        record.option4,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        );
                      });

                  // Scaffold.of(context).dialog;
                },
              ),
            ),
            Card(
              color: Theme.of(context).primaryColor,
              child: ListTile(
                leading: Icon(Icons.trip_origin),
                title: Text(
                  record.option3,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                onTap: () {
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(record.question),
                          actions: [
                            OutlineButton(
                              child: Text(
                                "Dismiss",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                          content: SingleChildScrollView(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Card(
                                    
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 1
                                        ? Colors.green
                                        : Colors.grey,),
                                      title: Text(
                                        record.option1,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 2
                                        ? Colors.green
                                        : Colors.grey,),
                                      title: Text(
                                        record.option2,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 3
                                        ? Colors.green
                                        : Colors.red),
                                      title: Text(
                                        record.option3,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 4
                                        ? Colors.green
                                        : Colors.grey,),
                                      title: Text(
                                        record.option4,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        );
                      });

                  // Scaffold.of(context).dialog;
                },
              ),
            ),
            Card(
              color: Theme.of(context).primaryColor,
              child: ListTile(
                leading: Icon(Icons.trip_origin),
                title: Text(
                  record.option4,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                onTap: () {
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(record.question),
                          actions: [
                            OutlineButton(
                              child: Text(
                                "Dismiss",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                          content: SingleChildScrollView(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Card(
                                    
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 1
                                        ? Colors.green
                                        : Colors.grey,),
                                      title: Text(
                                        record.option1,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 2
                                        ? Colors.green
                                        : Colors.grey,),
                                      title: Text(
                                        record.option2,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 3
                                        ? Colors.green
                                        : Colors.grey,),
                                      title: Text(
                                        record.option3,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    
                                    child: ListTile(
                                      leading: Icon(Icons.trip_origin,
                                      color: record.answer == 4
                                        ? Colors.green
                                        : Colors.red),
                                      title: Text(
                                        record.option4,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
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
        color: Theme.of(context).primaryColor,
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('questions').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();

              return _buildList(context, snapshot.data.documents, snapshot.data.documents.length);
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

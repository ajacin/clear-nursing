import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget _buildList(
    BuildContext context, List<DocumentSnapshot> snapshot, int length) {
  snapshot.shuffle();
  print("Length is");
  print(length);
  int serial = 1;
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot
        .map((data) => _buildListItem(context, data, length, serial++))
        .toList(),
  );
}

Widget _buildListItem(
    BuildContext context, DocumentSnapshot data, length, serial) {
  final record = Record.fromSnapshot(data);
  return Padding(
    key: ValueKey(record.question),
    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
    child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color: Theme.of(context).accentColor),
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
                Text("Q " + serial.toString())
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  record.question,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            AnswerOptionContainer(record: record, option: 1),
            AnswerOptionContainer(record: record, option: 2),
            AnswerOptionContainer(record: record, option: 3),
            AnswerOptionContainer(record: record, option: 4),
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

class AnswerOptionContainer extends StatefulWidget {
  const AnswerOptionContainer({
    Key key,
    @required this.record,
    @required this.option,
  }) : super(key: key);

  final Record record;
  final int option;

  @override
  _AnswerOptionContainerState createState() => _AnswerOptionContainerState();
}

class _AnswerOptionContainerState extends State<AnswerOptionContainer> {
  final choiceColor = [0xff1E90FF, 0xffeb4559, 0xff21bf73];
  var colorIndex = 0;
  String getOption(int key) {
    switch (key) {
      case 1:
        return widget.record.option1;
      case 2:
        return widget.record.option2;
      case 3:
        return widget.record.option3;
      case 4:
        return widget.record.option4;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final optionName=widget.record.option+'1';
    return Container(
      color: Theme.of(context).primaryColor,
      key: ValueKey(widget.record.question),
      child: ListTile(
        leading: Icon(Icons.trip_origin, color: Color(choiceColor[colorIndex])),
        title: Text(
          getOption(widget.option),
          style: TextStyle(
            // color: Theme.of(context).accentColor,
            color: colorIndex ==0 ?Theme.of(context).accentColor:Color(choiceColor[colorIndex]),
          ),
        ),
        onTap: () {
          setState(() {
            colorIndex = widget.record.answer == widget.option ? 2 : 1;
          });
        },
      ),
    );
  }
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

              return _buildList(context, snapshot.data.documents,
                  snapshot.data.documents.length);
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

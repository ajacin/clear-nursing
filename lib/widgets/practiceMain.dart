import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:clearnursing/widgets/QuestionAnswer.dart';

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
        child: QuestionAnswer(record: record, serial: serial)),
  );
}

class PracticeMain extends StatefulWidget {
  @override
  _PracticeMainState createState() => _PracticeMainState();
}

class _PracticeMainState extends State<PracticeMain> {
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

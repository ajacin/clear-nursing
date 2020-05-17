import 'package:flutter/material.dart';
import 'package:clearnursing/widgets/AnswerOptionContainer.dart';
import 'package:clearnursing/widgets/ShareQuestionToEnvironment.dart';
import 'package:clearnursing/widgets/PracticeMain.dart';

class QuestionAnswer extends StatefulWidget {
  const QuestionAnswer({
    Key key,
    @required this.record,
    @required this.serial,
  }) : super(key: key);

  final Record record;
  final int serial;

  @override
  _QuestionAnswerState createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Text(record.reference.toString(),
            // Icon(
            //   Icons.check_box_outline_blank,
            //   color: Theme.of(context).highlightColor,
            // ),
            Text(
              " Question " + widget.serial.toString(),
              style: TextStyle(fontSize: 13),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // CopyQuestionToClipBoard(widget: widget),
                ShareQuestionToEnvironment(widget: widget)
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              widget.record.question,
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        AnswerOptionContainer(record: widget.record, option: 1),
        AnswerOptionContainer(record: widget.record, option: 2),
        AnswerOptionContainer(record: widget.record, option: 3),
        AnswerOptionContainer(record: widget.record, option: 4),
        const SizedBox(height: 20.0),
      ],
    );
  }
}

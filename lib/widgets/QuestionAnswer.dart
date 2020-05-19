import 'package:flutter/material.dart';
import 'package:clearnursing/widgets/AnswerOptionContainer.dart';
import 'package:clearnursing/widgets/ShareQuestionToEnvironment.dart';
import 'package:clearnursing/widgets/PracticeMain.dart';
import 'package:clearnursing/screens/pages/SIgnIn.dart';

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
                // Text(widget.record.favourite.contains('rbkOpcWxjLM4AwreIqpvRBtLt4D3').toString()=='true'?'FAV':'NoFAV'),
                InkWell(
                  child: Container(
                    child: (() {
                      if (widget.record.favourite == null) {
                        return Icon(
                          Icons.favorite_border,
                          color: Theme.of(context).highlightColor,
                        );
                      } else if (widget.record.favourite
                              .contains(uid)
                              .toString() ==
                          'true') {
                        return Icon(
                          Icons.favorite,
                          color: Theme.of(context).highlightColor,
                        );
                      } else
                        return Icon(
                          Icons.featured_video,
                          color: Theme.of(context).highlightColor,
                        );
                    })(),
                  ),
                  onTap: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'This question is added to your favourites.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Theme.of(context).highlightColor,
                    ));
                  },
                ),

                ShareQuestionToEnvironment(widget: widget),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.report),
                    color: Theme.of(context).highlightColor,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Report this question"),
                              content: Text(
                                  "Your feedback is valuable. Please report this question if you think this question/answer has some mistakes\n We will review this and correct this."),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Report this'),
                                  onPressed: () {
                                    widget.record.reference.updateData({
                                      'wrongflag': widget.record.wrongflag + 1
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                  ),
                )
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

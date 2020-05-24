import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:clearnursing/widgets/QuestionAnswer.dart';

class ShareQuestionToEnvironment extends StatelessWidget {
  const ShareQuestionToEnvironment({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final QuestionAnswer widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
      icon: Icon(Icons.share),
      color: Theme.of(context).highlightColor,
      onPressed: () {
        var textToCopy = widget.record.data['question'] +
            '\n' +
            '1) ' +
            widget.record.data['option1'] +
            '\n' +
            '2) ' +
            widget.record.data['option2'] +
            '\n' +
            '3) ' +
            widget.record.data['option3'] +
            '\n' +
            '4) ' +
            widget.record.data['option4'] +
            '\n';
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Share this question"),
                content:
                    Text("Would you like to share this question with answer?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Without Answer'),
                    onPressed: () {
                      Share.share(textToCopy,
                          subject: 'Question from Clear Nursing App');
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('With Answer'),
                    onPressed: () {
                      textToCopy = textToCopy +
                          '\nAnswer: ' +
                          widget.record.data['answer'].toString();
                      Share.share(textToCopy,
                          subject: 'Question from Clear Nursing App');
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
    ));
  }
}

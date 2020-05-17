import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clearnursing/widgets/PracticeMain.dart';

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
  final choiceColor = [0xff6c7b95, 0xffeb4559, 0xff21bf73];
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
        // leading: Icon(Icons.radio_button_unchecked,
        //     color: Color(choiceColor[colorIndex])),
        leading: Icon(
          FontAwesomeIcons.genderless,
          size: 30.0,
          color:  Color(choiceColor[colorIndex]),
        ),
        title: Text(
          getOption(widget.option),
          style: TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 18,
            color: colorIndex == 0
                ? Theme.of(context).accentColor
                : Color(choiceColor[colorIndex]),
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


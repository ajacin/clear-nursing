import 'package:flutter/material.dart';
import 'package:clearnursing/widgets/answer-option-container.dart';
import 'package:clearnursing/widgets/share-question.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clearnursing/screens/pages/google-sign-in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class QuestionAnswer extends StatefulWidget {
  const QuestionAnswer({
    Key key,
    @required this.record,
    @required this.serial,
  }) : super(key: key);

  final record;
  final int serial;

  @override
  _QuestionAnswerState createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> {
  // final favouriteIcon = [Icons.bookmark_border,Icons.bookmark];
  // var favouriteIconIndex=0;
  Future < void > updateFavourites(int indexval, String action) async {
    if(action=="add"){
      await Firestore.instance.collection("questions").document(indexval.toString()).updateData({  
        'favourite': FieldValue.arrayUnion([uid]),  
    }).then((documentReference) {  
        print('succ updated fav add'); 
        Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                // washingtonRef.updateData({"regions", FieldValue.arrayUnion(["greater_virginia"])});
                                'Added Bookmark',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              duration: const Duration(seconds: 3),
                              backgroundColor: Theme.of(context).highlightColor,
                            ));
    }).catchError((e) {  
        print(e);  
    }); 
    }
    else{
      await Firestore.instance.collection("questions").document(indexval.toString()).updateData({  
        'favourite': FieldValue.arrayRemove([uid]),  
    }).then((documentReference) {  
        print('succ updated fav rem'); 
        Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                // washingtonRef.updateData({"regions", FieldValue.arrayUnion(["greater_virginia"])});
                                'Removed Bookmark',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              duration: const Duration(seconds: 3),
                              backgroundColor: Theme.of(context).highlightColor,
                            ));
    }).catchError((e) {  
        print(e);  
    }); 
    }
     
}  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 20.0, bottom: 20.0, right: 7.0, left: 7.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(
            color: Colors.blue[300],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).accentColor,
              blurRadius: 10.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              // offset: Offset(
              //   5.0, // Move to right 10  horizontally
              //   5.0,
              // ),
            )
          ],
        ),
        // color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Text(record.reference.toString(),
                    Icon(
                      Icons.check_box_outline_blank,
                      color: Theme.of(context).highlightColor,
                    ),
                    // Text(
                    //   " Question " + widget.serial.toString(),
                    //   style: TextStyle(fontSize: 13),
                    // ),
                    Text(
                      " Index: " + widget.record.data['index'].toString(),
                      style: TextStyle(fontSize: 13),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            child: (() {
                              if (widget.record.data['favourite'] == null) {
                                return Icon(
                                  Icons.bookmark_border,
                                  color: Theme.of(context).highlightColor,
                                );
                              } else if (widget.record.data['favourite']
                                      .contains(uid)
                                      .toString() ==
                                  'true') {
                                return Icon(
                                  Icons.bookmark,
                                  color: Theme.of(context).highlightColor,
                                );
                              } else
                                return Icon(
                                  Icons.bookmark_border,
                                  color: Theme.of(context).highlightColor,
                                );
                            })(),
                          ),
                          onTap: () {

                            if (widget.record.data['favourite'] == null || widget.record.data['favourite'].length==0||widget.record.data['favourite']
                                      .contains(uid)
                                      .toString() ==
                                  'false'){
                                      updateFavourites(widget.record.data['index'],"add");
                                      widget.record.data['favourite'].addAll(uid);
                                  }
                                  else{
                                    updateFavourites(widget.record.data['index'],"remove");
                                    widget.record.data['favourite'].remove(uid);
                                  }
                            
                          },
                        ),

                        ShareQuestionToEnvironment(widget: widget),
                        // Container(
                        //   child: IconButton(
                        //     icon: Icon(Icons.report),
                        //     color: Theme.of(context).highlightColor,
                        //     onPressed: () {
                        //       showDialog(
                        //           context: context,
                        //           builder: (BuildContext context) {
                        //             return AlertDialog(
                        //               title: Text("Report this question"),
                        //               content: Text(
                        //                   "Your feedback is valuable. Please report this question if you think this question/answer has some mistakes\n We will review this and correct this."),
                        //               actions: <Widget>[
                        //                 FlatButton(
                        //                   child: Text('Report this'),
                        //                   onPressed: () {
                        //                     widget.record.reference.updateData({
                        //                       'wrongflag': widget.record.wrongflag + 1
                        //                     });
                        //                     Navigator.of(context).pop();
                        //                   },
                        //                 ),
                        //                 FlatButton(
                        //                   child: Text('Cancel'),
                        //                   onPressed: () {
                        //                     Navigator.of(context).pop();
                        //                   },
                        //                 ),
                        //               ],
                        //             );
                        //           });
                        //     },
                        //   ),
                        // ),
                        IconButton(
                            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                            icon: FaIcon(
                              FontAwesomeIcons.ellipsisV,
                              size: 18,
                              color: Theme.of(context).highlightColor,
                            ),
                            onPressed: () {
                              print("Pressed");
                            })
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(
                      widget.record.data['question'],
                      style: GoogleFonts.robotoSlab(
                        textStyle: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: .5),
                      ),
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
            ),
          ),
        ),
      ),
    );
  }
}

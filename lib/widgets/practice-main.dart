import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clearnursing/widgets/question-answer.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clearnursing/widgets/connection-status.dart';

class PracticeMain extends StatefulWidget {
  @override
  _PracticeMainState createState() => _PracticeMainState();
}

class _PracticeMainState extends State<PracticeMain> {
  Firestore firestore = Firestore.instance;
  List<DocumentSnapshot> products = [];
  bool isLoading = false;
  bool hasMore = true;
  int documentLimit = 10;
  DocumentSnapshot lastDocument;
  ScrollController _scrollController = ScrollController();
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    getProducts();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        getProducts();
      }
    });
    _pageController = new PageController()
      ..addListener(_pageControllerListener);
  }

  _pageControllerListener() {
    print('Listening pagemove');
  }

  getRandom() async {
    QuerySnapshot querySnapshotforMeta;
    querySnapshotforMeta = await firestore
        .collection('meta')
        // .orderBy('wrongflag')
        // .where("wrongflag", whereIn: getRandom())
        .limit(1)
        .getDocuments();
    // var totalDocs = querySnapshotforMeta.documents.length>0?querySnapshotforMeta.documents.totalquestions;
    List<DocumentSnapshot> meta = [];
    meta.addAll(querySnapshotforMeta.documents);
    var totalDocs = meta[0]['totalquestions'];
    // documentLimit = meta[0]['documentlimit'];
    totalDocs = totalDocs == 0 ? 40 : totalDocs;
    var randomArr = new Random();
    var randomNosInBound =
        new List.generate(5, (_) => randomArr.nextInt(totalDocs));
    return randomNosInBound;
  }

  getProducts() async {
    if (!hasMore) {
      print('No More Products');
      return;
    }
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    QuerySnapshot querySnapshot;
    // if (lastDocument == null) {
    //   querySnapshot = await firestore
    //       .collection('questions')
    //       .orderBy('wrongflag')
    //       .limit(documentLimit)
    //       .getDocuments();
    // } else {
    querySnapshot = await firestore
        .collection('questions')
        // .orderBy('wrongflag')
        .where("wrongflag", whereIn: await getRandom())
        .limit(documentLimit)
        .getDocuments();
    // print(1);
    // }
    // if (querySnapshot.documents.length < documentLimit) {
    //   hasMore = false;
    // }
    // print('last document index');
    // print(querySnapshot.documents.length - 1);
    // print(querySnapshot.documents[0].data['question']);
    var indexOfLastDocument = querySnapshot.documents.length == 0
        ? 0
        : querySnapshot.documents.length - 1;
    lastDocument = querySnapshot.documents[indexOfLastDocument];
    products.addAll(querySnapshot.documents);
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  Future<String> checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return "Loading...";
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return "Loading...";
    } else {
      return "No connection";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(children: [
        ConnectionStatus(),
        Container(
          height: MediaQuery.of(context).size.height * 0.10,
          width: MediaQuery.of(context).size.width * 0.95,
          color: Colors.indigo[50],
        ),
        Expanded(
          child: products.length == 0
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).highlightColor),
                  ),
                )
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        children: products
                            .map((data) => QuestionAnswer(
                                record: products[products.indexOf(data)],
                                serial: products.indexOf(data) + 1))
                            .toList(),
                        controller: _pageController,
                        onPageChanged: (index) {
                          if (index + 1 == products.length) {
                            getProducts();
                          }
                        },
                      ),
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox.fromSize(
                              size: Size(55, 55), // button width and height
                              child: ClipOval(
                                child: Material(
                                  color: Theme.of(context)
                                      .primaryColor, // button color
                                  child: InkWell(
                                    splashColor: Colors.green, // splash color
                                    onTap: () {
                                      _pageController.nextPage(
                                          duration:
                                              Duration(microseconds: 1000),
                                          curve: Curves.easeInCirc);
                                    }, // button pressed
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        FaIcon(FontAwesomeIcons
                                            .arrowCircleRight), // icon
                                        Text("Next"), // text
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ),
        isLoading
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: 2,
                // padding: EdgeInsets.all(5),
                // color: Theme.of(context).highlightColor,
                child: FutureBuilder<String>(
                    future: checkNetwork(),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        // return Text(snapshot.data);
                        return LinearProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).highlightColor),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              )
            : Container()
      ]),
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
  final int wrongflag;
  final List favourite;

  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['question'] != null),
        assert(map['option1'] != null),
        assert(map['option2'] != null),
        assert(map['option3'] != null),
        assert(map['option4'] != null),
        assert(map['answer'] != null),
        assert(map['remarks'] != null),
        assert(map['wrongflag'] != null),
        // assert(map['favourite']!=null),
        question = map['question'],
        option1 = map['option1'],
        option2 = map['option2'],
        option3 = map['option3'],
        option4 = map['option4'],
        answer = map['answer'],
        remarks = map['remarks'],
        wrongflag = map['wrongflag'],
        favourite = map['favourite'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$question:$option1>";
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:clearnursing/widgets/QuestionAnswer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:math';
import 'package:clearnursing/perpage/perpage.dart';

_fetchMore(BuildContext context, List<DocumentSnapshot> snapshot) {
  // _perPage++
}

Widget _buildList(
    // final PerPage perPage = PerPage(),
    BuildContext context,
    List<DocumentSnapshot> snapshot,
    int length) {
  snapshot.shuffle();
  print("Length is");
  print(length);
  int serial = 1;
  PageController _controller = PageController(initialPage: 0, keepPage: false);
  PerPage perPage = PerPage();
  return Observer(
    builder: (context) => PageView(
      controller: _controller,
      onPageChanged: (num) {
        print(num);
        if (num == 4) {
          print(num * num);
          perPage.nextPages();
          print('jll');
          print('${perPage.perPage}');

        }
      },
      children: snapshot
          .map((data) => _buildListItem(context, data, length, serial++))
          .toList(),
    ),
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
  Firestore firestore = Firestore.instance;
  List<DocumentSnapshot> products = [];
  bool isLoading = false;
  bool hasMore = true;
  int documentLimit = 5;
  DocumentSnapshot lastDocument;
  ScrollController _scrollController = ScrollController();
  PageController _pageController;
  String _statusMessage = "Loading";

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
    if (lastDocument == null) {
      querySnapshot = await firestore
          .collection('questions')
          .orderBy('wrongflag')
          .limit(documentLimit)
          .getDocuments();
    } else {
      querySnapshot = await firestore
          .collection('questions')
          .orderBy('wrongflag', descending: false)
          .startAfter([0])
          .limit(documentLimit)
          .getDocuments();
      print(1);
    }
    if (querySnapshot.documents.length < documentLimit) {
      hasMore = false;
    }
    print('last document index');
    print(querySnapshot.documents.length - 1);
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

  Future<String> _loadingMessage() async {
    // var status = await checkNetwork();
    return _statusMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
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
              : PageView(
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
        isLoading
            ? Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                color: Theme.of(context).highlightColor,
                child: FutureBuilder<String>(
                    future: checkNetwork(),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        // return Text(snapshot.data);
                        return Text(
                          snapshot.data.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              ),
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

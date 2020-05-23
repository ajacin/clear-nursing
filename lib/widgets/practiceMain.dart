import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:clearnursing/widgets/QuestionAnswer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

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
          // PerPage perPage = PerPage(),
          perPage.nextPages();
          print('jll');
          print('${perPage.perPage}');
          // _perPage++
          // _fetchMore(context,snapshot);
          // print(snapshot.length);
          // snapshot.add(snapshot[1]);
          // print(snapshot.length);

        }
      },
      children: snapshot
          .map((data) => _buildListItem(context, data, length, serial++))
          .toList(),
    ),
  );
  // return ListView(
  //   padding: const EdgeInsets.only(top: 20.0),
  //   children: snapshot
  //       .map((data) => _buildListItem(context, data, length, serial++))
  //       .toList(),
  // );
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
          .orderBy('question')
          .limit(documentLimit)
          .getDocuments();
    } else {
      querySnapshot = await firestore
          .collection('questions')
          .orderBy('question')
          .startAfterDocument(lastDocument)
          .limit(documentLimit)
          .getDocuments();
      print(1);
    }
    if (querySnapshot.documents.length < documentLimit) {
      hasMore = false;
    }
    lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];
    products.addAll(querySnapshot.documents);
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: products.length == 0
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor:AlwaysStoppedAnimation<Color>(Theme.of(context).highlightColor),
                  ),
                )
              : PageView(
                  // children: <Widget>[
                  //   ListView.builder(
                  //     controller: _scrollController,
                  //     itemCount: products.length,
                  //     itemBuilder: (context, index) {
                  //       // return ListTile(
                  //       //   contentPadding: EdgeInsets.all(5),
                  //       //   title: Text(products[index].data['question']),
                  //       //   subtitle: Text(products[index].data['option1']),
                  //       // );
                  //       // return QuestionAnswer(record: products[index], serial: index);
                  //       return Container(
                  //         decoration: BoxDecoration(
                  //           color: Theme.of(context).primaryColor,
                  //           border: Border.all(
                  //               color: Theme.of(context).accentColor),
                  //         ),
                  //         child: QuestionAnswer(
                  //             record: products[index], serial: index + 1),
                  //       );
                  //     },
                  //   ),
                  // ],
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
                child: Text(
                  'Loading more questions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                  ),
                ),
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

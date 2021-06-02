import 'package:flutter/material.dart';
import 'package:flutter_application/Components/CreateNewCasePage.dart';
import 'dart:collection';

import 'package:intl/intl.dart';
import 'dart:math';

final List<Case> _casesSource = [
  Case(1, "Isabella", "203010341803492", DateTime.now(), "No notable notes"),
  Case(2, "Nicholas Cage", "20000000000",
      DateTime.now().add(const Duration(days: 1)), "No notable notes"),
  Case(3, "Nicholas Cage", "20000000000",
      DateTime.now().add(const Duration(days: 1)), "No notable notes"),
  Case(4, "Nicholas Cage", "20000000000",
      DateTime.now().add(const Duration(days: 1)), "No notable notes"),
];

class CaseLogPage extends StatefulWidget {
  CaseLogPage({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _CaseLogPageState createState() => _CaseLogPageState();
}

class _CaseLogPageState extends State<CaseLogPage> {
  int _counter = 0;

  // map patient name to a CaseLog object
  //final List<Case> caseLogEntries = _casesSource;
  //static themap = Map.fromIterable(_casesSource, key:(item)=>item.name, value:(item)=>[item],);
  /*
  static Map<String,<List<Case>>> mappings =
      _casesSource.map((entry) => {entry.name: entry}).toList();
      */
  // map name to Case
  final caseLogsName =
      LinkedHashMap<String, List<Case>>(equals: (s1, s2) => s1 == s2)
        ..addAll(Map.fromIterable(
          _casesSource,
          key: (item) => item.name,
          value: (item) => [item],
        ));

  // maybe another map mapping notes to case, to make it searchable that way?

  void _createNewCase(context) async {
    // Navigator push to a page to enter patient data,
    // await response from Navigator.pop,
    // set result equal to a new case
    Case newCase = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CreateNewCasePage(number: _casesSource.length)));
    setState(() {
      // add new case to list and hashmaps
      _casesSource.add(newCase);
      _counter++;
    });
  }

  // one tile in the Option menu

  Widget CaseLog() {
    // TODO: use dropdown_search? https://pub.dev/packages/dropdown_search
    return ListView.builder(
      scrollDirection: Axis.vertical,
      primary: true,
      itemCount: _casesSource
          .length, // there's some null option here but idk what it is
      itemBuilder: (BuildContext context, int ix) {
        Case _case = _casesSource.reversed.toList()[ix]; // get relevant case
        return Container(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Container(
                color: Colors.blue[300],
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Center(
                    child: Column(children: [
                  Text(_case.name),
                  Text(
                      "MR${_case.MRN} on ${DateFormat('MM-d-y').format(_case.date)}"),
                  Text(_case.notes.substring(0, min(_case.notes.length, 30)))
                ]))));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the Dashboard object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title ?? "Case Logs"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        //OptionMenu()

        child: CaseLog(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewCase(context),
        tooltip: 'New Case',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: Text('Pop!'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class Case {
  final int caseID;
  final String name;
  final String MRN; // medical record number of patient
  final DateTime date;
  final String notes;
  // constructor
  const Case(this.caseID, this.name, this.MRN, this.date, this.notes);
}

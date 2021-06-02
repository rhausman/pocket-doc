import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'CaseLogPage.dart';

class CreateNewCasePage extends StatefulWidget {
  CreateNewCasePage({Key? key, this.number: -1}) : super(key: key);
  final int number; // TODO: need to pass in case id to the constructor

  @override
  _CreateNewCasePageState createState() => _CreateNewCasePageState();
}

class _CreateNewCasePageState extends State<CreateNewCasePage> {
  int _counter = 0;
  // all these fields will be updated when info is entered
  String name = "";
  String MRN = "";
  DateTime date_time = DateTime.now();
  String notes = "";
  // map name to Case
  /*
  final caseLogsName =
      LinkedHashMap<String, List<Case>>(equals: (s1, s2) => s1 == s2)
        ..addAll(Map.fromIterable(
          _casesSource,
          key: (item) => item.name,
          value: (item) => [item],
        ));
  */
  // maybe another map mapping notes to case, to make it searchable that way?

  void _constructCase(String name, String MRN, String notes) {
    // get Name, MR number, Date/time, Notes
    // String, int or string with format verification, Datetime, String
    // first, run data verifications to make sure all inputs are valid
    // (this could entail making fields nullable and chacking that none are null)

    setState(() {
      // add new case to list and hashmaps
      //name = //
      Case newCase = Case(widget.number, name, MRN, DateTime.now(), notes);
      Navigator.pop(context, newCase); // list of data to bounce back
      // type should be final List<Case>
    });
  }

  // one tile in the Option menu

  Widget CaseLogForm() {
    final formKey = GlobalKey<FormState>();
    // TODO: use dropdown_search? https://pub.dev/packages/dropdown_search
    return Form(
        key: formKey,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(10)),
            TextFormField(
              // name
              // The validator receives the text that the user has entered.
              onChanged: (value) => {name = value},
              validator: nonEmptyValidator,
            ),
            Padding(padding: EdgeInsets.all(10)),
            TextFormField(
              // MRN
              // The validator receives the text that the user has entered.
              onChanged: (value) => {MRN = value},
              validator: nonEmptyValidator,
            ),
            Padding(padding: EdgeInsets.all(10)),
            // TODO add date field
            TextFormField(
              // notes
              // The validator receives the text that the user has entered.
              onChanged: (value) => {notes = value},
              validator: nonEmptyValidator,
            ),
            BasicDateField(),

            Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () => _constructCase(name, MRN, notes),
                ))
          ],
        ));
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
        title: Text("Create New Case Log Entry"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        //OptionMenu()

        child: CaseLogForm(),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic date field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}

String? nonEmptyValidator(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

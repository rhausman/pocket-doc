import 'package:flutter/material.dart';

// list of options: Icon [IconData], Text/label [String], fxn that makes a screen that it links to
var optionsList = [
  [Icons.message, "Whatsapp", () => DetailScreen()],
  [Icons.image, "Albums", () => Dashboard()],
  [Icons.looks, "Visual", () => Dashboard()],
  [Icons.calendar_today_rounded, "Calendar", () => Dashboard()],
  [Icons.book, "Performance Log", () => Dashboard()],
  [Icons.format_list_numbered_rounded, "Case Log", () => Dashboard()],
  [Icons.mic, "Dictation", () => Dashboard()],
  [Icons.messenger_outline_sharp, "Messages", () => Dashboard()],
  [Icons.settings, "Settings", () => Dashboard()]
];

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Widget DashboardStats() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Cases: 5', textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text('Glass Minutes: 0', textAlign: TextAlign.center),
              ),
            ],
          ),
          Row(children: [
            Expanded(
              child: Text('Registered as Mentor with 1 mentee',
                  textAlign: TextAlign.center),
            )
          ]),
          Row(children: [
            Expanded(child: Text('Progress', textAlign: TextAlign.center)),
            Expanded(
                child: SizedBox(
                    height: 50.0,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(8),
                        children: List.generate(
                            5,
                            (int index) => Icon(index < _counter
                                ? Icons.favorite
                                : Icons.favorite_border),
                            growable: true))))
          ])
        ],
      ),
    );
  }

  // one tile in the Option menu
  Widget optionTile(
      IconData iconData, String label, Widget Function() destinationScreen) {
    return Material(
        color: Colors.blue,
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return destinationScreen();
                }),
              );
            },
            child: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(iconData), Text(label ?? "nothing")]))));
  }

  Widget OptionMenu() {
    List<Widget> lst = optionsList.asMap().entries.map((entry) {
      //int ix = entry.key;
      IconData iconData = entry.value[0];
      String label = entry.value[1];
      return optionTile(iconData, label, entry.value[2]);
    }).toList();
    return GridView.count(
        primary: false,
        crossAxisCount: 3,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: lst);
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
        title: Text(widget.title ?? "New Screen"),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          //OptionMenu()
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
            ),
            SizedBox(height: 100, child: DashboardStats()),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            Flexible(child: OptionMenu())
          ])),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
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

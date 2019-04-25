import 'package:flutter/material.dart';
import 'dart:math' as math;
import './circular_percent_indicator.dart';
import './income.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _controller;

  static const List<IconData> icons = const [ Icons.sms, Icons.mail, Icons.phone ];

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    return new Scaffold(
      appBar: new AppBar(title: new Text('Personal Account Tracker')),
      body: Center(
        child: ListView(
            children: <Widget>[
              new CircularPercentIndicator(
                radius: 130.0,
                lineWidth: 10.0,
                percent: 0.8,
                header: new Text("Statistics"),
                center: new Text(
                  "Income",
                  style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
              ),
              new CircularPercentIndicator(
                radius: 130.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: 0.4,
                center: new Text(
                  "Expenses",
                  style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.yellow,
                progressColor: Colors.red,
              ),
              new CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                percent: 0.7,
                center: new Text(
                  "Borrows",
                  style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                // footer: new Text(
                //   "Sales this week",
                //   style:
                //       new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                // ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.purple,
              ),
              // Padding(
              //   padding: EdgeInsets.all(15.0),
              //   child: new CircularPercentIndicator(
              //     radius: 60.0,
              //     lineWidth: 5.0,
              //     percent: 1.0,
              //     center: new Text("100%"),
              //     progressColor: Colors.green,
              //   ),
              // ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 4.0,
                      percent: 0.10,
                      center: new Text("10%"),
                      progressColor: Colors.red,
                    ),
                    new Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    new CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 4.0,
                      percent: 0.30,
                      center: new Text("30%"),
                      progressColor: Colors.orange,
                    ),
                    new Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    new CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 4.0,
                      percent: 0.60,
                      center: new Text("60%"),
                      progressColor: Colors.yellow,
                    ),
                    new Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    // new CircularPercentIndicator(
                    //   radius: 45.0,
                    //   lineWidth: 4.0,
                    //   percent: 0.90,
                    //   center: new Text("90%"),
                    //   progressColor: Colors.green,
                    // )
                  ],
                ),
              )
            ]),
      ),
      drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("Balavignesh"),
                accountEmail: new Text("crystelpheonix@gmail.com"),
                currentAccountPicture: new CircleAvatar(backgroundColor: Colors.black26,child: new Text("B"),),
                decoration: new BoxDecoration(color: Colors.lightGreen),
              ),
              new ListTile(title: new Text("Income"),trailing: new Icon(Icons.access_alarm),onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new Incomes())),),
              new ListTile(title: new Text("Expenses"),trailing: new Icon(Icons.airline_seat_flat_angled),),
              new ListTile(title: new Text("Lender"),trailing: new Icon(Icons.close),),
              new ListTile(title: new Text("Close"),trailing: new Icon(Icons.close),onTap: (){Navigator.pop(context);},),
            ],
          ),
        ),
      floatingActionButton: new Column(
        mainAxisSize: MainAxisSize.min,
        children: new List.generate(icons.length, (int index) {
          Widget child = new Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: new ScaleTransition(
              scale: new CurvedAnimation(
                parent: _controller,
                curve: new Interval(
                  0.0,
                  1.0 - index / icons.length / 2.0,
                  curve: Curves.easeOut
                ),
              ),
              child: new FloatingActionButton(
                heroTag: null,
                backgroundColor: backgroundColor,
                mini: true,
                child: new Icon(icons[index], color: foregroundColor),
                onPressed: () {},
              ),
            ),
          );
          return child;
        }).toList()..add(
          new FloatingActionButton(
            heroTag: null,
            child: new AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return new Transform(
                  transform: new Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child: new Icon(_controller.isDismissed ? Icons.share : Icons.close),
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'main.utils/circular_percent_indicator.dart';
import 'component.barrowlends/lend.dart';
import 'component.expense/expense.dart';
import 'component.income/income.dart';

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

  static const List<Image> icons = const [ 
    Image(width: 50, image: AssetImage("assets/income.png")),
    Image(width: 50, image: AssetImage("assets/profit.png")),
    Image(width: 50, image: AssetImage("assets/borrow_lend.png"))
  ];


  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10),
    );
  }

  pages(i){
    var page = [new Incomes(), new Expenses(), new Lenders()];
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> page[i]));
  }

  Widget build(BuildContext context) {
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
                backgroundColor: Colors.transparent,
                progressColor: Colors.transparent,
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
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.purple,
              ),
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
                  
                  ],
                ),
              )
            ]),
      ),
      floatingActionButton: new Column(
        mainAxisSize: MainAxisSize.min,
        children: new List.generate(icons.length, (int index) {
          Widget child = new Container(
            height: 70.0,
            width: 50.0,
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
                backgroundColor: Colors.white,
                mini: true,
                child: icons[index],
                onPressed: () {
                  pages(index);
                },
              ),
            ),
          );
          return child;
        }).toList()..add(
          new FloatingActionButton(
            heroTag: null,
            backgroundColor: Colors.white,
            foregroundColor: Colors.teal,
            child: new AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return new Transform(
                  transform: new Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child: _controller.isDismissed ?  Image(width: 80,height: 80, image: AssetImage("assets/root.png")) : new Icon(Icons.close),
          
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

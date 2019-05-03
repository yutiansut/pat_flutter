import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'main.utils/circular_percent_indicator.dart';
import 'component.barrowlends/lend.dart';
import 'component.expense/expense.dart';
import 'component.income/income.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';



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

bool _dialVisible = true;

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
      appBar: new AppBar(title: new Text('Personal Account Tracker'),
      backgroundColor: Colors.pinkAccent,),
      floatingActionButton: SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          visible: _dialVisible,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: StadiumBorder(),
          children: [
            SpeedDialChild(
              elevation: 0.0,
              child: icons[0],
              backgroundColor: Colors.transparent,
              label: 'Income',
        
              onTap: () => pages(0)
            ),
            SpeedDialChild(
              elevation: 0.0,
              child: icons[1],
              backgroundColor: Colors.transparent,
              label: 'Expense',
              
              onTap: () => pages(1),
            ),
            SpeedDialChild(
              elevation: 0.0,
              child: icons[2],
              backgroundColor: Colors.transparent,
              label: 'BarrowLend',
              
              onTap: () => pages(2),
            ),
          ],
        ),
    );
  }
}
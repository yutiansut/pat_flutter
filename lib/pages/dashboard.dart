import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Xwidgets/XcardView.dart';

class DashboardPage extends StatefulWidget {

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState  extends State<DashboardPage>{
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        XCardView(leading: Image(image: AssetImage("assets/inc_pen.png")),title: "Income", subtitle: "SubTitle",)
      ],
    );
  } 
}

import 'package:flutter/material.dart';

class IncomeSalary extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Scaffold(
    body: new Column(
     
    ),
    floatingActionButton: new FloatingActionButton(
      elevation: 0.0,
      child: Image(
        width: 50,
        image: AssetImage("assets/inc_pen.png"),
      ),
      backgroundColor: Colors.transparent,
      onPressed: (){
        print("Ink Clicked");
      }
    )
  );
}
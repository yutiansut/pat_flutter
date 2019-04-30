import 'package:flutter/material.dart';

class FormTab extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState  extends State<FormTab>{

  double num1;
  double num2;
  double result = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Form"),
      ),
      body: Container (
      child: Column(
        children: <Widget>[
          
          RaisedButton(
            child:Text("Save"),
            onPressed: () {
              setState(() {
                result = num1 + num2;
              });
            },
          ),
          RaisedButton(
            child:Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
    );
  }
  
}

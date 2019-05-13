import 'package:flutter/material.dart';
import 'pages/views/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      title: 'PAT',
      theme: ThemeData(
        // primaryColor: Colors.teal
        primarySwatch: Colors.teal,
        // primaryColor: Colors.black,
        
        // scaffoldBackgroundColor: Colors.green,
        // backgroundColor: Colors.cyan,
        // fontFamily: '',
      ),
      home: MainPage(),
    );
  }
}
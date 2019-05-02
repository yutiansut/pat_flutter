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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainPage(),
    );
  }
}
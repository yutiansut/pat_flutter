import 'package:flutter/material.dart';
import 'package:pat_flutter/pages/home.dart';
import 'pages/formPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeTab homeTab = HomeTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box),
            iconSize: 80,
            color: Colors.red,
		onPressed: (){
			Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeTab()));
		},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
		  Navigator.push(context, MaterialPageRoute(builder: (context)=> FormTab()));
	  },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
}

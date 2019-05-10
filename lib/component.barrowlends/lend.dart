import 'package:flutter/material.dart';
import './pages/borrows_page.dart';
import './pages/lender_pager.dart';

class Lenders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Image(
	        width: 74,
          height: 41,
	        image: AssetImage("assets/lend.png"),
	      )),
                Tab(icon: Image(
	        width: 74,
          height: 35,
	        image: AssetImage("assets/barrow.png"),
	      ))
              ],
            ),
            title: Text('Lendes'),
            backgroundColor: Color.fromRGBO(107, 99, 255, 1),
            leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
            ),
          ),
          body: TabBarView(
            children: [
              Lends(),
              Barrows()
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
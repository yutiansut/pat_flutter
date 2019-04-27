import 'package:flutter/material.dart';

import './borrows_page.dart';
import './lender_pager.dart';


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
	        width: 50,
          height: 30,
	        image: AssetImage("assets/lend.png"),
	      )),
                Tab(icon: Image(
	        width: 50,
          height: 30,
	        image: AssetImage("assets/barrow.png"),
	      ))
              ],
            ),
            title: Text('Lendes'),
            leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
            ),
          ),
          body: TabBarView(
            children: [
              LenderPage(),
              BorrowPage()
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
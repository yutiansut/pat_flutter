import 'package:flutter/material.dart';

import './expense_online.dart';
import './expense_purchase.dart';


class Expenses extends StatelessWidget {
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
	        image: AssetImage("assets/onlinexp.png"),
	      )),
                Tab(icon: Image(
	        width: 50,
          height: 30,
	        image: AssetImage("assets/purchase.png"),
	      ))
              ],
            ),
            title: Text('Expenses'),
            leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
            ),
          ),
          body: TabBarView(
            children: [
              ExpOnline(),
              ExpensePurchase()
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
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
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit))
              ],
            ),
            title: Text('Expenses'),
            leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
            ),
          ),
          body: TabBarView(
            children: [
              ExpenseOnline(),
              ExpensePurchase()
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
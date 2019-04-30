import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState  extends State<HomeTab>{
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 4,
            child: Scaffold(
                appBar: AppBar(
                    bottom: TabBar(
                        indicatorColor: Colors.white,
                        tabs: [
                          Tab(text: "Income"),
                          Tab(text: "Expense"),
                          Tab(text: "Borow"),
                          Tab(text: "Lend"),
                        ]
                    ),

                    title: Text("Calculator")
                ),

                body: TabBarView(
                    children: [
                      Text("Calculator"),
                      Text("Calculator"),
                      Text("Calculator"),
                      Text("Calculator")
                      // additionTab,
                      // subtractionTab,
                      // multiplicationTab,
                      // divisionTab,
                    ]
                )
            )
        )
    );
  } 
}
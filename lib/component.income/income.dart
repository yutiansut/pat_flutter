import 'package:flutter/material.dart';
import '../component.income/pages/income_reward.dart';
import '../component.income/pages/income_salary.dart';


class Incomes extends StatelessWidget {
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
	        image: AssetImage("assets/salary.png"),
	      )),
                Tab(icon: Image(
	        width: 50,
          height: 30,
	        image: AssetImage("assets/reward.png"),
	      ))
              ],
            ),
            title: Text('Incomes'),
            leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
            ),
            backgroundColor: Colors.lightGreen[900],
          ),
          body: TabBarView(
            children: [
              IncomeSale(),
              IncomeReward(),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
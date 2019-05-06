import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import '../../Xwidgets/XcardView.dart';
import '../models/category.dart' show Category;
import '../models/accounts.dart' show Accounts;

Accounts accountsDb = Accounts();

class DashboardPage extends StatefulWidget {

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState  extends State<DashboardPage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* return Column(
      children: <Widget>[
        XCardView(leading: Image(image: AssetImage("assets/inc_pen.png")),title: categ.defaultCateg[index].name, subtitle: "SubTitle",)
      ],
    ); */
    /* return ListView.builder(
        itemCount: categ.defaultCateg.length,
        itemBuilder: (context, index) {
          return XCardView(leading: Image(image: AssetImage("assets/inc_pen.png")),title: categ.defaultCateg[index].name, subtitle: categ.defaultCateg[index].toMap().toString(),);
        },
      ); */
      List ItemsPage = List();
      accountsDb.getAccounts().then((items){
        for(var i = 0; i< items.length; i++){
          print(items[i]);
          ItemsPage.add(items[i]);
        }
      });
      
      return Center(
        child: ListView(
          children: <Widget>[
            // print(itemsPage);
          ],
        ),
      );
  } 
}

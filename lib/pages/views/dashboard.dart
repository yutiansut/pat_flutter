import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import '../../Xwidgets/XcardView.dart';
import '../../dbutils/DBhelper.dart' show Models;
// import '../models/category.dart' show Category;
// import '../models/accounts.dart' show Accounts;

Models models = Models();

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
      List itemsPage = List();
      models.getTableData("Accounts").then((items){
        for(var i = 0; i< items.length; i++){
          // print(items[i]);
          itemsPage.add(items[i]);
        }
      });

      Card topArea() => Card(
        margin: EdgeInsets.all(10.0),
        elevation: 1.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Color(0xFF015FFF), Color(0xFF015FFF)])),
            padding: EdgeInsets.all(5.0),
            // color: Color(0xFF015FFF),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Text("Savings",
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(r"$ " "95,940.00",
                        style: TextStyle(color: Colors.white, fontSize: 24.0)),
                  ),
                ),
                SizedBox(height: 35.0),
              ],
            )),
      );

      
      return Center(
        child: ListView(
          children: <Widget>[
            // print(itemsPage);
            topArea(),
          ],
        ),
      );
  } 
}

import 'package:flutter/material.dart';
import '../../component.barrowlends/lend.dart';
import '../../component.expense/expense.dart';
import '../../component.income/income.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../main.dart';
import 'package:flutter/services.dart';
import '../pages/root.settings.dart';


class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Root();
  }
}

class Root extends State<RootPage> with TickerProviderStateMixin {

  AnimationController _controller;

  static const List<Image> icons = const [ 
    Image(width: 50, image: AssetImage("assets/income.png")),
    Image(width: 50, image: AssetImage("assets/profit.png")),
    Image(width: 50, image: AssetImage("assets/borrow_lend.png"))
  ];

bool _dialVisible = true;

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10),
    );
  }

  pages(i){
    var page = [new Incomes(), new Expenses(), new Lenders()];
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> page[i]));
  }

  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => Future.value(false),
      child: new Scaffold(
      appBar: new AppBar(title: new Text('Personal Account Tracker'),
      backgroundColor: Colors.purpleAccent,
      // automaticallyImplyLeading: false,
      ),
      drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("Balavignesh"),
                accountEmail: new Text("crystelpheonix@gmail.com"),
                currentAccountPicture: new CircleAvatar(backgroundColor: Colors.black26,child: new Text("B"),),
                decoration: new BoxDecoration(color: Colors.lightGreen),
                onDetailsPressed: (){
                  
                },
              ),
              new ListTile(title: new Text("Settings"),trailing: Image(
                width: 20,
                image: AssetImage("assets/setting.png"),
              ),
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new SettingsRoot()));
                },
              ),
              new ListTile(title: new Text("About"),trailing: Image(
                width: 25,
                image: AssetImage("assets/about.png"),
              ), onTap:(){
                 SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },),
              new ListTile(title: new Text("Logout"),trailing: Image(
                width: 25,
                image: AssetImage("assets/logout.png"),
              ),onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new MyApp()));
              },)
            ],
          ),
        ),
      floatingActionButton: SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          visible: _dialVisible,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.purpleAccent,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: StadiumBorder(),
          children: [
            SpeedDialChild(
              elevation: 0.0,
              child: icons[0],
              backgroundColor: Colors.transparent,
              label: 'Income',
        
              onTap: () => pages(0)
            ),
            SpeedDialChild(
              elevation: 0.0,
              child: icons[1],
              backgroundColor: Colors.transparent,
              label: 'Expense',
              
              onTap: () => pages(1),
            ),
            SpeedDialChild(
              elevation: 0.0,
              child: icons[2],
              backgroundColor: Colors.transparent,
              label: 'BarrowLend',
              
              onTap: () => pages(2),
            ),
          ],
        ),
    ),
    );

  }

 
}


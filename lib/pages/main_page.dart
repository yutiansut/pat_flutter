import 'package:flutter/material.dart';
import '../config/config.dart' as conf;
import './../styles/styles.dart' as stylex;
import 'dashboard.dart';
import 'accounts.dart';


class MainPage extends StatefulWidget {

  int _currentTab = 0;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState  extends State<MainPage> with SingleTickerProviderStateMixin {

  final List<Tab> myTabs = <Tab>[
    Tab(text: "Dashboard"),
    Tab(text: "Accounts"),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                    title: Text(conf.appName),
                    bottom: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.white,
                      tabs: myTabs,
                      onTap: (int index){
                        print(index);
                      },
                    ),
                    backgroundColor: stylex.violet,
                ),

                body: TabBarView(
                  controller: _tabController,
                  children: [
                    DashboardPage(),
                    AccountsPage(),
                  ],
                ),
                drawer: Drawer(
                  child: ListView(
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        accountName: Text(conf.appAuthor),
                        accountEmail: Text(conf.appEmail),
                        currentAccountPicture: CircleAvatar(backgroundColor: Colors.black26,child: Text(conf.appAuthor[0], style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),),),
                        decoration: new BoxDecoration(color: stylex.violet),
                      ),
                      ListTile(title: Text("Dashboard"), trailing: Icon(Icons.access_alarm),onTap: () => _tabController.animateTo((1 + 1) % 2),),
                      ListTile(
                        title: Text("Accounts"),
                        trailing: Icon(Icons.access_alarm),
                        onTap: () {
                          // _tabController.animateTo((_tabController.index + 1) % 2);
                          _tabController.animateTo((2 + 1) % 2);
                        },
                      )
                    ],
                  ),
                ),
            ),
        ),
    );
  } 
}
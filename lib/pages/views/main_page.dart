import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pat_flutter/pages/views/accounttypelist.dart';
import '../../config/config.dart' as conf;
import '../../styles/styles.dart' as stylex;
import 'dashboard.dart';
import 'accountslist.dart';
import './categorylist.dart' as categList;
import './accountdetail.dart' show AccountDetailPage;


class MainPage extends StatefulWidget {
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
                    title: Text(conf.appName, textAlign: TextAlign.center,),
                    bottom: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.white,
                      tabs: myTabs,
                      onTap: (int index){
                        // print(index);
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
                      ListTile(
                        title: Text("Dashboard"),
                        trailing: Icon(Icons.access_alarm),onTap: () => _tabController.animateTo((1 + 1) % 2),
                      ),
                      ListTile(
                        title: Text("Accounts"),
                        trailing: Icon(Icons.access_alarm),
                        onTap: () {
                          // _tabController.animateTo((_tabController.index + 1) % 2);
                          _tabController.animateTo((2 + 1) % 2);
                        },
                      ),
                      ListTile(
                        title: Text("Category"),
                        trailing: Icon(Icons.view_compact),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => categList.MyCategoryList()));
                        },
                      ),
                      ListTile(
                        title: Text("Account Type"),
                        trailing: Icon(Icons.view_compact),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AccountTypeList()));
                        },
                      ),
                      ListTile(
                        title: Text("Logout"),
                        trailing: Icon(Icons.verified_user, color: Colors.red,),
                        onTap: () {
                          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                        },
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  elevation: 0.0,
                  
                  onPressed: () async {
                    debugPrint('FAB clicked');
                    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return AccountDetailPage("Add Entry", {});
                    }));
                    if(result == true){
                      _tabController.animateTo((2 + 1) % 2);
                    }
                  },

                  tooltip: 'Add Account Type',

                  child: Image(
                    width: 50,
                    image: AssetImage("assets/inc_pen.png"),
                  ),

                  backgroundColor: Colors.transparent,

                ),
            ),
        ),
    );
  } 
}
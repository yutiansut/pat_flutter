import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:pat_flutter/Xwidgets/XColorPicker.dart';
import 'package:pat_flutter/pages/views/accounttypelist.dart';
import '../../config/config.dart' as conf;
import '../../styles/styles.dart' as stylex;
import './../../dbutils/DBhelper.dart' show Models;
import 'dashboard.dart';
import 'accountslist.dart';
import './categorylist.dart' as categList;
import './accountdetail.dart' show AccountDetailPage;
import './../../Xwidgets/XDialog.dart' as Dialog;
Dialog.Dialog dialog = Dialog.Dialog();

Models models = Models();

//Future<List<Map<String, dynamic>>>
Future<List<Map>> fetchSettingsFromDatabase() async {
  return models.getTableData('Settings');
}

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
  Color subIconColor = Colors.green;
  Color themeColor = stylex.violet;

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

  Future updateTheme(colorValue) async{
    String sqlStmt = "UPDATE Settings set value='" + colorValue.toString() + "' where name='ThemeColor'";
    await models.rawQuery(sqlStmt);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(color: Colors.white);
    
    
    List<Widget> themesList = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Card(
            child: IconButton(
              icon: Icon(Icons.donut_small, color: Colors.red, size: 33),
              onPressed: (){
                print(Colors.red);
                setState(() {
                  themeColor = Color(Colors.pink.value);
                });
                // updateTheme(Colors.red.value);
              },
            ),
          ),
          Card(
            child: IconButton(
              icon: Icon(Icons.donut_small, color: Colors.green, size: 33),
              onPressed: (){
                print(Colors.green);
                setState(() {
                  themeColor = Color(Colors.green.value);
                });
                // updateTheme(Colors.red.value);
              },
            ),
          ),
        ],
      ),
    ];
    
    // models.getTableData("Settings").then((settings){
    //   for(int i = 0; i <= settings.length; i++){
    //     print(settings[i]);
    //   }
    // });
    Future themes = fetchSettingsFromDatabase();
    

    return MaterialApp(
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: themeColor,
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
                  backgroundColor: themeColor,
              ),

              body: TabBarView(
                controller: _tabController,
                children: [
                  DashboardPage(),
                  AccountsPage(),
                ],
              ),
              drawer: Drawer(
                child: Container(
                  color: themeColor,
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        accountName: Text(conf.appAuthor),
                        accountEmail: Text(conf.appEmail),
                        currentAccountPicture: CircleAvatar(backgroundColor: Colors.black26,child: Text(conf.appAuthor[0], style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),),),
                        // decoration: BoxDecoration(
                        //   gradient: LinearGradient(
                        //       colors: <Color>[ //7928D1
                        //         const Color(0xFF7928D2), const Color(0xFF9A4DFF)],
                        //       stops: <double>[0.3, 0.5],
                        //       begin: Alignment.topRight, end: Alignment.bottomLeft
                        //   ),
                        // ),
                      ),
                      
                      ExpansionTile(
                        title: Text("Pages", style: titleStyle),
                        initiallyExpanded: false,
                        trailing: Icon(Icons.pages, color: Colors.white,),
                        children: <Widget>[
                          ListTile(
                            title: Text("Dashboard", style: titleStyle),
                            leading: Icon(Icons.access_alarm, color: this.subIconColor, size: 23),onTap: () => _tabController.animateTo((1 + 1) % 2),
                          ),
                          ListTile(
                            title: Text("Accounts", style: titleStyle),
                            leading: Icon(Icons.data_usage, color: subIconColor, size: 23),
                            onTap: () {
                              // _tabController.animateTo((_tabController.index + 1) % 2);
                              _tabController.animateTo((2 + 1) % 2);
                            },
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text("Masters", style: titleStyle),
                        trailing: Icon(Icons.compare_arrows, color: Colors.white,),
                        children: <Widget>[
                          ListTile(
                            title: Text("Category", style: titleStyle),
                            leading: Icon(Icons.view_compact, color: subIconColor, size: 23),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => categList.MyCategoryList()));
                            },
                          ),
                          ListTile(
                            title: Text("Account Type", style: titleStyle),
                            leading: Icon(Icons.tab_unselected, color: subIconColor, size: 23),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AccountTypeList()));
                            },
                          ),
                        ],
                      ),

                      ExpansionTile(
                        title: Text("Preferences", style: titleStyle),
                        trailing: Icon(Icons.settings, color: Colors.white,),
                        children: <Widget>[
                          ExpansionTile(
                            title: Text("Theme", style: titleStyle),
                            leading: Icon(Icons.ac_unit, color: subIconColor, size: 23),
                            children: themesList,
                          ),
                          ListTile(
                            title: Text("Logout", style: titleStyle),
                            leading: Icon(Icons.lock_outline, color: subIconColor, size: 23),
                            onTap: () {
                              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
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


// DropdownButton _dropDownButtonList() => DropdownButton<String>(
//   items: [
//     DropdownMenuItem(
//       value: "1",
//       child: ListTile(
//         title: Text("Accounts", style: titleStyle),
//         trailing: Icon(Icons.data_usage, color: Colors.yellowAccent, size: 33),
//         onTap: () {
//           // _tabController.animateTo((_tabController.index + 1) % 2);
//           _tabController.animateTo((2 + 1) % 2);
//         },
//       ),
//     ),
//     DropdownMenuItem(
//       value: "2",
//       child: Text(
//         "Second",
//       ),
//     ),
//   ],
//   onChanged: (value) {
//     setState(() {
//       _value = value;
//     });
//   },
//   value: _value,
// );
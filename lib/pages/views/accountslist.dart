import 'dart:async' show Future;
import 'package:flutter/material.dart';

import './../../Xwidgets/XDialog.dart' as Dialog;
import './../../config/config.dart' as conf;

import '../models/category.dart' show categColor;
import './accountdetail.dart' show AccountDetailPage;

// import '../../Xwidgets/XlistTile.dart';
// import '../models/category.dart' show categoryTypes, transactionTypes;
import '../../dbutils/DBhelper.dart' show Models;

Models models = Models();

Dialog.Dialog dialog = Dialog.Dialog();

//Future<List<Map<String, dynamic>>>
Future<List<Map>> fetchAccountsFromDatabase() async {
  return models.getTableData('Accounts');
}

class AccountsPage extends StatefulWidget {

  
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState  extends State<AccountsPage>{
  TextStyle titleStyle = TextStyle(color: Colors.black);
  Future listViewFeature = fetchAccountsFromDatabase();

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   shrinkWrap: true,
    //   padding: EdgeInsets.all(0.8),
    //   children: <Widget>[
    //     XListTile(desc: "Room Rent", category: categoryTypes[2], transactionType: transactionTypes[1], amount: 2500),
    //     XListTile(desc: "Salary", category: categoryTypes[1], transactionType: transactionTypes[1], amount: 27500),
    //     XListTile(desc: "Abi", category: categoryTypes[3], transactionType: transactionTypes[0], amount: 500),
    //     XListTile(desc: "BalaVignesh", category: categoryTypes[0], transactionType: transactionTypes[0], amount: 2500),
    //   ],
    // );
    return new Container(
        padding: new EdgeInsets.all(0.0),
        child: new FutureBuilder<List<Map>>(
          future: listViewFeature,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  // return XListTile(desc: snapshot.data[index]['name'], category: snapshot.data[index]['categoryType'], transactionType: snapshot.data[index]['transType'], amount: snapshot.data[index]['amount']);
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                        title: Text(snapshot.data[index]['name']),
                        subtitle: Row(
                          children: <Widget>[
                            Text(snapshot.data[index]['transType'], style: TextStyle(color: Colors.green, fontSize: 10)),
                          ],
                        ),
                        leading: CircleAvatar(backgroundColor: categColor[snapshot.data[index]['categoryType']], child: Text(snapshot.data[index]['categoryType'][0], style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),),),
                        trailing: Chip(
                          label: Text(snapshot.data[index]['amount'].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          avatar: CircleAvatar(
                            child: Image(image: AssetImage(conf.currencyIcon), width: 16,),
                            backgroundColor: Colors.white,
                            // foregroundColor: Colors.white,
                          ),
                          backgroundColor: categColor[snapshot.data[index]['categoryType']],
                        ),
                        onTap: (){
                          navigateToAccountDetail("Edit Entry(" + snapshot.data[index]['id'].toString() + ")", snapshot.data[index]);
                        },
                        onLongPress: (){
                          dialog.asyncConfirm(context).then((choice){
                            if(choice == true){
                              _delete(snapshot.data[index]['id']);
                            }
                          });
                        },
                      )
                  );
                });
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }
            return new Container(alignment: AlignmentDirectional.center,child: new CircularProgressIndicator(),);
          },
        ),
      );
  }

  void moveToLastScreen(){
    Navigator.pop(context);
  }
  
  void _delete(int id) async {

		// moveToLastScreen();

		// Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
		// the detail page by pressing the FAB of NoteList page.
		if (id == null) {
			print('Warning : No Type was deleted');
			return;
		}
    
    models.delete("Accounts", id);
    updateListView();
  }

  void updateListView(){
    setState(() {
      listViewFeature = fetchAccountsFromDatabase();
    });
  }  

  void navigateToAccountDetail(String title, Map listData) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return AccountDetailPage(title, listData);
	  }));
    // print(result);
	  if (result == true) {
	  	updateListView();
	  }
  }
}
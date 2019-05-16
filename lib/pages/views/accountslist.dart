import 'dart:async' show Future;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './../../Xwidgets/XDialog.dart' as Dialog;

import './accountdetail.dart' show AccountDetailPage;

import '../../Xwidgets/XlistTile.dart';
import '../../dbutils/DBhelper.dart' show Models;

Models models = Models();

Dialog.Dialog dialog = Dialog.Dialog();

//Future<List<Map<String, dynamic>>>
Future<List<Map>> fetchAccountsFromDatabase() async {
  String qry = """
    select 
      ac.*,
      cat.name as categoryName,
      cat.categoryType
    from Accounts ac
    left join Category cat on cat.id = ac.categoryId
  """;
  Future<List<Map>> result = models.rawQuery(qry);
  // return models.getTableData('Accounts', orderBy: 'createDate ASC');
  return result;
}


class AccountsPage extends StatefulWidget {
  
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState  extends State<AccountsPage>{
  Future listViewFeature;
  Map categoryM2O;

  @override
  void initState() {
    super.initState();
    setState(() {
      listViewFeature = fetchAccountsFromDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TextStyle titleStyle = TextStyle(color: Colors.black87, fontSize: 18);
    return new Container(
        margin: EdgeInsets.all(10.0),
        child: new FutureBuilder<List<Map>>(
          future: listViewFeature,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: XListTile(
                      index: index,
                      desc: snapshot.data[index]['name'],
                      category: snapshot.data[index]['categoryName'] ?? '',
                      categoryType: snapshot.data[index]['categoryType'] ?? '',
                      transactionType: snapshot.data[index]['transType'],
                      amount: snapshot.data[index]['amount'],
                      createDate: snapshot.data[index]['createDate']
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
	  if (result == true) {
	  	updateListView();
	  }
  }
}

String truncate(String input,int maxLength)
{
   if(input.length > maxLength)
      return input.substring(0,maxLength);
   return input;
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../utils/dbHelper.dart';

import '../models/account_type.dart';
import 'account_type_detail.dart';


class AccountTypeList extends StatefulWidget {

	@override
  State<StatefulWidget> createState() {

    return AccountTypeListState();
  }
}

class AccountTypeListState extends State<AccountTypeList> {

	DatabaseHelper databaseHelper = DatabaseHelper();
	List<ModelAccountType> accountList;
	int count = 0;

	@override
  Widget build(BuildContext context) {

		if (accountList == null) {
			accountList = List<ModelAccountType>();
			updateListView();
		}

    return Scaffold(

	    appBar: AppBar(
		    title: Text('Account Type'),
	    ),

	    body: getAccountTypeListView(),

	    floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        
		    onPressed: () {
		      debugPrint('FAB clicked');
		      navigateToDetail(ModelAccountType(''), 'Add Account Type');
		    },

		    tooltip: 'Add Account Type',

		    child: Image(
          width: 50,
          image: AssetImage("assets/inc_pen.png"),
        ),

        backgroundColor: Colors.transparent,

	    ),
    );
  }

  ListView getAccountTypeListView() {

		TextStyle titleStyle = Theme.of(context).textTheme.subhead;

		return ListView.builder(
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
				return Card(
					color: Colors.white,
					elevation: 2.0,
					child: ListTile(

						leading: CircleAvatar(
							backgroundColor: getCategColor(this.accountList[position].name),
							child: getCategIcon(this.accountList[position].name),
						),

						title: Text(this.accountList[position].name, style: titleStyle,),

						subtitle: Row(
              children: <Widget>[
                Text(this.accountList[position].createDate),
              ],
            ),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
								_delete(context, this.accountList[position]);
							},
						),


						onTap: () {
							debugPrint("ListTile Tapped");
							navigateToDetail(this.accountList[position],'Edit AccountType');
						},

					),
				);
			},
		);
  }

  // Returns the priority color
	Color getCategColor(String cName) {
		switch (cName) {
			case "income":
				return Colors.green;
				break;
			case "expense":
				return Colors.red;
				break;
      case "borrow":
				return Colors.orange;
				break;
      case "lend":
				return Colors.teal;
				break;
			default:
				return Colors.amber;
		}
	}

	// Returns the priority icon
	Widget getCategIcon(String cName) {
		return CircleAvatar(
      backgroundColor: getCategColor(cName.toLowerCase()),
      child: Text(cName[0], style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white)),
      );
	}

	void _delete(BuildContext context, ModelAccountType categ) async {

		int result = await databaseHelper.delete(accountTypeTable, colId, categ.id);
		if (result != 0) {
			_showSnackBar(context, 'Account Type Deleted Successfully');
			updateListView();
		}
	}

	void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}

  void navigateToDetail(ModelAccountType acType, String title) async {
	  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return AcTypeDetail(acType, title);
	  }));

	  if (result == true) {
	  	updateListView();
	  }
  }

  void updateListView() {

		final Future<Database> dbFuture = databaseHelper.initializeDatabase();
		dbFuture.then((database) {

			Future<List<dynamic>> accountTypeFuture = databaseHelper.getObjList(accountTypeTable, "$colId ASC");
			accountTypeFuture.then((catList) {
				setState(() {
				  this.accountList = catList;
				  this.count = catList.length;
				});
			});
		});
  }
}

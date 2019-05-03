import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../forms/expense_purchase.dart';
import '../../main.utils/pat_db_helper.dart';
import '../../main.utils/common.utils.dart' as com;

enum ConfirmAction { CANCEL, ACCEPT }

class ExpensePur extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExpensePurchase();
  }
}

class ExpensePurchase extends State<ExpensePur> {

   @override
  void initState(){
    super.initState();
    updateListView(); 
  }

  DatabaseHelper databaseHelper = DatabaseHelper();
	List<Map<String, dynamic>> exppurList;
  int count = 0;

   @override
  Widget build(BuildContext context) { 
    if (exppurList == null) {
			exppurList = List<Map<String, dynamic>>();
      updateListView(); 
		}
    
  return new Scaffold(
   body: ListView.builder(
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
          return Card(
					color: Colors.white,
					elevation: 2.0,
					child: ListTile(

						leading: CircleAvatar(
							backgroundColor: Colors.black,
						),

						title: Text(this.exppurList[position]['storename']),

						subtitle: Text(this.exppurList[position]['product']),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
								_asyncConfirmDialog(context, this.exppurList[position]['id']);
							},
						),


						// onTap: () {
						// 	debugPrint("ListTile Tapped");
						// 	navigateToDetail(this.noteList[position],'Edit Note');
						// },

					),
				);	
			},
		),
    floatingActionButton: new FloatingActionButton(
	      elevation: 0.0,
	      child: Image(
	        width: 50,
	        image: AssetImage("assets/inc_pen.png"),
	      ),
	      backgroundColor: Colors.transparent,
	      onPressed: () async{
	        var result = await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new EXPForm()));
	      
          if(result == true){
            updateListView();
          }
        }
	    )
  );
  }

  Future<List<Map<String, dynamic>>> updateListView() async {
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Map<String, dynamic>>> noteListFuture = databaseHelper.getExpPurchaseList();
          noteListFuture.then((noteList) {
              setState(() {
                 this.exppurList = noteList;
                this.count = exppurList.length;
              });
        });
      });
  }

  void _delete(BuildContext context, int id) async {
		int result = await databaseHelper.deleteExpPurchase(id);
		if (result != 0) {
			updateListView();
		}
	}

  void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context, id) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Dialog'),
          content: const Text(
              'Do you want to delete ?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('ACCEPT'),
              onPressed: () {
                _delete(context, id);
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../forms/expense_purchase.dart';
import '../utils/expensedb_helper.dart';

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
								_delete(context, this.exppurList[position]['id']);
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
	      onPressed: (){
	        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new EXPForm()));
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
			_showSnackBar(context, 'Purchase Expense Deleted Successfully');
			updateListView();
		}
	}

  void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}
}
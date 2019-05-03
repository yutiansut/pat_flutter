import 'package:flutter/material.dart';
import '../forms/expense_online_form.dart';
import '../../main.utils/pat_db_helper.dart';
import 'package:sqflite/sqflite.dart';

class ExpOnline extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExpenseOnline();
  }
}

class ExpenseOnline extends State<ExpOnline> {

  DatabaseHelper databaseHelper = DatabaseHelper();
	List<Map<String, dynamic>> exponlineList;
  int count = 0;

  @override
  void initState(){
    super.initState();
    updateListView(); 
  }

   @override
  Widget build(BuildContext context) {

    if (exponlineList == null) {
			exponlineList = List<Map<String, dynamic>>();
      updateListView(); 
		}
    print(exponlineList);
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

						title: Text(this.exponlineList[position]['storename']),

						subtitle: Text(this.exponlineList[position]['product']),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
								_delete(context, this.exponlineList[position]['id']);
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
	      onPressed: () async {
	       var result = await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
           return new EXPForm();
         }));

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
        Future<List<Map<String, dynamic>>> noteListFuture = databaseHelper.getExpOnlineList();
          noteListFuture.then((noteList) {
              setState(() {
                 this.exponlineList = noteList;
                this.count = exponlineList.length;
              });
        });
      });
  }

  void _delete(BuildContext context, int id) async {
		int result = await databaseHelper.deleteExpOnline(id);
		if (result != 0) {
			_showSnackBar(context, 'Expense Online Deleted Successfully');
			updateListView();
		}
	}

  void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}
}
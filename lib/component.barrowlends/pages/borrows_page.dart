import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../forms/borrows_form.dart';
import '../utils/barrowlend_helper.dart';

class Barrows extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BorrowPage();
  }
}

class BorrowPage extends State<Barrows> {
  DatabaseHelper databaseHelper = DatabaseHelper();
	List<Map<String, dynamic>> barrowsList;
  int count = 0;

  @override
  void initState(){
    super.initState();
    updateListView(); 
  }

   @override
  Widget build(BuildContext context) { 

    if (barrowsList == null) {
			barrowsList = List<Map<String, dynamic>>();
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

						title: Text(this.barrowsList[position]['lendername']),

						subtitle: Text(this.barrowsList[position]['barrowamount'].toString()),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
								_delete(context, this.barrowsList[position]['id']);
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
	         Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new BarrowForm()));
	      }
	    )
  );
  }

  Future<List<Map<String, dynamic>>> updateListView() async {
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Map<String, dynamic>>> noteListFuture = databaseHelper.getLendsList();
          noteListFuture.then((noteList) {
              setState(() {
                 this.barrowsList = noteList;
                this.count = barrowsList.length;
              });
        });
      });
  }

  void _delete(BuildContext context, int id) async {
		int result = await databaseHelper.deleteBarrows(id);
		if (result != 0) {
			_showSnackBar(context, 'Barrow is Deleted Successfully');
			updateListView();
		}
	}

  void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}
}
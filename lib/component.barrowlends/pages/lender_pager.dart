import 'package:flutter/material.dart';
import '../forms/lender_form.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/barrowlend_helper.dart';

class Lends extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LenderPage();
  }
}

class LenderPage extends State<Lends> {

  DatabaseHelper databaseHelper = DatabaseHelper();
	List<Map<String, dynamic>> lendssList;
  int count = 0;

  @override
  void initState(){
    super.initState();
    updateListView(); 
  }

   @override
  Widget build(BuildContext context)  {
    if (lendssList == null) {
			lendssList = List<Map<String, dynamic>>();
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

						title: Text(this.lendssList[position]['barrowername']),

						subtitle: Text(this.lendssList[position]['lendamount'].toString()),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
								_delete(context, this.lendssList[position]['id']);
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
	         Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new LENDForm()));
	      }
	    )
  );
  }

  Future<List<Map<String, dynamic>>> updateListView() async {
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Map<String, dynamic>>> noteListFuture = databaseHelper.getBarrowsList();
          noteListFuture.then((noteList) {
              setState(() {
                 this.lendssList = noteList;
                this.count = lendssList.length;
              });
        });
      });
  }

  void _delete(BuildContext context, int id) async {
		int result = await databaseHelper.deleteLends(id);
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
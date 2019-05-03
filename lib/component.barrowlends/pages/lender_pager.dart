import 'package:flutter/material.dart';
import '../forms/lender_form.dart';
import 'package:sqflite/sqflite.dart';
import '../../main.utils/pat_db_helper.dart';

enum ConfirmAction { CANCEL, ACCEPT }

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
								_asyncConfirmDialog(context, this.lendssList[position]['id']);
							},
						),
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
	        var result = Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new LENDForm()));

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
        Future<List<Map<String, dynamic>>> noteListFuture = databaseHelper.getLendsList();
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
			updateListView();
		}
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
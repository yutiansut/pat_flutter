import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../forms/borrows_form.dart';
import '../../main.utils/pat_db_helper.dart';
import '../../main.utils/common.utils.dart' as com;
enum ConfirmAction { CANCEL, ACCEPT }

class Barrows extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BorrowPage();
  }
}

class BorrowPage extends State<Barrows> {
  TextStyle descStyle =  TextStyle(fontWeight: FontWeight.w500);
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
     padding: EdgeInsets.all(12),
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.0),
              ),
					color: Colors.white,
					elevation: 2.0,
					child: Container(
            decoration: BoxDecoration(color: Colors.teal[50],
            borderRadius: BorderRadius.circular(60.0)),
            child: ListTile(

						leading: CircleAvatar(
              child: Text(this.barrowsList[position]['lendername'][0].toUpperCase() , textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28,color: Colors.redAccent)),
							backgroundColor: Colors.amberAccent,
						),

						title: Text(this.barrowsList[position]['lendername'].toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold)),

						subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
    
              children: <Widget>[
                Text(this.barrowsList[position]['description'], style: descStyle,),
                
                  
                  // Text(this.exppurList[position]['description'], style: descStyle,)
                
              ],
            ),

						trailing: Column(
              children: <Widget>[
                Chip(
                  label: Text(this.barrowsList[position]['barrowamount'].toString(),style: TextStyle(color: Colors.white)),
                  avatar:  Image(
                      width: 50,
                      image: AssetImage("assets/rupees.png"),
                    ),
                  backgroundColor: Colors.deepPurpleAccent,
                ),

              ],
            ),
            onLongPress: () async {
              await _asyncConfirmDialog(context, this.barrowsList[position]['id']);
            },


						// onTap: () {
						// 	debugPrint("ListTile Tapped");
						// 	navigateToDetail(this.noteList[position],'Edit Note');
						// },

					),
          )
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
	         var result = await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new BarrowForm()));

            if(result == true){
              updateListView();
            }
        }
	    ),
      backgroundColor: Colors.white,
  );
  }

  Future<List<Map<String, dynamic>>> updateListView() async {
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Map<String, dynamic>>> noteListFuture = databaseHelper.getBarrowsList();
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
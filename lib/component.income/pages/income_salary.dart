import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../forms/income_salary_form.dart';
import '../../main.utils/pat_db_helper.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class IncomeSale extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IncomeSalary();
  }
}

class IncomeSalary extends State<IncomeSale> {

  DatabaseHelper databaseHelper = DatabaseHelper();
	List<Map<String, dynamic>> salaryList;
  int count = 0;

  @override
  void initState(){
    super.initState();
    updateListView(); 
  }

  @override
  Widget build(BuildContext context) {
    print(salaryList);
    if (salaryList == null) {
			salaryList = List<Map<String, dynamic>>();
      updateListView(); 
		}

    TextStyle descStyle =  TextStyle(fontWeight: FontWeight.w500);

    return new Scaffold(
     body: ListView.builder(
       padding: EdgeInsets.all(12),
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
          return Card(
					color: Colors.white,
					elevation: 2.0,
          // margin: EdgeInsets.all(10.0),
					child: ListTile(

						leading: CircleAvatar(
              child: Text(this.salaryList[position]['contact'][0].toUpperCase() , textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.pinkAccent),),
							backgroundColor: Colors.black,
						),

						title: Text(this.salaryList[position]['contact'].toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
          

						subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
    
              children: <Widget>[
                Text(this.salaryList[position]['description'], style: descStyle,)
              ],
            ),
            
            
            

						trailing: Column(
              children: <Widget>[
                Chip(
                  label: Text(this.salaryList[position]['amount'].toString()),
                  avatar:  Image(
                      width: 50,
                      image: AssetImage("assets/rupees.png"),
                    ),
                  backgroundColor: Colors.greenAccent,
                ),

              ],
            ),
            onLongPress: () async {
              await _asyncConfirmDialog(context, this.salaryList[position]['id']);
            },
            


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
	         var result = await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new INForm()));
           if(result == true){
             updateListView();
           }
	      }
	    ),
      backgroundColor: Colors.black,
  );
  }

  Future<List<Map<String, dynamic>>> updateListView() async {
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Map<String, dynamic>>> noteListFuture = databaseHelper.getSalaryList();
          noteListFuture.then((noteList) {
              setState(() {
                 this.salaryList = noteList;
                this.count = salaryList.length;
              });
        });
      });
  }

  void _delete(BuildContext context, int id) async {
		int result = await databaseHelper.deleteSalary(id);
		if (result != 0) {
			// _showSnackBar(context, 'Salary Deleted Successfully');
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
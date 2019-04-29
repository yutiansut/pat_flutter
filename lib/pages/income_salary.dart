import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../forms/income_salary_form.dart';
import '../utils/db_helper.dart';


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

						title: Text(this.salaryList[position]['contact']),

						subtitle: Text(this.salaryList[position]['amount']),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
								_delete(context, this.salaryList[position]['id']);
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
	         Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new INForm()));
	      }
	    )
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
			_showSnackBar(context, 'Salary Deleted Successfully');
			updateListView();
		}
	}

  void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}

} 
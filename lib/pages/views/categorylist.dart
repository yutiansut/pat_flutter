import 'dart:async';
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../../utils/dbHelper.dart';
import 'categ_detail.dart';
import 'package:sqflite/sqflite.dart';


class CategList extends StatefulWidget {

	@override
  State<StatefulWidget> createState() {

    return CategListState();
  }
}

class CategListState extends State<CategList> {

	DatabaseHelper databaseHelper = DatabaseHelper();
	List<ModelCategory> categList;
	int count = 0;

	@override
  Widget build(BuildContext context) {

		if (categList == null) {
			categList = List<ModelCategory>();
			updateListView();
		}

    return Scaffold(

	    appBar: AppBar(
		    title: Text('Category'),
	    ),

	    body: getCategListView(),

	    floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        
		    onPressed: () {
		      debugPrint('FAB clicked');
		      navigateToDetail(ModelCategory(''), 'Add Category');
		    },

		    tooltip: 'Add Category',

		    child: Image(
          width: 50,
          image: AssetImage("assets/inc_pen.png"),
        ),

        backgroundColor: Colors.transparent,

	    ),
    );
  }

  ListView getCategListView() {

		TextStyle titleStyle = Theme.of(context).textTheme.subhead;

		return ListView.builder(
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
				return Card(
					color: Colors.white,
					elevation: 2.0,
					child: ListTile(

						leading: CircleAvatar(
							backgroundColor: getCategColor(this.categList[position].name),
							child: getCategIcon(this.categList[position].name),
						),

						title: Text(this.categList[position].name, style: titleStyle,),

						subtitle: Text(this.categList[position].createDate),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
								_delete(context, this.categList[position]);
							},
						),


						onTap: () {
							debugPrint("ListTile Tapped");
							navigateToDetail(this.categList[position],'Edit Category');
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

	void _delete(BuildContext context, ModelCategory categ) async {

		int result = await databaseHelper.delete(categoryTable, colId, categ.id);
		if (result != 0) {
			_showSnackBar(context, 'Category Deleted Successfully');
			updateListView();
		}
	}

	void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}

  void navigateToDetail(ModelCategory categ, String title) async {
	  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return CategDetail(categ, title);
	  }));

	  if (result == true) {
	  	updateListView();
	  }
  }

  void updateListView() {

		final Future<Database> dbFuture = databaseHelper.initializeDatabase();
		dbFuture.then((database) {

			Future<List<dynamic>> categListFuture = databaseHelper.getList(categoryTable, "$colId ASC");
			categListFuture.then((catList) {
				setState(() {
				  this.categList = catList;
				  this.count = catList.length;
				});
			});
		});
  }
}

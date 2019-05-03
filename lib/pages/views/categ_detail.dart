// import 'dart:async';
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../../utils/dbHelper.dart';
import 'package:intl/intl.dart';

class CategDetail extends StatefulWidget {

	final String appBarTitle;
	ModelCategory categ;

	CategDetail(this.categ, this.appBarTitle);

	@override
  State<StatefulWidget> createState() {

    return CategDetailState(this.categ, this.appBarTitle);
  }
}

class CategDetailState extends State<CategDetail> {

	// static var _priorities = ['High', 'Low'];

	DatabaseHelper helper = DatabaseHelper();

	String appBarTitle;
	ModelCategory categ;

	TextEditingController nameController = TextEditingController();
	// TextEditingController descriptionController = TextEditingController();

	CategDetailState(this.categ, this.appBarTitle);

	@override
  Widget build(BuildContext context) {

		TextStyle textStyle = Theme.of(context).textTheme.title;

		nameController.text = categ.name;
		// descriptionController.text = categ.name;

    return WillPopScope(

	    onWillPop: () {
	    	// Write some code to control things, when user press Back navigation button in device navigationBar
		    moveToLastScreen();
	    },

	    child: Scaffold(
	    appBar: AppBar(
		    title: Text(appBarTitle),
		    leading: IconButton(icon: Icon(
				    Icons.arrow_back),
				    onPressed: () {
		    	    // Write some code to control things, when user press back button in AppBar
		    	    moveToLastScreen();
				    }
		    ),
	    ),

	    body: Padding(
		    padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
		    child: ListView(
			    children: <Widget>[

			    	// First element
				    /* ListTile(
					    title: DropdownButton(
							    items: _priorities.map((String dropDownStringItem) {
							    	return DropdownMenuItem<String> (
									    value: dropDownStringItem,
									    child: Text(dropDownStringItem),
								    );
							    }).toList(),

							    style: textStyle,

							    // value: getCategAsString(categ.id),
							    value: categ.name,

							    onChanged: (valueSelectedByUser) {
							    	setState(() {
							    	  debugPrint('User selected $valueSelectedByUser');
							    	  // updateCategAsInt(valueSelectedByUser);
							    	});
							    }
					    ),
				    ), */

				    // Second Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: nameController,
						    style: textStyle,
						    onChanged: (value) {
						    	debugPrint('Something changed in Title Text Field');
						    	updateName();
						    },
						    decoration: InputDecoration(
							    labelText: 'Name',
							    labelStyle: textStyle,
							    border: OutlineInputBorder(
								    borderRadius: BorderRadius.circular(5.0)
							    )
						    ),
					    ),
				    ),

				    // Third Element
				    // Padding(
					  //   padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					  //   child: TextField(
						//     controller: descriptionController,
						//     style: textStyle,
						//     onChanged: (value) {
						// 	    debugPrint('Something changed in Description Text Field');
						// 	    updateDescription();
						//     },
						//     decoration: InputDecoration(
						// 		    labelText: 'Description',
						// 		    labelStyle: textStyle,
						// 		    border: OutlineInputBorder(
						// 				    borderRadius: BorderRadius.circular(5.0)
						// 		    )
						//     ),
					  //   ),
				    // ),

				    // Fourth Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: Row(
						    children: <Widget>[
						    	Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Save',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
									    	setState(() {
									    	  debugPrint("Save button clicked");
									    	  _save();
									    	});
									    },
								    ),
							    ),

							    Container(width: 5.0,),

							    Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Delete',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
										    setState(() {
											    debugPrint("Delete button clicked");
											    _delete();
										    });
									    },
								    ),
							    ),

						    ],
					    ),
				    ),

			    ],
		    ),
	    ),

    ));
  }

  void moveToLastScreen() {
		Navigator.pop(context, true);
  }

	// Convert the String priority in the form of integer before saving it to Database
	// void updateCategAsInt(String value) {
	// 	switch (value) {
	// 		case 'Income':
	// 			categ.id = 1;
	// 			break;
	// 		case 'Expense':
	// 			categ.id = 2;
	// 			break;
	// 	}
	// }

	// Convert int priority to String priority and display it to user in DropDown
	// String getCategAsString(int value) {
	// 	String priority;
	// 	switch (value) {
	// 		case 1:
	// 			priority = _priorities[0];  // 'High'
	// 			break;
	// 		case 2:
	// 			priority = _priorities[1];  // 'Low'
	// 			break;
	// 	}
	// 	return priority;
	// }

	// Update the title of Note object
  void updateName(){
    categ.name = nameController.text;
  }

	// Update the description of Note object
	// void updateDescription() {
	// 	categ.createDate = descriptionController.text;
	// }

	// Save data to database
	void _save() async {

		moveToLastScreen();

		categ.createDate = DateFormat.yMMMd().format(DateTime.now());
		int result;
		if (categ.id != null) {  // Case 1: Update operation
			result = await helper.update(categoryTable, categ, colId);
		} else { // Case 2: Insert Operation
			result = await helper.insert(categoryTable, categ);
		}

		if (result != 0) {  // Success
			_showAlertDialog('Status', 'Category Saved Successfully');
		} else {  // Failure
			_showAlertDialog('Status', 'Problem Saving Category');
		}

	}

	void _delete() async {

		moveToLastScreen();

		// Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
		// the detail page by pressing the FAB of NoteList page.
		if (categ.id == null) {
			_showAlertDialog('Warning', 'No Note was deleted');
			return;
		}

		// Case 2: User is trying to delete the old note that already has a valid ID.
		int result = await helper.delete(categoryTable, colId, categ.id);
		if (result != 0) {
			_showAlertDialog('Status', 'Category Deleted Successfully');
		} else {
			_showAlertDialog('Warning', 'Error Occured while Deleting Category');
		}
	}


  Future<void> _showAlertDialog(String title, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text(title),
        content: ListTile(
          title: Text(title),
          subtitle: Text(message),
          leading: IconButton(
            icon: Icon(Icons.info),
            color: Colors.green,
            onPressed: (){},
          ),
        ),
        actions: <Widget>[
          /* FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ), */
        ],
      );
    },
  );
}

}
import 'dart:async';
import 'package:flutter/material.dart';
import '../models/account_type.dart';
import '../../utils/dbHelper.dart';
import 'package:intl/intl.dart';

class AcTypeDetail extends StatefulWidget {

	final String appBarTitle;
	final ModelAccountType acType;

	AcTypeDetail(this.acType, this.appBarTitle);

	@override
  State<StatefulWidget> createState() {

    return AcTypeDetailState(this.acType, this.appBarTitle);
  }
}

class AcTypeDetailState extends State<AcTypeDetail> {


	DatabaseHelper helper = DatabaseHelper();

	String appBarTitle;
	ModelAccountType acType;

	// static var _priorities = ['High', 'Low'];

	TextEditingController nameController = TextEditingController();
	TextEditingController typeController = TextEditingController();
	// TextEditingController descriptionController = TextEditingController();

	AcTypeDetailState(this.acType, this.appBarTitle);

	@override
  Widget build(BuildContext context) {

		TextStyle textStyle = Theme.of(context).textTheme.title;

		nameController.text = acType.name;
		// typeController.text = categ.typeId.toString();
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
		    // padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
		    padding: EdgeInsets.all(5),
		    child: ListView(
			    children: <Widget>[

			    	// First element
				    // ListTile(
					  //   title: DropdownButton(
						// 	    items: _priorities.map((String dropDownStringItem) {
						// 	    	return DropdownMenuItem<String> (
						// 			    value: dropDownStringItem,
						// 			    child: Text(dropDownStringItem),
						// 		    );
						// 	    }).toList(),

						// 	    style: textStyle,

						// 	    value: getAccountTypeAsString(categ.typeId),
						// 	    // value: categ.typeId,

						// 	    onChanged: (valueSelectedByUser) {
						// 	    	setState(() {
						// 	    	  debugPrint('User selected $valueSelectedByUser');
						// 	    	  updateAccountTypeAsInt(valueSelectedByUser);
						// 	    	});
						// 	    }
					  //   ),
				    // ),

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
		Navigator.pop(context, true);  //Second parameter "true" for updating list view 
  }

	// Convert the String priority in the form of integer before saving it to Database
	// void updateAccountTypeAsInt(String value) {
	// 	switch (value) {
	// 		case 'Income':
	// 			acType.id = 1;
	// 			break;
	// 		case 'Expense':
	// 			categ.typeId = 2;
	// 			break;
	// 	}
	// }

	// Convert int priority to String priority and display it to user in DropDown
	// String getAccountTypeAsString(int value) {
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
    acType.name = nameController.text;
  }
  // void updateTypeId(){
  //   categ.typeId = int.parse(typeController.text);
  // }

	// Update the description of Note object
	// void updateDescription() {
	// 	categ.createDate = descriptionController.text;
	// }

	// Save data to database
	void _save() async {

		moveToLastScreen();

		acType.createDate = DateFormat.yMMMd().format(DateTime.now());
		int result;
		if (acType.id != null) {  // Case 1: Update operation
			result = await helper.update(accountTypeTable, acType, colId);
		} else { // Case 2: Insert Operation
			result = await helper.insert(accountTypeTable, acType);
		}

		if (result != 0) {  // Success
			_showAlertDialog('Status', 'Type Saved Successfully');
		} else {  // Failure
			_showAlertDialog('Status', 'Problem Saving Type');
		}

	}

	void _delete() async {

		moveToLastScreen();

		// Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
		// the detail page by pressing the FAB of NoteList page.
		if (acType.id == null) {
			_showAlertDialog('Warning', 'No Type was deleted');
			return;
		}

		// Case 2: User is trying to delete the old note that already has a valid ID.
		int result = await helper.delete(accountTypeTable, colId, acType.id);
		if (result != 0) {
			_showAlertDialog('Status', 'Type Deleted Successfully');
		} else {
			_showAlertDialog('Warning', 'Error Occured while Deleting Type');
		}
	}


  Future<void> _showAlertDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
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
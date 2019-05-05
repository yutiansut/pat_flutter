import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../utils/dbHelper.dart';
import 'package:intl/intl.dart';
import '../models/category.dart';
import '../models/account_type.dart' as actype;

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


	DatabaseHelper helper = DatabaseHelper();

	String appBarTitle;
	ModelCategory categ;

	TextEditingController nameController = TextEditingController();
	TextEditingController typeController = TextEditingController();
	// TextEditingController descriptionController = TextEditingController();
	
  List accountList = [];
  List acm2olist;
	int acTypecount = 0;
  String typeIdText;

	CategDetailState(this.categ, this.appBarTitle);

  @override
  void initState() {
    super.initState();
    getM2O();  //Initiate many2one field data
  }

	@override
  Widget build(BuildContext context) {

		TextStyle textStyle = Theme.of(context).textTheme.title;

		nameController.text = categ.name;
		typeController.text = getAccountTypeAsString(categ.typeId);
		// descriptionController.text = categ.name;

    // getM2O();

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
              /* ListTile(
                title: DropdownButtonFormField(
                    items: accountList != null ? accountList.map((item){
                      return DropdownMenuItem<String> (
                        value: item['id'].toString(),
                        child: Text(item['name']),
                      );
                    }).toList() : ['New'].map((String item){
                      return DropdownMenuItem<String> (
                        value: '0',
                        child: Text('New'),
                      );
                    }),

                    style: textStyle,

                    value: getAccountTypeAsString(categ.typeId),
                    // value: categ.typeId,

                    onChanged: (valueSelectedByUser) {
                      setState(() {
                        debugPrint('User selected $valueSelectedByUser');
                        updateAccountTypeAsInt(valueSelectedByUser);
                      });
                    }
                ),
              ), */

              Row(
                children: <Widget>[
                  DropdownButton(
                    items: ['1','2','3'].map((item){
                      return DropdownMenuItem<String> (
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    value: this.typeIdText,
                    onChanged: (value){
                      setState(() {
                        this.typeIdText = value;
                        categ.typeId = int.parse(value);
                      });
                    },
                  ),
                ],
              ),
              DropdownButtonFormField(
                items: ['1','2','3'].map((item){
                      return DropdownMenuItem<String> (
                        value: item,
                        child: Text(getAccountTypeAsString(int.parse(item))),
                      );
                }).toList(),
                value: this.typeIdText,
              ),

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

      )
    );
  }

  void moveToLastScreen() {
		Navigator.pop(context, true);  //Second parameter "true" for updating list view 
  }

	// Convert the String priority in the form of integer before saving it to Database
	void updateAccountTypeAsInt(String value) {
    if(acm2olist != null){
      acm2olist.forEach((item){
        print(item);
        print(item[1] + '--------------------'+ value);
        if(item[0] == value){
          categ.typeId = item[0];
        }
      });
    }
	}

	// Convert int priority to String priority and display it to user in DropDown
	String getAccountTypeAsString(int value) {
		String priority = 'No Item';
    if(acm2olist != null){
      acm2olist.forEach((item){
        if(item[0] == value){
          priority = item[1];
        }
      });
    }
		return priority;
	}

	// Update the title of Note object
  void updateName(){
    categ.name = nameController.text;
  }
  void updateTypeId(){
    categ.typeId = int.parse(typeController.text);
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
    print(categ.toString()+ "---------hari--------");
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

  getM2O(){
    final Future<Database> dbFuture = helper.initializeDatabase();
		dbFuture.then((database) async {

			var mapList = await helper.getMapList(actype.accountTypeTable, actype.colId + " ASC");
      int count = mapList.length;
      var m2oList = [];
      var acList =[];
      mapList.forEach((item){
        m2oList.add({'id': item['id'], 'name': item['name']});
        // m2oList.add();
      });
      mapList.forEach((item){
        // m2oList.add({item['id']: item['name']});
        acList.add([item['id'],item['name']]);
      });
			// for (int i = 0; i < count; i++) {
      //   actype.ModelAccountType.fromMap(mapList[i]);
      // }
      setState(() {
        this.accountList = m2oList;
        this.acm2olist = acList;
        this.acTypecount = count;
        this.typeIdText = categ.typeId.toString();
      });
		});
  }

}
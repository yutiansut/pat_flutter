import 'dart:async' show Future;

import 'package:flutter/material.dart' show AppBar, BuildContext, Colors, Column, Container, EdgeInsets, FlutterError, FlutterErrorDetails, Form, FormState, GlobalKey, Icon, IconButton, Icons, InputDecoration, Key, MaterialApp, MaterialPageRoute, Navigator, Padding, RaisedButton, Scaffold, ScaffoldState, SnackBar, State, StatefulWidget, StatelessWidget, Text, TextFormField, TextInputType, ThemeData, Widget, runApp, TextEditingController;

import './../models/category.dart' show Category;

import './categorylist.dart' show MyCategoryList;


void main(){
  /// The default is to dump the error to the console.
  /// Instead, a custom function is called.
  FlutterError.onError = (FlutterErrorDetails details) async {
    await _reportError(details);
  };
}


class CategoryDetailPage extends StatefulWidget {
  final String title;
  Map listData;

  CategoryDetailPage(this.title, this.listData);

  @override
  State<StatefulWidget> createState() {

    return CategoryDetailPageState(this.title, this.listData);
  }
}

class CategoryDetailPageState extends State<CategoryDetailPage> {

  String title;
  Map listData ;
  CategoryDetailPageState(this.title, this.listData);

  Category db = Category();

  final categoryScaffoldKey = GlobalKey<ScaffoldState>();
  final categoryFormKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  

  @override
  initState(){
    super.initState();
    db.init();
  }

  @override
  void dispose() {
    db.disposed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int recId = this.listData['id'];
    nameController.text = this.listData['name'];
    return Scaffold(
      key: categoryScaffoldKey,
      appBar: AppBar(
          title: Text(this.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.view_list),
              tooltip: 'Category List',
              onPressed: () {
                navigateToCategoryList();
              },
            ),
          ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: categoryFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (val) =>
                val.length == 0 ?"Enter Category" : null,
                onSaved: (val) => db.values['Category']['name'] = val,
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(labelText: 'createDate'),
                validator: (val) =>
                val.length ==0 ? 'Enter createDate' : null,
                onSaved: (val) => db.values['Category']['createDate'] = val,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Parent Category'),
                validator: (val) =>
                val.length ==0 ? 'Enter Parent Category' : null,
                onSaved: (val) => db.values['Category']['parentId'] = val,
              ),
              // TextFormField(
              //   keyboardType: TextInputType.emailAddress,
              //   decoration: InputDecoration(labelText: 'Email Id'),
              //   validator: (val) =>
              //   val.length ==0 ? 'Enter Email Id' : null,
              //   onSaved: (val) =>db.values['Employee']['emailId'] = val,
              // ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: RaisedButton(
                  onPressed: _submit,
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (this.categoryFormKey.currentState.validate()) {
      categoryFormKey.currentState.save();
    }else{
      return null;
    }

    db.save('Category');
    Navigator.pop(context);
    _showSnackBar("Data saved successfully");
  }

  void _showSnackBar(String text) {
    categoryScaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(text)));
  }

  void navigateToCategoryList(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyCategoryList()),
    );
  }
}


/// Reports [error] along with its [stackTrace]
Future<Null> _reportError(FlutterErrorDetails details) async {
  // details.exception, details.stack

  FlutterError.dumpErrorToConsole(details);
}
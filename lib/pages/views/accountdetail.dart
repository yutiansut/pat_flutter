import 'dart:async' show Future;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pat_flutter/Xwidgets/fields.dart';
import 'package:pat_flutter/pages/views/main_page.dart';
// import 'package:intl/intl.dart';

import './../../dbutils/DBhelper.dart' show Models;
import './../models/category.dart' show transactionTypes;

import './../../Xwidgets/fields.dart' show WidgetMany2One, WidgetSelection;

Models models = Models();

//Future<List<Map<String, dynamic>>>
Future<List<Map>> fetchCategoryFromDatabase() async {
  return models.getTableData("Category");
}

void main(){
  /// The default is to dump the error to the console.
  /// Instead, a custom function is called.
  FlutterError.onError = (FlutterErrorDetails details) async {
    await _reportError(details);
  };
}


class AccountDetailPage extends StatefulWidget {
  final String title;
  final Map listData;

  AccountDetailPage(this.title, this.listData);

  @override
  State<StatefulWidget> createState() {

    return AccountDetailPageState(this.title, this.listData);
  }
}

class AccountDetailPageState extends State<AccountDetailPage> {

  String title;
  Map listData ;
  AccountDetailPageState(this.title, this.listData);

  Models db = models;

  final accountScaffoldKey = GlobalKey<ScaffoldState>();
  final accountFormKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var amountController = TextEditingController();
  var categoryIdController = TextEditingController();
  var transTypeController = TextEditingController();
  Future categlistFeature = fetchCategoryFromDatabase();
  

  @override
  initState(){
    super.initState();
    db.init();
    initFormDefaultValues(this.listData);
  }

  @override
  void dispose() {
    db.disposed();
    super.dispose();
  }

  // Initiate Form view values
  initFormDefaultValues(Map listData){
    int recId = listData['id'];
    if(recId != null) {
      nameController.text = listData['name'];
      amountController.text = listData['amount'].toString();
      categoryIdController.text = listData['categoryId'].toString();
      transTypeController.text = listData['transType'].toString();
    } else {
      // categoryIdController.text = '';
      // transTypeController.text = '';
    }
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    
    db.values['Accounts']['id'] = this.listData['id'];

    return Scaffold(
      key: accountScaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Text(this.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.view_list),
              tooltip: 'Accounts List',
              onPressed: () {
                moveToLastScreen();
              },
            ),
          ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: accountFormKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (val){
                  if(val.length == 0) {
                    return "Enter Description";
                  } else {
                    nameController.text = val.toString();
                  }
                },
                onSaved: (val) => db.values['Accounts']['name'] = nameController.text,
              ),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                validator: (val){
                  amountController.text = val.toString();
                },
                onSaved: (val) => db.values['Accounts']['amount'] =  double.parse(amountController.text),
              ),
              
              WidgetSelection(
                label: 'TransactionType',
                controllerText: transTypeController.text,
                items: transactionTypes,
                onChanged: (val){
                  setState(() {
                    transTypeController.text = val;
                  });
                },
                onSaved: (val) => db.values['Accounts']['transType'] =  transTypeController.text,
              ),
              
              WidgetMany2One(
                tbl: 'Category',
                // valueKeyField: 'name',
                // defaultValue: {'': 'No'},
                valueField1: 'categoryType',
                controllerText: categoryIdController.text,
                onChanged: (val){
                  setState(() {
                    categoryIdController.text = val;
                  });
                },
                onSaved: (val){
                  db.values['Accounts']['categoryId'] =  categoryIdController.text ?? '';
                },
              ),
              
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                child: RaisedButton(
                  onPressed: _submit,
                  child: Text('Submit'),
                ),
              ),
              /* Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: RaisedButton(
                  onPressed: (){
                    print(DateTime.now());
                    print(DateFormat.QQQ().format(DateTime.now()));
                  },
                  child: Text('test'),
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    try {
      db.values['Accounts']['createDate'] = DateTime.now().toString();
      if (this.accountFormKey.currentState.validate()) {
        accountFormKey.currentState.save();
      }else{
        return null;
      }
      db.save('Accounts');
      // _showSnackBar("Data saved successfully");

      moveToLastScreen();
    } catch (e) {
      _showSnackBar(e.toString());
      throw e;
    }
  }

  void _showSnackBar(String text) {
    accountScaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(text)));
  }
  

  void moveToLastScreen(){
    // Navigator.pop(context, true);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
  }
  
}


/// Reports [error] along with its [stackTrace]
Future<Null> _reportError(FlutterErrorDetails details) async {
  // details.exception, details.stack

  FlutterError.dumpErrorToConsole(details);
}
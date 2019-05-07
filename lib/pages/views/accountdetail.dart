import 'dart:async' show Future;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../../dbutils/DBhelper.dart' show Models;
import './../models/category.dart' show categoryTypes, transactionTypes;

// import './../../Xwidgets/Xcommon.dart' show getM2o;

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
  Map listData;

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
  var categoryTypeController = TextEditingController();
  var transTypeController = TextEditingController();
  List<DropdownMenuItem> categoryDropDownList;
  

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
    // buildAndGetDropDownMenuItems();
    int recId = listData['id'];
    if(recId != null) {
      nameController.text = listData['name'];
      amountController.text = listData['amount'].toString();
      categoryTypeController.text = listData['categoryType'];
      transTypeController.text = listData['transType'].toString();
    } else {
      transTypeController.text = '-';
      categoryTypeController.text = '-';
    }
    setState(() {
    });
  }


  buildAndGetDropDownMenuItems() async {
    List<DropdownMenuItem> items;
    // List<DropdownMenuItem<String>> items = List();
    // items.add(DropdownMenuItem(value: 0.toString(), child: new Text('Choose')));
    await fetchCategoryFromDatabase().then((lists){
      items.add(DropdownMenuItem(value: '-', child: Text("No Data"),));
      for (var i = 0; i < lists.length; i++) {
        // items.add(DropdownMenuItem(value: lists[i]['id'].toString(), child: new Text(lists[i]['name'])));
        items.add(DropdownMenuItem(value: lists[i]['id'].toString(), child: new Text(lists[i]['name'])));
        // items.add({'id': lists[i]['id'], 'name':  lists[i]['name']});
      }
      // setState(() {
      //   this.categoryDropDownList = items;
      // });
      print(items);
      return items;  
    });
  }


  @override
  Widget build(BuildContext context) {
    
    db.values['Accounts']['id'] = this.listData['id'];

    return Scaffold(
      key: accountScaffoldKey,
      appBar: AppBar(
          title: Text(this.title),
          backgroundColor: Colors.amber,
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
          child: Column(
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
                    db.values['Accounts']['name'] = nameController.text;
                  }
                },
                // onSaved: (val) => db.values['Category']['name'] = val,
              ),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                validator: (val){
                  amountController.text = val.toString();
                  db.values['Accounts']['amount'] =  int.parse(amountController.text);
                },
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Transaction Type'),
                value: (transTypeController.text != null) ? transTypeController.text : '-',
                items: transactionTypes.map((item){
                  return DropdownMenuItem(
                    value: item,
                    child:Text(item)
                  );
                }).toList()
                ..add(DropdownMenuItem(value: '-', child: Text("No Data"),)),
                onChanged: (val){
                  // print(val);
                  setState(() {
                    transTypeController.text = val;
                    db.values['Accounts']['transType'] =  transTypeController.text;
                  });
                },
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Category Type'),
                value: (categoryTypeController.text != null) ? categoryTypeController.text : '-',
                items: categoryTypes.map((item){
                  return DropdownMenuItem(
                    value: item,
                    child:Text(item)
                  );
                }).toList()
                ..add(DropdownMenuItem(value: '-', child: Text("No Data"),)),
                onChanged: (val){
                  // print(val);
                  setState(() {
                    categoryTypeController.text = val;
                    db.values['Accounts']['categoryType'] =  categoryTypeController.text;
                  });
                },
              ),
              // FutureBuilder(
              //   future: buildAndGetDropDownMenuItems(),
              //   builder: (context, snapshot){
              //     if(snapshot.hasData){
              //       return DropdownButtonFormField(
              //         decoration: InputDecoration(labelText: 'Category'),
              //         value: '-',
              //         items: [DropdownMenuItem(value: '-', child: Text("No Data"),)],
              //         // ..add(DropdownMenuItem(value: '-', child: Text("No Data"),)),
              //         onChanged: (val){
              //           // print(val);
              //           setState(() {
              //             categoryTypeController.text = val;
              //             db.values['Accounts']['category'] =  categoryTypeController.text;
              //           });
              //         },
              //       );
              //     }
              //   },
              // ),
              
              
              // TextFormField(
              //   controller: parentIdController,
              //   keyboardType: TextInputType.phone,
              //   decoration: InputDecoration(labelText: 'Parent Category'),
              //   validator: (val){
              //     db.values['Category']['parentId'] =  parentIdController.text;
              //   },
              // ),
              
              /* Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FutureBuilder(
                    future: categoryListFeature,
                    builder: (context, snapshot) {
                      return DropdownButton(
                        isExpanded: true,
                        value: parentIdController.text,
                        items: this.categoryDropDownList.map((Map item){
                          return DropdownMenuItem<String>(
                            value: item['id'].toString(),
                            child: new Text(item['name']),
                          );
                        }).toList()
                        ..add(DropdownMenuItem<String>(value: '0', child: Text('Default'),)),
                        onChanged: (val){
                          parentIdController.text = val;
                          print(parentIdController.text);
                          db.values['Category']['parentId'] =  parentIdController.text;
                          setState(() {
                            this._currentParentId = parentIdController.text;
                          });
                        },
                      );
                    },
                  ),
                ],
              ), */
              
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
    db.values['Accounts']['createDate'] = DateFormat.yMMMd().format(DateTime.now());
    if (this.accountFormKey.currentState.validate()) {
      accountFormKey.currentState.save();
    }else{
      return null;
    }

    db.save('Accounts');
    _showSnackBar("Data saved successfully");

    moveToLastScreen();
  }

  void _showSnackBar(String text) {
    accountScaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(text)));
  }
  

  void moveToLastScreen(){
    Navigator.pop(context, true);
  }
  
}


/// Reports [error] along with its [stackTrace]
Future<Null> _reportError(FlutterErrorDetails details) async {
  // details.exception, details.stack

  FlutterError.dumpErrorToConsole(details);
}
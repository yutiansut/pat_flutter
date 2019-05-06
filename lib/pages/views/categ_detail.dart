import 'dart:async' show Future;

import 'package:flutter/material.dart';

import './../models/category.dart' show Category;

// import './../../Xwidgets/Xcommon.dart' show getM2o;

Category categDb = Category();

//Future<List<Map<String, dynamic>>>
Future<List<Map>> fetchCategoriesFromDatabase() async {
  return categDb.getCategories();
}

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

  var nameController = TextEditingController();
  var createDateController = TextEditingController();
  var parentIdController = TextEditingController();
  Future categoryListFeature = fetchCategoriesFromDatabase();
  var categoryDropDownList = List();
  String _selectedItem = '0';
  

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
    buildAndGetDropDownMenuItems(categoryListFeature);
    int recId = listData['id'];
    if(recId != null) {
      nameController.text = listData['name'];
      createDateController.text = listData['createDate'].toString();
      parentIdController.text = listData['parentId'].toString();
    } else {
      parentIdController.text = '0';
    }
  }

  updateDropDown(m2oList){
    List<DropdownMenuItem<String>> items = new List();
    items.add(DropdownMenuItem(value: 0.toString(), child: new Text('Choose')));
    print(m2oList);
    if(m2oList != null){
      for (Map item in m2oList) {
        items.add(DropdownMenuItem(value: item['id'].toString(), child: new Text(item['name'])));
      }
    }
    setState(() {
      this.categoryDropDownList = items;
    });
  }

  buildAndGetDropDownMenuItems(Future listItems) {
    List m2oList = getM2o(listItems);
    updateDropDown(m2oList);
  }

  getM2o(listFeature) {
    List<Map<dynamic, dynamic>> items = List();
    listFeature.then((lists){
      for (var i = 0; i < lists.length; i++) {
        items.add({'id': lists[i]['id'], 'name': lists[i]['name']});
      }
      updateDropDown(items); 
      return items;  
    });
  }


  @override
  Widget build(BuildContext context) {
    
    db.values['Category']['id'] = this.listData['id'];
    db.values['Category']['parentId'] = this.listData['parentId'];

    return Scaffold(
      key: categoryScaffoldKey,
      appBar: AppBar(
          title: Text(this.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.view_list, color: Colors.indigo,),
              tooltip: 'Category List',
              onPressed: () {
                moveToLastScreen();
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
                validator: (val){
                  if(val.length == 0) {
                    return "Enter Category";
                  } else {
                    db.values['Category']['name'] = nameController.text;
                  }
                },
                // onSaved: (val) => db.values['Category']['name'] = val,
              ),
              TextFormField(
                controller: createDateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(labelText: 'createDate'),
                validator: (val){
                  db.values['Category']['createDate'] =  createDateController.text;
                },
              ),
              TextFormField(
                controller: parentIdController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Parent Category'),
                validator: (val){
                  db.values['Category']['parentId'] =  parentIdController.text;
                },
              ),
              // Container(
              //   child: Xmany2one(fetchCategoriesFromDatabase()),
              // ),
              (this.categoryDropDownList != null) ?
              FutureBuilder(
                future: categoryListFeature,
                builder: (context, snapshot) {
                  return this.categoryDropDownList.length > 1 ? DropdownButton(
                    value: parentIdController.text,
                    items: this.categoryDropDownList,
                    // items: [DropdownMenuItem(value: 1.toString(), child: new Text('hh'))],
                    onChanged: (val){
                      print(val);
                      setState(() {
                        parentIdController.text = val;
                        db.values['Category']['parentId'] =  parentIdController.text;
                      });
                    },
                  ) : DropdownButton(items: [DropdownMenuItem(value: 0.toString(), child: new Text('hh'))], onChanged: (val){},);
                },
              ): Divider(),
              
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
    _showSnackBar("Data saved successfully");

    moveToLastScreen();
  }

  void _showSnackBar(String text) {
    categoryScaffoldKey.currentState
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
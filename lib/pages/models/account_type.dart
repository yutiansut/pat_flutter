import 'package:flutter/material.dart';

// Categ Badge Colors
const Map<String, dynamic> categColor = <String, dynamic>{
  "income": Colors.green,
  "expense": Colors.red,
  "borrow": Colors.orange,
  "lend": Colors.teal,
};

// DB Fields
String accountTypeTable = 'account_type_table';
String colId = 'id';
String colName = 'name';
String colCreateDate = 'createDate';

// DB CreateQry
String createQry = 'CREATE TABLE $accountTypeTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colCreateDate TEXT)';
String defaultOrderBy = '$colName ASC';


class ModelAccountType {
    int _id;
    String _name;
    String _createDate = DateTime.now().toString();

    //default constructor
    ModelAccountType(this._name,[this._createDate]);

    //Named constructor
    ModelAccountType.withId(this._id,this._name,[this._createDate]);

    //Getters
    int get id => _id;
    String get name => _name;
    String get createDate => DateTime.now().toString();

    // Setters
    set name(String name){
      if(name.length <= 25){
        this._name = name;
      }
    }
    set createDate(String createDate){
        this._createDate = createDate;
    }

    //Convert the input data to Map objects
    Map<String,dynamic> toMap(){
      var map = Map<String,dynamic>();
      if(_id != null){
        map['id'] = _id;
      }

      map['name'] = _name;
      map['createDate'] = _createDate;

      return map;
    }

    // Extract a Note object from a Map object
    // ModelCategory.fromMapObject(Map<String, dynamic> map) {
    //   this._id = map['id'];
    //   this._name = map['name'];
    //   this._createDate = map['createDate'];
    // }

    factory ModelAccountType.fromMap(Map<String, dynamic> map){
      return ModelAccountType.withId(map['id'], map['name'], map['createDate']);
    }

}

// List<ModelCategory> defaultCateg = <ModelCategory>[
//   ModelCategory("Income",DateTime.now().toString()),
//   ModelCategory("Expense"),
//   ModelCategory("Borrow"),
//   ModelCategory("Lend"),
// ];
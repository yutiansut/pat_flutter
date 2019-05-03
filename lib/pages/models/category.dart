import 'package:flutter/material.dart';
import './../models/account_type.dart' as accountType;
// import 'package:sqflite/sqflite.dart';


// Categ Badge Colors
const Map<String, dynamic> categColor = <String, dynamic>{
  "income": Colors.green,
  "expense": Colors.red,
  "borrow": Colors.orange,
  "lend": Colors.teal,
};

// DB Fields
String categoryTable = 'category_table';
String colId = 'id';
String colName = 'name';
String colCreateDate = 'createDate';
String colTypeId = "typeId";

// DB CreateQry
String createQry = 'CREATE TABLE $categoryTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colCreateDate TEXT, $colTypeId INTEGER, FOREIGN KEY($colTypeId) REFERENCES ' + accountType.accountTypeTable + '('+ accountType.colId +'))';
String defaultOrderBy = '$colName ASC';


class ModelCategory {
    int _id;
    String _name;
    String _createDate;
    int _typeId;

    //default constructor
    ModelCategory(this._name,this._typeId, [this._createDate]);

    //Named constructor
    ModelCategory.withId(this._id,this._name, this._typeId, [this._createDate]);

    //Getters
    int get id => _id;
    String get name => _name;
    String get createDate => _createDate;
    int get typeId => _typeId;

    // Setters
    set name(String name){
      if(name.length <= 25){
        this._name = name;
      }
    }
    set typeId(int typeId){
        this._typeId = typeId;
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
      map['typeId'] = _typeId;
      map['createDate'] = _createDate;

      return map;
    }

    // Extract a Note object from a Map object
    // ModelCategory.fromMapObject(Map<String, dynamic> map) {
    //   this._id = map['id'];
    //   this._name = map['name'];
    //   this._createDate = map['createDate'];
    // }

    factory ModelCategory.fromMap(Map<String, dynamic> map){
      return ModelCategory.withId(map['id'], map['name'], map['typeId'], map['createDate']);
    }

}

// List<ModelCategory> defaultCateg = <ModelCategory>[
//   ModelCategory("Income",DateTime.now().toString()),
//   ModelCategory("Expense"),
//   ModelCategory("Borrow"),
//   ModelCategory("Lend"),
// ];
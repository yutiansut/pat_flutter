import 'package:flutter/material.dart';

// Categ Badge Colors
const Map<String, dynamic> categColor = <String, dynamic>{
  "income": Colors.green,
  "expense": Colors.red,
  "borrow": Colors.orange,
  "lend": Colors.teal,
};

class ModelCategory {
    int _id;
    String _name;
    DateTime _createDate = DateTime.now();

    //default constructor
    ModelCategory(this._name,[this._createDate]);

    //Named constructor
    ModelCategory.withId(this._id,this._name,[this._createDate]);

    //Getters
    int get id => _id;
    String get name => _name;
    DateTime get createDate => DateTime.now();

    // Setters
    set name(String name){
      if(name.length <= 25){
        this._name = name;
      }
    }
    set createDate(DateTime createDate){
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

}

List<ModelCategory> defaultCateg = <ModelCategory>[
  ModelCategory.withId(0, "Income",DateTime.now()),
  ModelCategory.withId(1, "Expense"),
  ModelCategory.withId(2, "Borrow"),
  ModelCategory.withId(3, "Lend"),
];
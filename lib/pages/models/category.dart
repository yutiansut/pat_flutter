import 'package:flutter/material.dart' show Colors;

import 'dart:async' show Future;

import 'package:sqflite/sqflite.dart' show Database;

import './../../dbutils/sqllitedb.dart' show DBInterface;

import './../../config/config.dart' as conf;
// Categ Badge Colors
const Map<String, dynamic> categColor = <String, dynamic>{
  "income": Colors.green,
  "expense": Colors.red,
  "borrow": Colors.orange,
  "lend": Colors.teal,
};

// DB Fields
String categoryTable = 'Category';
String colId = 'id';
String colName = 'name';
String colCreateDate = 'createDate';
String colParentId = "parentId";

String defaultOrderBy = '$colName ASC';  // rec_name

class Category extends DBInterface{

  factory Category(){
    if(_this == null) _this = Category._getInstance();
    return _this;
  }

  /// Make only one instance of this class.
  static Category _this;

  Category._getInstance(): super();

  @override
  get name => conf.dbName + '.db';  // 'testingDb.db'

  @override
  get version => 1;

  @override
  Future onCreate(Database db, int version) async {

    await db.execute("""
      CREATE TABLE $categoryTable(
        $colId INTEGER PRIMARY KEY,
        $colName TEXT,
        $colCreateDate TEXT,
        $colParentId INTEGER,
        FOREIGN KEY($colParentId) REFERENCES $categoryTable($colId))
     """);
  }

  void save(String table){
    saveRec(table);
  }

  Future<List<Map>> getCategories() async {
    return await this.rawQuery('SELECT * FROM $categoryTable');
  }
}
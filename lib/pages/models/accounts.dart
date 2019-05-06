// import 'package:flutter/material.dart' show Colors;

import 'dart:async' show Future;

import 'package:sqflite/sqflite.dart' show Database;

import './../../dbutils/sqllitedb.dart' show DBInterface;

import './../../config/config.dart' as conf;

// DB Fields
String accountsTable = 'Accounts';
String colId = 'id';
String colName = 'name';
String colAcDate = 'acDate';
String colCreateDate = 'createDate';
String colCategoryType = 'categoryType';
String colTransType = "transType";

String defaultOrderBy = '$colAcDate ASC';  // rec_name

class Accounts extends DBInterface{

  factory Accounts(){
    if(_this == null) _this = Accounts._getInstance();
    return _this;
  }

  /// Make only one instance of this class.
  static Accounts _this;

  Accounts._getInstance(): super();

  @override
  get name => conf.dbName + '.db';  // 'testingDb.db'

  @override
  get version => 1;

  @override
  Future onCreate(Database db, int version) async {

    await db.execute("""
      CREATE TABLE $accountsTable(
        $colId INTEGER PRIMARY KEY,
        $colName TEXT,
        $colAcDate DATETIME,
        $colCreateDate TEXT,
        $colCategoryType TEXT,
        $colTransType TEXT
        )
     """);
  }

  void save(String table){
    saveRec(table);
  }

  Future<List<Map>> getAccounts() async {
    return await this.rawQuery('SELECT * FROM $accountsTable order by $defaultOrderBy');
  }
}
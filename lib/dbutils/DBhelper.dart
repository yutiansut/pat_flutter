
import 'dart:async' show Future;

import 'package:sqflite/sqflite.dart' show Database;

import 'sqllitedb.dart' show DBInterface;

import './../config/config.dart' as conf;

import 'initModels.dart' as initModels;


class Models extends DBInterface{

  factory Models(){
    if(_this == null) _this = Models._getInstance();
    return _this;
  }

  /// Make only one instance of this class.
  static Models _this;

  Models._getInstance(): super();

  @override
  get name => conf.dbName + '.db';  // 'testingDb.db'

  @override
  get version => 1;


  @override
  Future onCreate(Database db, int version) async {
    initModels.createTables.forEach((table){
      createTable(db, table);
    });
  }

  Future createTable(Database db, table) async {
    await db.execute(table);
  }

  void save(String table){
    saveRec(table);
  }

  Future<List<Map>> getTableData(String table, {String orderBy: 'name ASC'}) async {
    return await this.rawQuery('SELECT * FROM $table order by $orderBy');
  }
}
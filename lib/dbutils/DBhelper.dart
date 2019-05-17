
import 'dart:async' show Future;
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' show Database;

import 'sqllitedb.dart' show DBInterface;

import './../config/config.dart' as conf;

import 'initModels.dart' as initModels;

import 'files.dart';


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
    try {
      return await this.rawQuery('SELECT * FROM $table order by $orderBy');
    } catch (e) {
      return await this.rawQuery('SELECT * FROM $table');
    }
  }

  Future<String> getDumpJson() async{
    List dumpJson = [];
    List tblNames = await this.tableNames();
    for (var i = 0; i < tblNames.length; i++) {
      var tblName = tblNames[i]['name'];
      if(tblName != 'android_metadata'){
        var tblData = await this.getTableData(tblName);
        dumpJson.add({
          'table': tblName,
          'rows': tblData
        });
      }
    }
    return jsonEncode(dumpJson);
  }

  Future<File> loadLocalJsonDb() async {
    var extPath = (await getApplicationDocumentsDirectory()).path;
    String filePath = extPath + "/test.json";
    File file = new File(filePath);
    if(await file.exists()){
      return file;
    }
    return file;
  }


  Future<File> saveDumpDb() async {
    // Json 
    var dumpJson = await this.getDumpJson();
    // get Local Json DB
    var dbFile = await loadLocalJsonDb();
    await Files.writeFile(dbFile, dumpJson);  
    return dbFile;
  }

  Future<List> readLocalJsonDb() async {
    var dbFile = await loadLocalJsonDb();
    var strData = await Files.readFile(dbFile);
    List json = jsonDecode(strData);
    return json;
  }
}
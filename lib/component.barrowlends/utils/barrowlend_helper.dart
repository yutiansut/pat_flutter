import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/lender_model.dart';
import '../models/barrows_model.dart';


class DatabaseHelper{
  static DatabaseHelper _databaseHelper; //Singleton DatabaseHelper
  static Database _database; //Singleton Database

  //Barrows  properties
  String barrowstable = 'barrows_table';
  String barcolId = 'id';
  String barcolLendername = 'lendername';
  String barcolBarroweramount = 'barrowamount';
  String barcolDate = 'date';
  String barcolDesc = 'description';

  //Lendes Properties
  String lendestable = 'lends_table';
  String lendcolId = 'id';
  String lendcolBarrowername = 'barrowername';
  String lendcolAmount = 'lendamount';
  String lendcolDate = 'date';
  String lendcolDesc = 'description';

  //Named Constructor
  DatabaseHelper._createInstance(); //Create a instance of DatabaseHelper

  factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance(); //this is executed Only once
    }
    return _databaseHelper;
  }

  //Getter for database instance
  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  //get the database path
  Future<Database> initializeDatabase() async{
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'salary.db';

    //open or create the database with given path
    var salarydb = await openDatabase(path,version:1,onCreate:_createdb);
    return salarydb;
  }


  //Create database
  void _createdb(Database db,int newVersion) async{

    //create barrows table
    await db.execute('CREATE TABLE $barrowstable($barcolId INTEGER PRIMARY KEY AUTOINCREMENT, $barcolLendername TEXT, $barcolBarroweramount DOUBLE, $barcolDate DATETIME, $barcolDesc TEXT)');

    //create lens table
    await db.execute('CREATE TABLE $lendestable($lendcolId INTEGER PRIMARY KEY AUTOINCREMENT, $lendcolBarrowername TEXT, $lendcolAmount DOUBLE, $lendcolDate DATETIME, $lendcolDesc TEXT)');
  }


  //CURD OPERATION for Barrows table

  //get All the data from barrows table
  Future<List<Map<String, dynamic>>> getBarrowsMapList() async{
    Database db = await this.database;
    var result = db.rawQuery('SELECT * FROM $barrowstable');
    return result;
  }

  //insert the data into barrows table
  Future<dynamic> insertBarrows(Barrow barrows) async{
    Database db = await this.database;
    var result = await db.insert(barrowstable, barrows.toMap());
    return result;
  }

  //update the data into barrows table
  Future<dynamic> updateBarrows(Barrow barrows) async{
    Database db = await this.database;
    var result = await db.update(barrowstable, barrows.toMap(), where: '$barcolLendername = ?', whereArgs: [barrows.id] );
    return result;
  }

  //Delete the barrows table data
  Future<dynamic> deleteBarrows(int id) async{
      Database db = await this.database;
      var result = await db.rawDelete('DELETE FROM $barrowstable where $barcolId = $id');
      return result;
  }

  //Get BarrowsList
  Future<List<Map<String, dynamic>>> getBarrowsList() async {
		var barrowsMapList = await getBarrowsMapList(); // Get 'Map List' from database
		return barrowsMapList;
	}


  //CRUD OPERATION for lends table

  //get all the data from lends table
  Future<List<Map<String, dynamic>>> getLendsMapList() async{
    Database db = await this.database;
    var result = db.rawQuery('SELECT * FROM $lendestable');
    return result;
  }

  //insert the data into barrows table
  Future<dynamic> insertLends(Lender lends) async{
    Database db = await this.database;
    var result = await db.insert(lendestable, lends.toMap());
    return result;
  }

  //update the data into barrows table
  Future<dynamic> updateLends(Lender lends) async{
    Database db = await this.database;
    var result = await db.update(lendestable, lends.toMap(), where: '$lendcolBarrowername = ?', whereArgs: [lends.id] );
    return result;
  }

  //Delete the lends table data
  Future<dynamic> deleteLends(int id) async{
      Database db = await this.database;
      var result = await db.rawDelete('DELETE FROM $lendestable where $lendcolId = $id');
      return result;
  }

  //Get LendsList 
  Future<List<Map<String, dynamic>>> getLendsList() async {
		var lendsMapList = await getLendsMapList(); // Get 'Map List' from database
		return lendsMapList;
	}
}
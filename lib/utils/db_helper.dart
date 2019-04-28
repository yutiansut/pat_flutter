import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/salary_model.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper; //Singleton DatabaseHelper
  static Database _database; //Singleton Database 

  //Table Properties
  String salarytable = 'salary_table';
  String colId = 'id';
  String colContact = 'contact';
  String colAmount = 'amount';
  String colDate = 'date';
  String colDescription = 'description';

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
    await db.execute('CREATE TABLE $salarytable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colContact DOUBLE, $colAmount TEXT, $colDate DATETIME, $colDescription TEXT)');

  }


  //CRUD OPERATIONS
 
  //GET All the data from the table 
  Future<List<Map<String, dynamic>>> getSalaryMapList() async{
    Database db = await this.database;

    var result = db.rawQuery('SELECT * FROM $salarytable');
    return result;
  }

  //Insert operation 
  Future<dynamic> insertSalary(Salary salary) async{
    Database db = await this.database;
    var result = await db.insert(salarytable, salary.toMap());
    return result;
  }

}

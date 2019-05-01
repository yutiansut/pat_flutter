import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/reward_model.dart';
import '../models/salary_model.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper; //Singleton DatabaseHelper
  static Database _database; //Singleton Database 

  //SalaryTable Properties
  String salarytable = 'salary_table';
  String colId = 'id';
  String colContact = 'contact';
  String colAmount = 'amount';
  String colDate = 'date';
  String colDescription = 'description';

  //RewardTable Properties
  String rewardtable = 'reward_table';
  String rewcolId = 'id';
  String rewcolContact = 'contact';
  String rewcolAmount = 'amount';
  String rewcolDate = 'date';
  String rewcolDesc = 'description';

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

  void _createdb(Database db,int newVersion) async{
    //create salarytable
    await db.execute('CREATE TABLE $salarytable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colContact DOUBLE, $colAmount TEXT, $colDate DATETIME, $colDescription TEXT)');
    //create reward table
    await db.execute('CREATE TABLE $rewardtable($rewcolId INTEGER PRIMARY KEY AUTOINCREMENT, $rewcolContact TEXT, $rewcolAmount DOUBLE, $rewcolDate DATETIME, $rewcolDesc TEXT)');

  }

  //CRUD OPERATIONS
 
  //GET All the data from the salary table 
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

  //Update salary table
  Future<dynamic> updateSalary(Salary salary) async{
    Database db = await this.database;
    var result = await db.update(salarytable, salary.toMap(), where: '$colContact = ?', whereArgs: [salary.id] );
    return result;
  }

  //DELETE salary table data
  Future<dynamic> deleteSalary(int id) async{
      Database db = await this.database;
      var result = await db.rawDelete('DELETE FROM $salarytable where $colId = $id');
      return result;
  }

  //Get SalaryList
  Future<List<Map<String, dynamic>>> getSalaryList() async {

		var salaryMapList = await getSalaryMapList(); // Get 'Map List' from database
		return salaryMapList;
	}

  //REWARD CURD OPERATIONS

  //Get all reward datas from reward table
  Future<List<Map<String, dynamic>>> getRewardMapList() async{
    Database db = await this.database;
    var result = db.rawQuery('SELECT * FROM $rewardtable');
    return result;
  }


  //Insert reward operation 
  Future<dynamic> insertReward(Reward reward) async{
    Database db = await this.database;
    var result = await db.insert(rewardtable, reward.toMap());
    return result;
  }


  //Update reward table
  Future<dynamic> updateReward(Reward reward) async{
    Database db = await this.database;
    var result = await db.update(rewardtable, reward.toMap(), where: '$rewcolContact = ?', whereArgs: [reward.id] );
    return result;
  }

  //DELETE reward table data
  Future<dynamic> deleteReward(int id) async{
      Database db = await this.database;
      var result = await db.rawDelete('DELETE FROM $rewardtable where $rewcolId = $id');
      return result;
  }

  //Get RewardList 
  Future<List<Map<String, dynamic>>> getRewardList() async {
		var rewardMapList = await getRewardMapList(); // Get 'Map List' from database
		return rewardMapList;
	}
}

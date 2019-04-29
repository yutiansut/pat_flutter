import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/salary_model.dart';
import '../models/reward_model.dart';
import '../models/expense_online_model.dart';
import '../models/expense_purchase_model.dart';
import '../models/lender_model.dart';
import '../models/barrower_model.dart';

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

  //ExpenseOnline Properties
  String expenseonlineTb = 'expense_online_table';
  String exponcolId = 'id';
  String exponcolStore = 'storename';
  String exponcolProduct = 'product';
  String exponcolAmount = 'amount';
  String exponcolDate = 'date';
  String exponcolDesc = 'description';


  //ExpensePurchase Properties
  String expensepurchaseTb = 'expense_purchase_table';
  String exppurcolId = 'id';
  String exppurcolStore = 'storename';
  String exppurcolProduct = 'product';
  String exppurcolAmount = 'amount';
  String exppurcolDate = 'date';
  String exppurcolDesc = 'description';

  //Barrows  properties
  String barrowstable = 'barrows_table';
  String barcolId = 'id';
  String barcolBarrowername = 'barrowername';
  String barcolLenderamount = 'lendamount';
  String barcolDate = 'date';
  String barcolDesc = 'description';

  //Lendes Properties
  String lendestable = 'lends_table';
  String lendcolId = 'id';
  String lendcolLendername = 'lendername';
  String lendcolAmount = 'amount';
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
    await db.execute('CREATE TABLE $salarytable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colContact DOUBLE, $colAmount TEXT, $colDate DATETIME, $colDescription TEXT)');

    //create reward table
    await db.execute('CREATE TABLE $rewardtable($rewcolId INTEGER PRIMARY KEY AUTOINCREMENT, $rewcolContact TEXT, $rewcolAmount DOUBLE, $rewcolDate DATETIME, $rewcolDesc TEXT)');

    //create expenseonline table
    await db.execute('CREATE TABLE $expenseonlineTb($exponcolId INTEGER PRIMARY KEY AUTOINCREMENT, $exponcolStore TEXT, $exponcolProduct TEXT, $exponcolAmount DOUBLE, $exponcolDate DATETIME, $exponcolDesc TEXT)');

    //create expensepurchase table
    await db.execute('CREATE TABLE $expensepurchaseTb($exppurcolId INTEGER PRIMARY KEY AUTOINCREMENT, $exppurcolStore TEXT, $exppurcolProduct TEXT, $exppurcolAmount DOUBLE, $exppurcolDate DATETIME, $exppurcolDesc TEXT)');

    //create barrows table
    await db.execute('CREATE TABLE $barrowstable($barcolId INTEGER PRIMARY KEY AUTOINCREMENT, $barcolBarrowername TEXT, $barcolLenderamount DOUBLE, $barcolDate DATETIME, $barcolDesc TEXT)');

    //create lens table
    await db.execute('CREATE TABLE $lendestable($lendcolId INTEGER PRIMARY KEY AUTOINCREMENT, $lendcolLendername TEXT, $lendcolAmount DOUBLE, $lendcolDate DATETIME, $lendcolDesc TEXT)');

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

  Future<List<Map<String, dynamic>>> getSalaryList() async {

		var noteMapList = await getSalaryMapList(); // Get 'Map List' from database
		int count = noteMapList.length;         // Count the number of map entries in db table

    // print(noteMapList);
		// List<Salary> noteList = List<Salary>();
		// // For loop to create a 'Note List' from a 'Map List'

		// for (int i = 0; i < count; i++) {
		// 	noteList.add(Salary.fromMapObject(noteMapList[i]));
		// }
    
		return noteMapList;
	}



}

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/expense_online_model.dart';
import '../models/expense_purchase_model.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper; //Singleton DatabaseHelper
  static Database _database; //Singleton Database

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

    //create expenseonline table
    await db.execute('CREATE TABLE $expenseonlineTb($exponcolId INTEGER PRIMARY KEY AUTOINCREMENT, $exponcolStore TEXT, $exponcolProduct TEXT, $exponcolAmount DOUBLE, $exponcolDate DATETIME, $exponcolDesc TEXT)');

    //create expensepurchase table
    await db.execute('CREATE TABLE $expensepurchaseTb($exppurcolId INTEGER PRIMARY KEY AUTOINCREMENT, $exppurcolStore TEXT, $exppurcolProduct TEXT, $exppurcolAmount DOUBLE, $exppurcolDate DATETIME, $exppurcolDesc TEXT)');
  }

  //CURD OPERATION FOR EXPENSE ONLINE

  //Get all expenseonline datas from expense_online table
  Future<List<Map<String, dynamic>>> getExpenseOnlineMapList() async{
    Database db = await this.database;
    var result = db.rawQuery('SELECT * FROM $expenseonlineTb');
    return result;
  }

  //Insert expenseonline data operation 
  Future<dynamic> insertExpOnline(ExpenseOnline exponline) async{
    Database db = await this.database;
    var result = await db.insert(expenseonlineTb, exponline.toMap());
    return result;
  }

  //Update expenseonline table
  Future<dynamic> updateExpOnline(ExpenseOnline exponline) async{
    Database db = await this.database;
    var result = await db.update(expenseonlineTb, exponline.toMap(), where: '$exponcolStore = ?', whereArgs: [exponline.id] );
    return result;
  }

  //DELETE expenseonline table data
  Future<dynamic> deleteExpOnline(int id) async{
      Database db = await this.database;
      var result = await db.rawDelete('DELETE FROM $expenseonlineTb where $exponcolId = $id');
      return result;
  }

  //Get expenseonlineList
  Future<List<Map<String, dynamic>>> getExpOnlineList() async {
		var exponlineMapList = await getExpenseOnlineMapList(); // Get 'Map List' from database
		return exponlineMapList;
	}

  //CURD OPERATION for ExpensePurchase

  //get All the data from expense_purchase table
  Future<List<Map<String, dynamic>>> getExpensePurchaseMapList() async{
    Database db = await this.database;
    var result = db.rawQuery('SELECT * FROM $expensepurchaseTb');
    return result;
  }

  //Insert expense purchase table data Operation
  Future<dynamic> insertExpPurchase(ExpensePurchase exppurchase) async{
    Database db = await this.database;
    var result = await db.insert(expensepurchaseTb, exppurchase.toMap());
    return result;
  }

  //Update expense purchase table
  Future<dynamic> updateExpPurchase(ExpensePurchase exppurchase) async{
    Database db = await this.database;
    var result = await db.update(expensepurchaseTb, exppurchase.toMap(), where: '$exppurcolStore = ?', whereArgs: [exppurchase.id] );
    return result;
  }

  //Delete Expense purchase table
  Future<dynamic> deleteExpPurchase(int id) async{
      Database db = await this.database;
      var result = await db.rawDelete('DELETE FROM $expensepurchaseTb where $exppurcolId = $id');
      return result;
  }

  //Get ExpensePurchaseList 
  Future<List<Map<String, dynamic>>> getExpPurchaseList() async {
		var exppurchaseMapList = await getExpensePurchaseMapList(); // Get 'Map List' from database
		return exppurchaseMapList;
	}
}
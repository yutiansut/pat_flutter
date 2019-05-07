import '../component.income/models/salary_model.dart';
import '../component.income/models/reward_model.dart';
import '../component.expense/models/expense_online_model.dart';
import '../component.expense/models/expense_purchase_model.dart';
import '../component.barrowlends/models/barrows_model.dart';
import '../component.barrowlends/models/lender_model.dart';
import '../main.utils/models_models/model.login.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

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

  //Settings Properties
  String settingstable = 'settings_table';
  String settingspassword = 'password';
  String settingsId = 'id';
  String settingsexpenselimit = 'expenselimit';
  String settingsbarrowlimit = 'barrowlimit';
  String settingslendlimit = 'lendlimit';


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
    String path = dir.path + 'rat.db';

    //open or create the database with given path
    var salarydb = await openDatabase(path,version:1,onCreate:_createdb);
    return salarydb;
  }

  void _createdb(Database db,int newVersion) async{
    //create salarytable
    await db.execute('CREATE TABLE $salarytable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colContact DOUBLE, $colAmount TEXT, $colDate DATETIME, $colDescription TEXT)');
    //create reward table
    await db.execute('CREATE TABLE $rewardtable($rewcolId INTEGER PRIMARY KEY AUTOINCREMENT, $rewcolContact TEXT, $rewcolAmount DOUBLE, $rewcolDate DATETIME, $rewcolDesc TEXT)');

    //create expenseonline table
    await db.execute('CREATE TABLE $expenseonlineTb($exponcolId INTEGER PRIMARY KEY AUTOINCREMENT, $exponcolStore TEXT, $exponcolProduct TEXT, $exponcolAmount DOUBLE, $exponcolDate DATETIME, $exponcolDesc TEXT)');

    //create expensepurchase table
    await db.execute('CREATE TABLE $expensepurchaseTb($exppurcolId INTEGER PRIMARY KEY AUTOINCREMENT, $exppurcolStore TEXT, $exppurcolProduct TEXT, $exppurcolAmount DOUBLE, $exppurcolDate DATETIME, $exppurcolDesc TEXT)');

     //create barrows table
    await db.execute('CREATE TABLE $barrowstable($barcolId INTEGER PRIMARY KEY AUTOINCREMENT, $barcolLendername TEXT, $barcolBarroweramount DOUBLE, $barcolDate DATETIME, $barcolDesc TEXT)');

    //create lens table
    await db.execute('CREATE TABLE $lendestable($lendcolId INTEGER PRIMARY KEY AUTOINCREMENT, $lendcolBarrowername TEXT, $lendcolAmount DOUBLE, $lendcolDate DATETIME, $lendcolDesc TEXT)');
  
    //Create settings table
    await db.execute('CREATE TABLE $settingstable($settingsId INTEGER PRIMARY KEY AUTOINCREMENT, $settingspassword TEXT, $settingsexpenselimit DOUBLE, $settingsbarrowlimit DOUBLE, $settingslendlimit DOUBLE)');
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

  //CURD OPERATION FOR SETTINGS

  Future<List<Map<String, dynamic>>> getSettingsMapList() async{
    Database db = await this.database;
    var result = db.rawQuery('SELECT * FROM $settingstable');
    return result;
  }

  //insert the data into barrows table
  Future<dynamic> insetSettings(Settings settings) async{
    Database db = await this.database;
    var result = await db.insert(settingstable, settings.toMap());
    return result;
  }

   //update the data into barrows table
  Future<dynamic> updateSettingsPassword(Settings settings) async{
    Database db = await this.database;
    var result = await db.update(settingstable, settings.toMap(), where: '$settingspassword = ?', whereArgs: [settings.id] );
    return result;
  }

  //Get LendsList 
  Future<List<Map<String, dynamic>>> getSettingsList() async {
		var lendsMapList = await getSettingsMapList(); // Get 'Map List' from database
		return lendsMapList;
	}

}
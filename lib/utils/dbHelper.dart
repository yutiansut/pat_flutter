import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../pages/models/category.dart' as categ;

class DatabaseHelper {

	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database



	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}

	Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'pat.db';

		// Open/create the database at a given path
		var patDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return patDatabase;
	}

	void _createDb(Database db, int newVersion) async {

		await db.execute(categ.createQry);
	}

	// Fetch Operation: Get all note objects from database
	Future<List<Map<String, dynamic>>> getMapList(String table, String order) async {
		Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
		var result = await db.query(table, orderBy: order);
		return result;
	}

	// Insert Operation: Insert a Note object to database
	Future<int> insert(String table, dynamic obj) async {
		Database db = await this.database;
		var result = await db.insert(table, obj.toMap());
		return result;
	}

	// Update Operation: Update a Note object and save it to database
	Future<int> update(String table, dynamic obj, String fieldId) async {
		var db = await this.database;
		var result = await db.update(table, obj.toMap(), where: '$fieldId = ?', whereArgs: [obj.id]);
		return result;
	}

	// Delete Operation: Delete a Note object from database
	Future<int> delete(String table, String fieldId, int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $table WHERE $fieldId = $id');
		return result;
	}

	// Get number of Note objects in database
	Future<int> getCount(String table) async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (id) from $table');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

	// Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
	Future<List<Map<String, dynamic>>> getList(String table, String order) async {

		var mapList = await getMapList(table, order); // Get 'Map List' from database
		// int count = mapList.length; // Count the number of map entries in db table

		// List<categ.ModelCategory> objList = List<categ.ModelCategory>();
		// // For loop to create a 'Note List' from a 'Map List'
		// for (int i = 0; i < count; i++) {
		// 	objList.add(categ.ModelCategory.fromMapObject(mapList[i]));
		// }

		return mapList;
	}

}

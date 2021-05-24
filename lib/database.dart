import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'itemInCart.dart';

//Description : Setting up local database
//Coded by Vignesh
class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String selectedProdcut = "CartItem";
  final String image = 'image';
  final String price = "price";
  final String ratings = "rating";
  final String productName = 'name';
  final String productId = 'id';

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();
//Description : Setting a path for local database
//Coded by Vignesh
  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "Sally.db");

    var ourdb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourdb;
  }

//Description : Create table
//Coded by Vignesh
  void _onCreate(Database db, int version) async {
    await db
        .execute("CREATE TABLE $selectedProdcut($productId INTEGER PRIMARY KEY,"
            "$image TEXT,"
            "$price INTEGER,"
            "$ratings DOUBLE,"
            "$productName TEXT)");
  }

//Description : Insert table
//Coded by Vignesh
  Future<int> saveItem(CartItem cart) async {
    var database = await db;
    int res = await database.insert("$selectedProdcut", cart.toMap());
    return res;
  }

//Description : Get table
//Coded by Vignesh
  Future<List> getAll() async {
    var database = await db;
    var result = await database.rawQuery("SELECT * FROM $selectedProdcut");

    return result.toList();
  }

//Description : Get Single table
//Coded by Vignesh
  Future<CartItem> getOneItem(int id) async {
    var database = await db;
    var result = await database
        .rawQuery("SELECT * FROM $selectedProdcut WHERE $productId = $id");
    if (result.length == 0) return null;
    return new CartItem.fromMap(result.first);
  }

//Description : Delete data
//Coded by Vignesh
  Future<int> deleteItem(int id) async {
    var database = await db;
    return await database
        .delete(selectedProdcut, where: "$productId = ?", whereArgs: [id]);
  }

//Description : Update table
//Coded by Vignesh
  Future<int> updateItem(CartItem cart) async {
    var database = await db;
    return await database.update(selectedProdcut, cart.toMap(),
        where: "$productId = ?", whereArgs: [cart.id]);
  }

//Description : Close database connection
//Coded by Vignesh
  Future close() async {
    var database = await db;
    return database.close();
  }
}

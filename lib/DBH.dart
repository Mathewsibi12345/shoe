import 'dart:developer';
import 'package:flutter_application_shoeadd/DB.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static const String tableName = 'shoes';

  DatabaseHelper._privateConstructor();

  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._privateConstructor();
    }
    return _instance!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Database? _database;

  Future<Database> initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'shoes_database.db');
      return await openDatabase(path, version: 1,
          onCreate: (db, version) async {
        await db.execute('''
   CREATE TABLE $tableName (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     shoe_id TEXT,
     name TEXT,
     description TEXT,
     price REAL,
     discount REAL,
     imageUrl TEXT,
     final_price REAL
   )
''');
      }, onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      });
    } catch (e) {
      print('Error initializing database: $e');
      rethrow;
    }
  }

  Future<void> insertShoe(Shoe shoe) async {
    try {
      final Database db = await database;
      log('shoe imageurl is ${shoe.imageUrl}');
      await db.insert(
        tableName,
        shoe.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting shoe: $e');
      throw DatabaseException('Failed to insert shoe into the database.');
    }
  }

  Future<List<Shoe>> getShoes() async {
    try {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query(tableName);
      return List.generate(maps.length, (i) {
        return Shoe.fromMap(maps[i]);
      });
    } catch (e) {
      print('Error getting shoes: $e');
      throw DatabaseException('Failed to retrieve shoes from the database.');
    }
  }

  Future<void> close() async {
    try {
      final Database db = await database;
      db.close();
    } catch (e) {
      print('Error closing database: $e');
      throw DatabaseException('Failed to close the database.');
    }
  }
}

class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);

  @override
  String toString() => 'DatabaseException: $message';
}
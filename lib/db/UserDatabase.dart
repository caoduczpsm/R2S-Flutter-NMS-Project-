import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import 'package:note_management_system/model/User.dart';

class SQLHelper {
  static Future<void> createUserTable(Database database) async {
    await database.execute('''CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        password TEXT,
        name TEXT
    )''');
  }

  static Future<Database> db() async {
    return openDatabase(
        'user.db',
        version: 1,
        onCreate: (Database database, int version) async {
          await createUserTable(database);
        }
    );
  }

  static Future<void> createUser(User user) async {
    final db = await SQLHelper.db();

    final id = await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

  }

  static Future<User?> getUserByEmailPassword(String email, String password) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> maps = await db.query('users',
        where: 'email = ? AND password = ?', whereArgs: [email,password]);


    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<User?> getUserById(int id) async {
    final db = await SQLHelper.db();

    final maps = await db.query('users', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }



  static Future<bool> checkEmailAlreadyUsed(String email) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> maps = await db
        .query('users', where: 'email = ?', whereArgs: [email]);

    if (maps.isEmpty) {
      return true;
    } else {
      return false;
    }
  }



}
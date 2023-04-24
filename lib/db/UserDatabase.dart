import 'package:note_management_system/ultilities/Constant.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';

import 'package:note_management_system/model/User.dart';

class SQLHelper {
  static Future<void> createUserTable(Database database) async {
    await database.execute('''CREATE TABLE ${Constant.KEY_TABLE_USER}(
        ${Constant.KEY_USER_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Constant.KEY_USER_EMAIL} TEXT,
        ${Constant.KEY_USER_NAME} TEXT,
        ${Constant.KEY_USER_PASSWORD} TEXT
    )''');
  }

  static Future<Database> db() async {
    return openDatabase(
        Constant.KEY_DB_NAME,
        version: 1,
        onCreate: (Database database, int version) async {
          await createUserTable(database);
        }
    );
  }

  static Future<void> createUser(User user) async {
    final db = await SQLHelper.db();

    await db.insert(Constant.KEY_TABLE_USER, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

  }

  static Future<User?> getUserByEmailPassword(String email, String password) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> maps = await db.query(Constant.KEY_TABLE_USER,
        where: '${Constant.KEY_USER_EMAIL} = ? AND ${Constant.KEY_USER_PASSWORD} = ?', whereArgs: [email,password]);


    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<User?> getUserById(int id) async {
    final db = await SQLHelper.db();

    final maps = await db.query(Constant.KEY_TABLE_USER, where: '${Constant.KEY_USER_ID} = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }



  static Future<bool> checkEmailAlreadyUsed(String email) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> maps = await db
        .query(Constant.KEY_TABLE_USER, where: '${Constant.KEY_USER_EMAIL} = ?', whereArgs: [email]);

    if (maps.isEmpty) {
      return true;
    } else {
      return false;
    }
  }



}
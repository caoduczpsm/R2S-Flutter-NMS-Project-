import 'package:flutter/cupertino.dart';
import 'package:note_management_system/db/AppSQLHelper.dart';
import 'package:note_management_system/model/Categories.dart';
import 'package:note_management_system/model/Status.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
import '../ultilities/Constant.dart';

class StatusHelper {

  static Future<int?> createItem(Status status) async {
    final db = await AppSQLHelper.db();

    if(await checkCategoryAvailableByNameAndUserID(status.name!, status.userId!)){
      return  await db.insert(Constant.KEY_TABLE_STATUS, status.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getAllItem(int userId) async {
    final db = await AppSQLHelper.db();
    return await db.query(Constant.KEY_TABLE_STATUS,
        orderBy: Constant.KEY_STATUS_ID,
        where: "${Constant.KEY_STATUS_USER_ID} = ?", whereArgs: [userId]);
  }

  static Future<int> updateItem(Status status) async {
    final db = await AppSQLHelper.db();
    final result = await db.update(Constant.KEY_TABLE_STATUS, status.toMap(),
        where: '${Constant.KEY_STATUS_ID} = ?', whereArgs: [status.id]);
    return result;
  }

  static Future<int?> deleteItem(int id) async {
    final db = await AppSQLHelper.db();

    try {
      return await db.delete(Constant.KEY_TABLE_STATUS,
          where: '${Constant.KEY_STATUS_ID} = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
    return null;
  }

  static Future<bool> checkCategoryAvailableByNameAndUserID(String name, int userId) async {
    final db = await AppSQLHelper.db();
    final List<Map<String, dynamic>> maps = await db
        .query(Constant.KEY_TABLE_STATUS,
        where: '${Constant.KEY_STATUS_NAME} = ? AND ${Constant.KEY_STATUS_USER_ID} = ?',
        whereArgs: [name, userId]);

    return maps.isEmpty;
  }

}
import 'package:flutter/cupertino.dart';
import 'package:note_management_system/db/AppSQLHelper.dart';
import 'package:note_management_system/model/Items.dart';
import 'package:sqflite/sqflite.dart';
import '../ultilities/Constant.dart';

class CategoryHelper {

  static Future<int> createItem(Items items) async {
    final db = await AppSQLHelper.db();
    final id = await db.insert(Constant.KEY_TABLE_CATEGORY, items.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllItem() async {
    final db = await AppSQLHelper.db();
    return await db.query(Constant.KEY_TABLE_CATEGORY, orderBy: Constant.KEY_CATEGORY_ID);
  }

  static Future<List<Items>> getItemsByUserId(int userId) async {
    final db = await AppSQLHelper.db();
    final List<Map<String, dynamic>> maps = await db.query(Constant.KEY_TABLE_CATEGORY, where: '${Constant.KEY_CATEGORY_USER_ID} = ?', whereArgs: [Constant.KEY_USER_ID],);
    return List.generate(maps.length, (i) {
      return Items(
        id: maps[i][Constant.KEY_CATEGORY_ID],
        title: maps[i][Constant.KEY_CATEGORY_NAME],
        createdAt: maps[i][Constant.KEY_CATEGORY_CREATED_DATE],
      );
    });
  }

  static Future<int> updateItem(Items items) async {
    final db = await AppSQLHelper.db();
    final result = await db.update(Constant.KEY_TABLE_CATEGORY, items.toMap(), where: '${Constant.KEY_CATEGORY_ID} = ?', whereArgs: [items.id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await AppSQLHelper.db();

    try {
      await db.delete(Constant.KEY_TABLE_CATEGORY, where: '${Constant.KEY_CATEGORY_ID} = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
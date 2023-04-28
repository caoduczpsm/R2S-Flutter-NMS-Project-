import 'package:flutter/cupertino.dart';
import 'package:note_management_system/db/AppSQLHelper.dart';
import 'package:note_management_system/model/Categories.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
import '../ultilities/Constant.dart';

class CategoryHelper {

  static Future<int?> createItem(Categories categories) async {
    final db = await AppSQLHelper.db();

    if(await checkCategoryAvailableByNameAndUserID(categories.name!, categories.userId!)){
      return  await db.insert(Constant.KEY_TABLE_CATEGORY, categories.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getAllItem(int userId) async {
    final db = await AppSQLHelper.db();
    return await db.query(Constant.KEY_TABLE_CATEGORY,
        orderBy: Constant.KEY_CATEGORY_ID,
        where: "${Constant.KEY_CATEGORY_USER_ID} = ?", whereArgs: [userId]);
  }

  // static Future<List<Categories>> getItemsByUserId(int userId) async {
  //   final db = await AppSQLHelper.db();
  //   final List<Map<String, dynamic>> maps = await db.query(Constant.KEY_TABLE_CATEGORY,
  //     where: '${Constant.KEY_CATEGORY_USER_ID} = ?', whereArgs: [Constant.KEY_USER_ID],);
  //   return List.generate(maps.length, (i) {
  //     return Categories(
  //       id: maps[i][Constant.KEY_CATEGORY_ID],
  //       title: maps[i][Constant.KEY_CATEGORY_NAME],
  //       createdAt: maps[i][Constant.KEY_CATEGORY_CREATED_DATE],
  //     );
  //   });
  // }

  static Future<int> updateItem(Categories categories) async {
    final db = await AppSQLHelper.db();
    final result = await db.update(Constant.KEY_TABLE_CATEGORY, categories.toMap(),
        where: '${Constant.KEY_CATEGORY_ID} = ?', whereArgs: [categories.id]);
    return result;
  }

  static Future<int?> deleteItem(int id) async {
    final db = await AppSQLHelper.db();

    try {
      return await db.delete(Constant.KEY_TABLE_CATEGORY,
          where: '${Constant.KEY_CATEGORY_ID} = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
    return null;
  }

  static Future<bool> checkCategoryAvailableByNameAndUserID(String name, int userId) async {
    final db = await AppSQLHelper.db();
    final List<Map<String, dynamic>> maps = await db
        .query(Constant.KEY_TABLE_CATEGORY,
        where: '${Constant.KEY_CATEGORY_NAME} = ? AND ${Constant.KEY_CATEGORY_USER_ID} = ?',
        whereArgs: [name, userId]);

    return maps.isEmpty;
  }

}
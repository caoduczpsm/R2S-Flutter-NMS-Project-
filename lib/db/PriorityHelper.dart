import 'package:note_management_system/db/AppSQLHelper.dart';
import 'package:note_management_system/model/Priorities.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
import '../ultilities/Constant.dart';

class PriorityHelper {

  static Future<int?> createItem(Priorities priorities) async {
    final db = await AppSQLHelper.db();

    if(await checkPriorityAvailableByNameAndUserID(priorities.name!, priorities.userId!)){
      return  await db.insert(Constant.KEY_TABLE_PRIORITY, priorities.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      return null;
    }
  }

  static Future<int?> updateItem(Priorities priorities) async {
    final db = await AppSQLHelper.db();
    if(await checkPriorityAvailableByNameAndUserID(priorities.name!, priorities.userId!)){
      return  await db.update(Constant.KEY_TABLE_PRIORITY, priorities.toMap(),
          where: 'id = ?', whereArgs: [priorities.id]);
    } else {
      return null;
    }
  }

  static Future<bool> checkPriorityAvailableByNameAndUserID(String name, int userId) async {
    final db = await AppSQLHelper.db();
    final List<Map<String, dynamic>> maps = await db
        .query(Constant.KEY_TABLE_PRIORITY,
        where: '${Constant.KEY_PRIORITY_NAME} = ? AND ${Constant.KEY_PRIORITY_USER_ID} = ?',
        whereArgs: [name, userId]);

    return maps.isEmpty;
  }

  static Future<List<Map<String, dynamic>>> getAllItem(int userId) async {
    final db = await AppSQLHelper.db();
    return await db.query(Constant.KEY_TABLE_PRIORITY,
        orderBy: Constant.KEY_PRIORITY_ID,
        where: "${Constant.KEY_PRIORITY_USER_ID} = ?", whereArgs: [userId]);
  }

  static Future<Priorities?> getItemsById(int id) async {
    final db = await AppSQLHelper.db();

    final maps = await db.query(Constant.KEY_TABLE_PRIORITY,
        where: '${Constant.KEY_PRIORITY_ID} = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Priorities.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<bool> checkPriorityInUse(int id) async {
    final db = await AppSQLHelper.db();
    final note = await db.query(
      Constant.KEY_TABLE_NOTE,
      where: '${Constant.KEY_NOTE_PRIORITY_ID} = ?',
      whereArgs: [id],
    );
    return note.isNotEmpty;
  }

  static Future<int?> deleteItem(int id) async {
    final db = await AppSQLHelper.db();

    if(await checkPriorityInUse(id)){
      return null;
    } else {
      return await db.delete(Constant.KEY_TABLE_PRIORITY,
          where: '${Constant.KEY_PRIORITY_ID} = ?', whereArgs: [id]);
    }
  }
}
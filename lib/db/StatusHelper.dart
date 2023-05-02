import 'package:note_management_system/db/AppSQLHelper.dart';
import 'package:note_management_system/model/Status.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
import '../ultilities/Constant.dart';

class StatusHelper {

  static Future<int?> createItem(Status status) async {
    final db = await AppSQLHelper.db();

    if(await checkStatusAvailableByNameAndUserID(status.name!, status.userId!)){
      return  await db.insert(Constant.KEY_TABLE_STATUS, status.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      return null;
    }
  }

  static Future<int?> updateItem(Status status) async {
    final db = await AppSQLHelper.db();
    if(await checkStatusAvailableByNameAndUserID(status.name!, status.userId!)){
      return  await db.update(Constant.KEY_TABLE_STATUS, status.toMap(),
          where: 'id = ?', whereArgs: [status.id]);
    } else {
      return null;
    }
  }

  static Future<bool> checkStatusAvailableByNameAndUserID(String name, int userId) async {
    final db = await AppSQLHelper.db();
    final List<Map<String, dynamic>> maps = await db
        .query(Constant.KEY_TABLE_STATUS,
        where: '${Constant.KEY_STATUS_NAME} = ? AND ${Constant.KEY_STATUS_USER_ID} = ?',
        whereArgs: [name, userId]);

    return maps.isEmpty;
  }

  static Future<List<Map<String, dynamic>>> getAllItem(int userId) async {
    final db = await AppSQLHelper.db();
    return await db.query(Constant.KEY_TABLE_STATUS,
        orderBy: Constant.KEY_STATUS_ID,
        where: "${Constant.KEY_STATUS_USER_ID} = ?", whereArgs: [userId]);
  }

  static Future<Status?> getItemsById(int id) async {
    final db = await AppSQLHelper.db();

    final maps = await db.query(Constant.KEY_TABLE_STATUS,
        where: '${Constant.KEY_STATUS_ID} = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Status.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<bool> checkStatusInUse(int id) async {
    final db = await AppSQLHelper.db();
    final note = await db.query(
      Constant.KEY_TABLE_NOTE,
      where: '${Constant.KEY_NOTE_STATUS_ID} = ?',
      whereArgs: [id],
    );
    return note.isNotEmpty;
  }

  static Future<int?> deleteItem(int id) async {
    final db = await AppSQLHelper.db();

    if(await checkStatusInUse(id)){
      return null;
    } else {
      return await db.delete(Constant.KEY_TABLE_STATUS,
          where: '${Constant.KEY_STATUS_ID} = ?', whereArgs: [id]);
    }
  }
}
// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import '../model/Note.dart';
import '../ultilities/Constant.dart';
import 'AppSQLHelper.dart';

class NoteSQLHelper {

  static Future<int> createNote(Note note) async {
    final db = await AppSQLHelper.db();

    int id = await db.insert(Constant.KEY_TABLE_NOTE, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> updateNote(Note note) async {
    final db = await AppSQLHelper.db();

    final result = await db
        .update(Constant.KEY_TABLE_NOTE, note.toMap(), where: "id = ?"
        , whereArgs: [note.id]);

    return result;
  }

  static Future<void> deleteNote(int id) async {
    final db = await AppSQLHelper.db();

    try {
      await db.delete(Constant.KEY_TABLE_NOTE, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item $err");
    }
  }

  static Future<List<Map<String, dynamic>>> getNoteDetailById(int id) async {
    final db = await AppSQLHelper.db();

    final maps = await db.rawQuery('''
      SELECT 
      ${Constant.KEY_TABLE_NOTE}.${Constant.KEY_NOTE_ID},
      ${Constant.KEY_TABLE_NOTE}.${Constant.KEY_NOTE_NAME},
      ${Constant.KEY_TABLE_NOTE}.${Constant.KEY_NOTE_PLAN_DATE},
      ${Constant.KEY_TABLE_NOTE}.${Constant.KEY_NOTE_CREATED_DATE},
      ${Constant.KEY_TABLE_CATEGORY}.${Constant.KEY_CATEGORY_NAME} as ${Constant.KEY_NOTE_CATEGORY_NAME}, 
      ${Constant.KEY_TABLE_CATEGORY}.${Constant.KEY_CATEGORY_ID} as ${Constant.KEY_NOTE_CATEGORY_ID}, 
      ${Constant.KEY_TABLE_STATUS}.${Constant.KEY_STATUS_NAME} as ${Constant.KEY_NOTE_STATUS_NAME}, 
      ${Constant.KEY_TABLE_STATUS}.${Constant.KEY_STATUS_ID} as  ${Constant.KEY_NOTE_STATUS_ID}, 
      ${Constant.KEY_TABLE_PRIORITY}.${Constant.KEY_PRIORITY_NAME} as  ${Constant.KEY_NOTE_PRIORITY_NAME},
      ${Constant.KEY_TABLE_PRIORITY}.${Constant.KEY_PRIORITY_ID} as ${Constant.KEY_NOTE_PRIORITY_ID}
      FROM ${Constant.KEY_TABLE_NOTE}
      LEFT JOIN ${Constant.KEY_TABLE_CATEGORY} ON 
      ${Constant.KEY_TABLE_NOTE}.${Constant.KEY_NOTE_CATEGORY_ID} = ${Constant.KEY_TABLE_CATEGORY}.${Constant.KEY_CATEGORY_ID}
      LEFT JOIN ${Constant.KEY_TABLE_STATUS} ON
      ${Constant.KEY_TABLE_NOTE}.${Constant.KEY_NOTE_STATUS_ID} = ${Constant.KEY_TABLE_STATUS}.${Constant.KEY_STATUS_ID}
      LEFT JOIN ${Constant.KEY_TABLE_PRIORITY} ON 
      ${Constant.KEY_TABLE_NOTE}.${Constant.KEY_NOTE_PRIORITY_ID} = ${Constant.KEY_TABLE_PRIORITY}.${Constant.KEY_PRIORITY_ID}
      WHERE ${Constant.KEY_TABLE_NOTE}.${Constant.KEY_NOTE_USER_ID} = ?
    ''', [id]);

    return maps;
  }


}
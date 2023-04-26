
import 'package:sqflite/sqflite.dart';
import '../ultilities/Constant.dart';

class AppSQLHelper {

  static Future<void> createUserTable(Database database) async {
    await database.execute('''CREATE TABLE ${Constant.KEY_TABLE_USER}(
        ${Constant.KEY_USER_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Constant.KEY_USER_EMAIL} TEXT NOT NULL,
        ${Constant.KEY_USER_FIRST_NAME} TEXT,
        ${Constant.KEY_USER_LAST_NAME} TEXT,
        ${Constant.KEY_USER_PASSWORD} TEXT NOT NULL
    )''');
  }

  static Future<void> createPriorityTable(Database database) async {
    await database.execute('''CREATE TABLE ${Constant.KEY_TABLE_PRIORITY}(
        ${Constant.KEY_PRIORITY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Constant.KEY_PRIORITY_NAME} TEXT NOT NULL,
        ${Constant.KEY_PRIORITY_USER_ID} INTEGER NOT NULL,
        ${Constant.KEY_PRIORITY_CREATED_DATE} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )''');
  }

  static Future<void> createStatusTable(Database database) async {
    await database.execute('''CREATE TABLE ${Constant.KEY_TABLE_STATUS}(
        ${Constant.KEY_STATUS_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Constant.KEY_STATUS_NAME} TEXT NOT NULL,
        ${Constant.KEY_STATUS_USER_ID} INTEGER NOT NULL,
        ${Constant.KEY_STATUS_CREATED_DATE} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )''');
  }

  static Future<void> createCategoryTable(Database database) async {
    await database.execute('''CREATE TABLE ${Constant.KEY_TABLE_CATEGORY}(
        ${Constant.KEY_CATEGORY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Constant.KEY_CATEGORY_NAME} TEXT NOT NULL,
        
        ${Constant.KEY_CATEGORY_CREATED_DATE} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )''');
  }
  //${Constant.KEY_CATEGORY_USER_ID} INTEGER NOT NULL,

  static Future<void> createNoteTable(Database database) async {
    await database.execute('''CREATE TABLE ${Constant.KEY_TABLE_NOTE}(
        ${Constant.KEY_NOTE_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Constant.KEY_NOTE_NAME} TEXT NOT NULL,
        ${Constant.KEY_NOTE_PLAN_DATE} TEXT NOT NULL,
        ${Constant.KEY_NOTE_CATEGORY_ID} INTEGER NOT NULL,
        ${Constant.KEY_NOTE_STATUS_ID} INTEGER NOT NULL,
        ${Constant.KEY_NOTE_PRIORITY_ID} INTEGER NOT NULL,
        ${Constant.KEY_NOTE_USER_ID} INTEGER NOT NULL,
        ${Constant.KEY_NOTE_CREATED_DATE} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )''');
  }

  static Future<Database> db() async {
    return openDatabase(
        Constant.KEY_DB_NAME,
        version: 1,
        onCreate: (Database database, int version) async {
          await createUserTable(database);
          await createCategoryTable(database);
          await createPriorityTable(database);
          await createStatusTable(database);
          await createNoteTable(database);
        }
    );
  }
}
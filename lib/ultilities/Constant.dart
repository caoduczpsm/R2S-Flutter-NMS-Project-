import 'package:flutter/material.dart';

class Constant{
  // ignore: constant_identifier_names
  static const KEY_DB_NAME = "note_management_system";

  // ignore: constant_identifier_names
  static const KEY_IS_SIGNED = "isSigned";

  // Bảng users
  // ignore: constant_identifier_names
  static const KEY_TABLE_USER = "users";
  // ignore: constant_identifier_names
  static const KEY_USER_FIRST_NAME = "first_name";
  // ignore: constant_identifier_names
  static const KEY_USER_LAST_NAME = "last_name";
  // ignore: constant_identifier_names
  static const KEY_USER_ID = "id";
  // ignore: constant_identifier_names
  static const KEY_USER_PASSWORD = "password";
  // ignore: constant_identifier_names
  static const KEY_USER_EMAIL = "email";

  // Bảng categories
  // ignore: constant_identifier_names
  static const KEY_TABLE_CATEGORY = "categories";
  // ignore: constant_identifier_names
  static const KEY_CATEGORY_ID = "id";
  // ignore: constant_identifier_names
  static const KEY_CATEGORY_NAME = "name";
  // ignore: constant_identifier_names
  static const KEY_CATEGORY_CREATED_DATE = "created_date";
  // ignore: constant_identifier_names
  static const KEY_CATEGORY_USER_ID = "user_id";

  // Bảng statuses
  // ignore: constant_identifier_names
  static const KEY_TABLE_STATUS = "status";
  // ignore: constant_identifier_names
  static const KEY_STATUS_ID = "id";
  // ignore: constant_identifier_names
  static const KEY_STATUS_NAME = "name";
  // ignore: constant_identifier_names
  static const KEY_STATUS_CREATED_DATE = "created_date";
  // ignore: constant_identifier_names
  static const KEY_STATUS_USER_ID = "user_id";
  // ignore: constant_identifier_names
  static const KEY_STATUS_DONE = "Done";
  // ignore: constant_identifier_names
  static const KEY_STATUS_PENDING = "Pending";
  // ignore: constant_identifier_names
  static const KEY_STATUS_DOING = "Doing";

  // Bảng priorities
  // ignore: constant_identifier_names
  static const KEY_TABLE_PRIORITY = "priorities";
  // ignore: constant_identifier_names
  static const KEY_PRIORITY_ID = "id";
  // ignore: constant_identifier_names
  static const KEY_PRIORITY_NAME = "name";
  // ignore: constant_identifier_names
  static const KEY_PRIORITY_CREATED_DATE = "created_date";
  // ignore: constant_identifier_names
  static const KEY_PRIORITY_USER_ID = "user_id";

  // Bảng notes
  // ignore: constant_identifier_names
  static const KEY_TABLE_NOTE = "notes";
  // ignore: constant_identifier_names
  static const KEY_NOTE_ID = "id";
  // ignore: constant_identifier_names
  static const KEY_NOTE_NAME = "name";
  // ignore: constant_identifier_names
  static const KEY_NOTE_PLAN_DATE = "plan_date";
  // ignore: constant_identifier_names
  static const KEY_NOTE_CREATED_DATE = "created_date";
  // ignore: constant_identifier_names
  static const KEY_NOTE_CATEGORY_ID = "category_id";
  // ignore: constant_identifier_names
  static const KEY_NOTE_STATUS_ID = "status_id";
  // ignore: constant_identifier_names
  static const KEY_NOTE_PRIORITY_ID = "priorities_id";
  // ignore: constant_identifier_names
  static const KEY_NOTE_USER_ID = "user_id";
  // ignore: constant_identifier_names
  static const KEY_NOTE_CATEGORY_NAME = "category_name";
  // ignore: constant_identifier_names
  static const KEY_NOTE_PRIORITY_NAME = "priority_name";
  // ignore: constant_identifier_names
  static const KEY_NOTE_STATUS_NAME = "status_name";

  // Màu Form Login, Register
  // ignore: constant_identifier_names
  static const PRIMARY_COLOR = Color(0XFF4CAEE3);
  static const kBackgroundColor = Color(0XFFE5E5E5);

  // Đăng nhập đăng ký

  // ignore: constant_identifier_names
  static const KEY_EMAIL_HAS_LENGTH_LESS_6_CHAR  = 1;
  // ignore: constant_identifier_names
  static const KEY_EMAIL_HAS_LENGTH_GREATER_256_CHAR  = 2;
  // ignore: constant_identifier_names
  static const KEY_EMAIL_MALFORMED  = 3;
  // ignore: constant_identifier_names
  static const KEY_VALID_EMAIL  = 0;

  // ignore: constant_identifier_names
  static const KEY_STATUS_COUNT = "count";
}


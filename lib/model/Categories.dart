import 'package:note_management_system/ultilities/Constant.dart';
class Categories {
  final int? id;
  final String? name;
  final String? createdAt;
  final int? userId;

  Categories({this.id, this.name, this.createdAt, this.userId});

  Map<String, dynamic> toMap() {
    return {
      Constant.KEY_CATEGORY_ID : id,
      Constant.KEY_CATEGORY_NAME : name,
      Constant.KEY_CATEGORY_USER_ID : userId,
    };
  }

  static Categories fromMap(Map<String, dynamic> map) {
    return Categories(
      id: map[Constant.KEY_CATEGORY_ID],
      name: map[Constant.KEY_CATEGORY_NAME],
      createdAt: map[Constant.KEY_CATEGORY_CREATED_DATE],
      userId: map[Constant.KEY_CATEGORY_USER_ID],
    );
  }
}
import 'package:note_management_system/ultilities/Constant.dart';
class Status {
  final int? id;
  final String? name;
  final String? createdAt;
  final int? userId;

  Status({this.id, this.name, this.createdAt, this.userId});

  Map<String, dynamic> toMap() {
    return {
      Constant.KEY_CATEGORY_ID : id,
      Constant.KEY_CATEGORY_NAME : name,
      Constant.KEY_CATEGORY_CREATED_DATE : createdAt,
      Constant.KEY_CATEGORY_USER_ID : userId,
    };
  }
}
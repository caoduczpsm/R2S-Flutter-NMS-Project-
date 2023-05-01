import 'package:note_management_system/ultilities/Constant.dart';
class Status {
  final int? id;
  final String? name;
  final String? createdAt;
  final int? userId;

  Status({this.id, this.name, this.createdAt, this.userId});

  Map<String, dynamic> toMap() {
    return {
      Constant.KEY_STATUS_ID : id,
      Constant.KEY_STATUS_NAME : name,
      Constant.KEY_STATUS_USER_ID : userId,
    };
  }

  static Status fromMap(Map<String, dynamic> map) {
    return Status(
      id: map[Constant.KEY_STATUS_ID],
      name: map[Constant.KEY_STATUS_NAME],
      createdAt: map[Constant.KEY_STATUS_CREATED_DATE],
      userId: map[Constant.KEY_STATUS_USER_ID],
    );
  }
}
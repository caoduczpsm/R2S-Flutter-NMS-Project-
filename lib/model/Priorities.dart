import 'package:note_management_system/ultilities/Constant.dart';
class Priorities {
  final int? id;
  final String? name;
  final String? createdAt;
  final int? userId;

  Priorities({this.id, this.name, this.createdAt, this.userId});

  Map<String, dynamic> toMap() {
    return {
      Constant.KEY_PRIORITY_ID : id,
      Constant.KEY_PRIORITY_NAME : name,
      Constant.KEY_PRIORITY_USER_ID : userId,
    };
  }

  static Priorities fromMap(Map<String, dynamic> map) {
    return Priorities(
      id: map[Constant.KEY_PRIORITY_ID],
      name: map[Constant.KEY_PRIORITY_NAME],
      createdAt: map[Constant.KEY_PRIORITY_CREATED_DATE],
      userId: map[Constant.KEY_PRIORITY_USER_ID],
    );
  }
}
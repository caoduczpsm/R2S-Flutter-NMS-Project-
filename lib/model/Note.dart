
import '../ultilities/Constant.dart';

class Note {
  final int? id;
  final String? name;
  final String? planDate;
  final int? categoryId;
  final int? statusId;
  final int? priorityId;
  final int? userId;
  final String? createdDate;


  Note({this.id, this.name, this.planDate, this.categoryId, this.statusId, this.priorityId, this.userId, this.createdDate});

  Map<String, dynamic> toMap(){
    return {
      Constant.KEY_NOTE_ID : id,
      Constant.KEY_NOTE_NAME : name,
      Constant.KEY_NOTE_PLAN_DATE : planDate,
      Constant.KEY_NOTE_CATEGORY_ID : categoryId,
      Constant.KEY_NOTE_STATUS_ID : statusId,
      Constant.KEY_NOTE_PRIORITY_ID : priorityId,
      Constant.KEY_NOTE_USER_ID : userId
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map[Constant.KEY_NOTE_ID],
      name: map[Constant.KEY_NOTE_NAME],
      planDate: map[Constant.KEY_NOTE_PLAN_DATE],
      categoryId: map[Constant.KEY_NOTE_CATEGORY_ID],
      statusId: map[Constant.KEY_NOTE_STATUS_ID],
      priorityId: map[Constant.KEY_NOTE_PRIORITY_ID],
      userId: map[Constant.KEY_NOTE_USER_ID],
      createdDate: map[Constant.KEY_NOTE_CREATED_DATE].toString(),
    );
  }

}
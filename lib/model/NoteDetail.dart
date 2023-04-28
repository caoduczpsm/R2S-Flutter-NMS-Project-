
import '../ultilities/Constant.dart';

class NoteDetail{
  final int? id;
  final String? name;
  final String? planDate;
  final String? createdDate;
  final String? categoryName;
  final String? statusName;
  final String? priorityName;

  NoteDetail({this.id, this.name, this.planDate, this.createdDate ,this.categoryName, this.statusName, this.priorityName});

  static NoteDetail fromMap(Map<String, dynamic> map) {
    return NoteDetail(
      id: map[Constant.KEY_NOTE_ID],
      name: map[Constant.KEY_NOTE_NAME],
      planDate: map[Constant.KEY_NOTE_PLAN_DATE],
      createdDate: map[Constant.KEY_NOTE_CREATED_DATE],
      categoryName: map[Constant.KEY_NOTE_CATEGORY_NAME],
      statusName: map[Constant.KEY_NOTE_STATUS_NAME],
      priorityName: map[Constant.KEY_NOTE_PRIORITY_NAME],
    );
  }

}
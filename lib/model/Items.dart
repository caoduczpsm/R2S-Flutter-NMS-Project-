import 'package:note_management_system/ultilities/Constant.dart';
class Items {
  final int? id;
  final String? title;
  final String? createdAt;
  //final int? userId;

  Items({this.id, this.title, this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      Constant.KEY_CATEGORY_ID : id,
      Constant.KEY_CATEGORY_NAME : title,
      Constant.KEY_CATEGORY_CREATED_DATE : createdAt,
      //Constant.KEY_CATEGORY_USER_ID : userId,
    };
  }
}
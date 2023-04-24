import 'package:note_management_system/ultilities/Constant.dart';

class User {
  final int? id;
  final String? email;
  final String? password;
  final String? name;

  User({this.id, this.email, this.password, this.name});

  Map<String, dynamic> toMap(){
    return {
      Constant.KEY_USER_ID : id,
      Constant.KEY_USER_EMAIL : email,
      Constant.KEY_USER_PASSWORD : password,
      Constant.KEY_USER_NAME : name,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map[Constant.KEY_USER_ID],
      email: map[Constant.KEY_USER_EMAIL],
      password: map[Constant.KEY_USER_PASSWORD],
      name: map[Constant.KEY_USER_NAME],
    );
  }
}
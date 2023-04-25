import 'package:note_management_system/ultilities/Constant.dart';

class User {
  final int? id;
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;

  User({this.id, this.email, this.password,  this.firstName, this.lastName});

  Map<String, dynamic> toMap(){
    return {
      Constant.KEY_USER_ID : id,
      Constant.KEY_USER_EMAIL : email,
      Constant.KEY_USER_PASSWORD : password,
      Constant.KEY_USER_FIRST_NAME : firstName,
      Constant.KEY_USER_LAST_NAME : lastName,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map[Constant.KEY_USER_ID],
      email: map[Constant.KEY_USER_EMAIL],
      password: map[Constant.KEY_USER_PASSWORD],
      firstName: map[Constant.KEY_USER_FIRST_NAME],
      lastName: map[Constant.KEY_USER_LAST_NAME],
    );
  }
}
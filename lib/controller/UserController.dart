import 'package:note_management_system/db/UserDatabase.dart';

import '../model/User.dart';

import 'dart:convert';
import 'package:crypto/crypto.dart';


class UserController {


  bool checkValidEmail(String email){
    if (RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email) == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String email, password) async{
    if (await UserSqlHelper.checkEmailAlreadyUsed(email)){
      User user = User(
        email: email,
        password: hashPassword(password),
      );
      UserSqlHelper.createUser(user);
      return true;
    }
    return false;
  }

  Future<int?> login(String email, String password) async{
    final user = await UserSqlHelper.getUserByEmailPassword(email, hashPassword(password));
    if (user != null){
      return user.id;
    } else {
      return null;
    }
  }

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
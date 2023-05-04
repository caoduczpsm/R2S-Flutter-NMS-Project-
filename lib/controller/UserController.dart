import 'dart:convert';

import 'package:note_management_system/db/UserDatabase.dart';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'package:note_management_system/ultilities/Constant.dart';
import '../model/User.dart';


class UserController {


  int checkValidEmail(String email){
    if (email.length < 6) {
      return Constant.KEY_EMAIL_HAS_LENGTH_LESS_6_CHAR;
    } else
      if (email.length > 256){
        return Constant.KEY_EMAIL_HAS_LENGTH_GREATER_256_CHAR;
      }
       else
        if (RegExp(r'^(?!.*\.{2})[a-zA-Z0-9._]+(?<!\.)@[a-zA-Z0-9.-]+(?<!\.{2})\.[a-zA-Z]{2,}$')
            .hasMatch(email) == false) {
          return Constant.KEY_EMAIL_MALFORMED;
        } else {
          return Constant.KEY_VALID_EMAIL;
        }
  }

  int checkValidPassword(String password){
    if (password.length < 6 || password.length > 32){
      return 1;
    } else
      if (RegExp(r'^(?=.*[A-Z]).+$')
          .hasMatch(password) == false) {
        return 2;
      } else
        if (RegExp(r'^(?=.*\d).+$')
            .hasMatch(password) == false){
          return 3;
        } else {
          return 0;
        }
  }

  int checkValidName(String name){
    if (name.length < 2 || name.length > 32){
      return 1;
    } else
      if (name[name.length-1] == " "){
        return 2;
      } else {
        return 0;
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
    final user = await UserSqlHelper.getUserByEmailPassword(email,
        hashPassword(password));

    if (user != null){
      return user.id;
    } else {
      return null;
    }

  }

  Future<void> changePassword(String email, String newPassword) async{
    await UserSqlHelper.changePassword(email, newPassword);
  }

  Future<void> editProfile(int id, String email, String firstName,
      String lastName) async{

    await UserSqlHelper.updateUserInfo(id, email, firstName, lastName);

  }


  String hashPassword(String password){
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
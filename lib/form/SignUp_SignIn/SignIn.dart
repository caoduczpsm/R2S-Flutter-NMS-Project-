import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_management_system/controller/UserController.dart';
import 'package:note_management_system/db/UserDatabase.dart';
import 'package:note_management_system/form/SignUp_SignIn/SignUp.dart';
import 'package:note_management_system/model/User.dart';

import '../../ultilities/Constant.dart';
import 'Container.dart';
import 'Constants.dart';
import '../dashboard_page/dashboard.dart';

void main() => runApp(const SignInForm());

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _MySignInForm(),
    );
  }
}

class _MySignInForm extends StatefulWidget {
  const _MySignInForm({Key? key}) : super(key: key);

  @override
  State<_MySignInForm> createState() => _MySignInFormState();
}

class _MySignInFormState extends State<_MySignInForm> {
  UserController userController = UserController();

  final _signInForm = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Management System'),
      ),
      body: Center(
        child: Column(
          children: [
            //
            // const Center(
            //   child: Text('Note Management System'
            //     ,style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.grey,
            //     ),),
            // ),
            Image.asset('images/logo_login.png'),
            Form(
              key: _signInForm,
              child: Column(
                children: [
                  InputContainer(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 11.0, 20.0, 0),
                          hintText: '  Email',
                          prefixIcon: Icon(Icons.email, color: Constant.PRIMARY_COLOR,),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 50,
                            minHeight: 40,
                          ),
                          border: InputBorder.none
                      ),
                      validator: (value){
                        if (value == null || value.isEmpty){
                          return 'Please enter email';
                        } else {
                          int result = userController.checkValidEmail(_email.text);
                          switch (result){
                            case 1: {
                              return 'Please enter at least 6 characters';
                            }
                            break;
                            case 2: {
                              return 'Please enter up to 256 characters';
                            }
                            break;
                            case 3: {
                              return 'Invalid Email';
                            }
                            break;
                          }
                        }
                        return null;
                      },
                      controller: _email,
                    ),),
                  const SizedBox(height: 20),
                  InputContainer(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 11.0, 20.0, 0),
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.key, color: Constant.PRIMARY_COLOR),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 50,
                          minHeight: 40,
                        ),
                          border: InputBorder.none,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r"\s")),
                      ],

                      validator: (value){
                        if (value == null || value.isEmpty){
                          return 'Please enter password';
                        }
                        return null;
                      },
                      controller: _password,
                      obscureText: true,
                    ),),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: size.width * 0.8,
                    height: size.height * 0.06,
                    child:ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(size.width * 0.5),
                            side: BorderSide(
                              width: size.width * 0.8,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      onPressed:() async {
                        if (_signInForm.currentState!.validate()){
                          int? userID = await userController.login(_email.text.trim(),
                              _password.text.trim());
                          if (userID != null){
                            final user = await UserSqlHelper.getUserById(userID);

                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Login Successful')));

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // Cái này chuyển đến dashboard khi login thành công
                                // Có thể thêm tham số userID khi chuyển trang để xử lý những dữ liệu khác khi cần user ID
                                builder: (context) => NoteManagementApp(user: user as User), // Ở đây
                              ),
                            );
                          } else {
                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Invalid Email '
                                    'or Password')));
                          }
                        }
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const SignUpForm()));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}



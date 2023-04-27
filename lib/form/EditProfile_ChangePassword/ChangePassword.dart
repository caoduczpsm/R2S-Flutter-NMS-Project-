import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_management_system/item.dart';

import '../../controller/UserController.dart';
import '../../dashboard.dart';
import '../../model/User.dart';


// ignore: must_be_immutable
class ChangePasswordForm extends StatelessWidget {
  User user;

  ChangePasswordForm({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _MyChangePasswordForm(user: user,),
    );
  }
}

// ignore: must_be_immutable
class _MyChangePasswordForm extends StatefulWidget {
  User user;

  _MyChangePasswordForm({required this.user});

  @override
  // ignore: no_logic_in_create_state
  State<_MyChangePasswordForm> createState() => _MyChangePasswordFormState(user: user);
}

class _MyChangePasswordFormState extends State<_MyChangePasswordForm> {
  User user;

  _MyChangePasswordFormState({required this.user});

  UserController userController = UserController();

  final _changePasswordForm = GlobalKey<FormState>();
  final _currentPassword = TextEditingController();
  final _password = TextEditingController();
  final _repassword = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _currentPassword.dispose();
    _password.dispose();
    _repassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text('Change Password'
              ,style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _changePasswordForm,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Current Password',
                    prefixIcon: Icon(Icons.password),
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Please enter password';
                    }
                    return null;
                  },
                  controller: _currentPassword,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.key),
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Please enter password';
                    }
                    return null;
                  },
                  controller: _password,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Re-Password',
                    prefixIcon: Icon(Icons.key),
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Please enter re-password';
                    } else if (_password.text!=value){
                      return 'Password does not match!';
                    }
                    return null;
                  },
                  controller: _repassword,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed:() async {
                        if (_changePasswordForm.currentState!.validate()){
                          if (user.password == userController.hashPassword(_currentPassword.text.trim())) {
                              userController.changePassword(user.email!, userController.hashPassword(_password.text.trim()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Change Successful!')));
                              setState(() {
                                _currentPassword.text = "";
                                _password.text = "";
                                _repassword.text = "";
                              });

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Current Password Does Not Match!')));
                          }
                        //  }
                        }
                      },
                      child: const Text('Change'),
                    ),
                    ElevatedButton(
                      onPressed:(){
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => NoteApp(user: user)));
                      },
                      child: const Text('Home'),
                    )
                  ],
                )
              ],
            ),
          ),

        ],
      ),

    );
  }
}
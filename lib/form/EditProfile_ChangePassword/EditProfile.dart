import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../controller/UserController.dart';
import '../../model/User.dart';

import '../dashboard_page/dashboard.dart';


// ignore: must_be_immutable
class EditProfileForm extends StatelessWidget {
  User user;

  EditProfileForm({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _MyEditProfileForm(user: user,),
    );
  }
}

// ignore: must_be_immutable
class _MyEditProfileForm extends StatefulWidget {
  User user;

  _MyEditProfileForm({required this.user});

  @override
  // ignore: no_logic_in_create_state
  State<_MyEditProfileForm> createState() => _MyEditProfileFormState(user: user);
}

class _MyEditProfileFormState extends State<_MyEditProfileForm> {
  User user;

  _MyEditProfileFormState({required this.user});

  UserController userController = UserController();

  final _editProfileForm = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();


  @override
  void dispose(){
    super.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (user.firstName != null) _firstName.text = user.firstName!;
    if (user.lastName != null) _lastName.text = user.lastName!;
    if (user.email != null) _email.text = user.email!;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text('Edit Profile'
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
            key: _editProfileForm,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                    prefixIcon: Icon(Icons.drive_file_rename_outline),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z\s]'),
                    ),
                  ],
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Please enter First Name';
                    } else {
                      int result = userController.checkValidName(_firstName.text);
                      switch (result){
                        case 1: {
                          return 'First Name has a length of 2 - 32 characters';
                        }
                        case 2: {
                          return 'Please do not end with a space';
                        }
                      }
                    }
                    return null;
                  },
                  controller: _firstName,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                    prefixIcon: Icon(Icons.drive_file_rename_outline),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z\s]'),
                    ),
                  ],
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Please enter Last Name';
                    } else {
                      int result = userController.checkValidName(_lastName.text);
                      switch (result){
                        case 1: {
                          return 'First Name has a length of 2 - 32 characters';
                        }
                        case 2: {
                          return 'Please do not end with a space';
                        }
                      }
                    }
                    return null;
                  },
                  controller: _lastName,
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty){
                      return 'Please enter email';
                    } else {
                      int result = userController.checkValidEmail(_email.text);
                      switch (result){
                        case 1: {
                          return 'Please enter at least 6 characters';
                        }
                        case 2: {
                          return 'Please enter up to 256 characters';
                        }
                        case 3: {
                          return 'Invalid Email';
                        }
                      }
                    }
                    return null;
                  },
                  controller: _email,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed:() async {
                        if (_editProfileForm.currentState!.validate()
                            && user.id != null){
                          userController.editProfile(user.id!, _email.text,
                              _firstName.text, _lastName.text);

                          ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Change Successful!')));

                          setState(() {
                            user.email = _email.text;
                            user.firstName = _firstName.text;
                            user.lastName = _lastName.text;

                          });
                        }
                      },
                      child: const Text('Change'),
                    ),
                    ElevatedButton(
                      onPressed:(){

                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context)
                        => NoteManagementApp(user: user)));

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
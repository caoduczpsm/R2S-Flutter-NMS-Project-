import 'dart:io';

import 'package:flutter/material.dart';
import 'SignIn.dart';
import 'package:note_management_system/controller/UserController.dart';

void main() => runApp(const SignUpForm());

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _MySignUpForm(),
    );
  }
}

class _MySignUpForm extends StatefulWidget {
  const _MySignUpForm({Key? key}) : super(key: key);

  @override
  State<_MySignUpForm> createState() => _MySignUpFormState();
}

class _MySignUpFormState extends State<_MySignUpForm> {
  UserController userController = UserController();

  final _signUpForm = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repassword = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _email.dispose();
    _password.dispose();
    _repassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Management System'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text('Sign Up Form'
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
            key: _signUpForm,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty){
                      return 'Please enter email';
                    } else if (userController.checkValidEmail(_email.text) == false){
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  controller: _email,
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
                        if (_signUpForm.currentState!.validate()){
                          if (await userController.register(_email.text.trim(), _password.text.trim())){
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Register Successful')));
                          } else {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Email Already Used')));
                          }
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                    ElevatedButton(
                      onPressed:(){
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => const SignInForm()));
                      },
                      child: const Text('Sign In'),
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




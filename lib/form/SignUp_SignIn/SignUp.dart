import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_management_system/form/SignUp_SignIn/Container.dart';
import '../../ultilities/Constant.dart';
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Management System'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('images/logo_login.png'),

              Form(
                key: _signUpForm,
                child: Column(
                  children: [
                    InputContainer(
                      child: TextFormField(
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20.0, 11.0, 20.0, 0),
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email, color: Constant.PRIMARY_COLOR,),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 50,
                              minHeight: 40,
                            ),
                            border: InputBorder.none
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
                      ),),
                    const SizedBox(height: 10),
                    InputContainer(
                      child:  TextFormField(
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20.0, 11.0, 20.0, 0),
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.key, color: Constant.PRIMARY_COLOR,),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 50,
                              minHeight: 40,
                            ),
                            border: InputBorder.none
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s")),
                        ],
                        validator: (value){
                          if (value == null || value.isEmpty){
                            return 'Please enter password';
                          } else {
                            int result = userController.checkValidPassword(_password.text);
                            switch (result){
                              case 1: {
                                return 'Password length from 6 - 32 characters';
                              }
                              case 2: {
                                return 'Please enter at least 1 capital letter';
                              }
                              case 3: {
                                return 'Please enter at least 1 number';
                              }
                            }
                          }
                          return null;
                        },
                        controller: _password,
                        obscureText: true,
                      ),),
                    const SizedBox(height: 10),
                    InputContainer(
                      child:  TextFormField(
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20.0, 11.0, 20.0, 0),
                            hintText: 'Re-Password',
                            prefixIcon: Icon(Icons.key, color: Constant.PRIMARY_COLOR),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 50,
                              minHeight: 40,
                            ),
                            border: InputBorder.none
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s")),
                        ],
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
                      ),),
                    const SizedBox(height: 10),
                    Container(
                      width: size.width * 0.8,
                      height: size.height * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: size.width * 0.3,
                            height: size.height * 0.05,
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
                                if (_signUpForm.currentState!.validate()){
                                  if (await userController.register(_email.text.trim(),
                                      _password.text.trim())){

                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Register Successful')));
                                    setState(() {
                                      _email.text = "";
                                      _password.text = "";
                                      _repassword.text = "";
                                    });
                                  } else {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Email Already Used')));
                                  }
                                }
                              },
                              child: const Text(
                                'SIGN UP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                            height: size.height * 0.05,
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
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context)
                                => const SignInForm()));
                              },
                              child: const Text(
                                'SIGN IN',
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
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      )

    );
  }
}




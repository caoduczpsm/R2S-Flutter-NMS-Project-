
import 'package:flutter/material.dart';
import 'package:note_management_system/form/SignUp_SignIn/SignIn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInForm(),
    );
  }
}

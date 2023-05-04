import 'package:flutter/material.dart';

import 'package:note_management_system/form/SignUp_SignIn/Constants.dart';

import '../../ultilities/Constant.dart';

class InputContainer extends StatelessWidget {

  const InputContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: size.width * 0.8,
      height: size.height * 0.065,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Constant.PRIMARY_COLOR.withAlpha(50)
      ),

      child: child
    );
  }
}
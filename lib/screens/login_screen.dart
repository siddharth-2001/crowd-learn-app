// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../widgets/registration.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = "/login";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top -
        MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.blue,
            height: height * 0.25,
          ),
          Expanded(child: RegisterForm()),
          Padding(padding: EdgeInsets.symmetric(vertical: 24))
        ],
      ),
    );
  }
}

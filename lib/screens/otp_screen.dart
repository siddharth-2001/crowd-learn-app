import 'package:crowd_learn/widgets/otp.dart';
import 'package:flutter/material.dart';

//local
import './otp_screen.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);
  static const routeName = "/otp";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OtpForm(),
        ],
      ),
    );
  }
}

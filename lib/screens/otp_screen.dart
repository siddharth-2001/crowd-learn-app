import 'package:crowd_learn/widgets/otp.dart';
import 'package:flutter/material.dart';

//local


class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);
  static const routeName = "/otp";

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          OtpForm(),
        ],
      ),
    );
  }
}

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

    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: theme.colorScheme.primary,
            height: height * 0.25,
          ),
         const Expanded(child: RegisterForm()),
         const Padding(padding: EdgeInsets.symmetric(vertical: 24))
        ],
      ),
    );
  }
}

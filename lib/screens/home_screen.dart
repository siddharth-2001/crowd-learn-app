import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<User>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Text("You have logged in with email ${auth.getEmail()}"),
      ),
    );
  }
}

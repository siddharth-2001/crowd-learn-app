import 'package:crowd_learn/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user.dart';
import './new_session.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    final auth = Provider.of<User>(context, listen: false);
    auth.tryAutoLogin().then((value) {
      if (!value) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      } else {
        _isLoading = false;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<User>(context);

    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You have logged in with email ${auth.email}"),
                  ElevatedButton(
                      onPressed: () {
                        auth.logout().then((value) {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName);
                        });
                      },
                      child: const Text("Logout"))
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(NewSessionScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

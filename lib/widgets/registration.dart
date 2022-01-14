import 'package:flutter/material.dart';

enum mode { Login, Register }

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

Widget putHeadline(BuildContext context, String g) {
  return Text(
    g,
    style:const TextStyle(
      fontWeight: FontWeight.bold,
    ),
  );
}

class _RegisterFormState extends State<RegisterForm> {
  var _currMode = mode.Login;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top -
        MediaQuery.of(context).viewPadding.bottom;
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: _currMode == mode.Login
                      ? putHeadline(context, "Login")
                      : putHeadline(context, "Register"),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                ),
               const SizedBox(
                  height: 24,
                ),
                TextFormField(
                    decoration:const InputDecoration(labelText: "Password")),
              const  SizedBox(
                  height: 24,
                ),
                if (_currMode == mode.Register)
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Confirm Password"),
                  ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(content: Text("Submitted!")));
                      },
                      child: _currMode == mode.Login
                          ? const Text("Login")
                          : const Text("Register")),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _currMode == mode.Login
                            ? _currMode = mode.Register
                            : _currMode = mode.Login;
                      });
                    },
                    child: _currMode == mode.Register
                        ? const Text("Sign In")
                        : const Text("Register"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

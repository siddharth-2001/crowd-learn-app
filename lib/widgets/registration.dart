import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
//local
import '../screens/otp_screen.dart';
import '../provider/user.dart';

enum mode { login, register }

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

Widget putHeadline(BuildContext context, String g) {
  return Text(g, style: Theme.of(context).textTheme.headline6);
}

class _RegisterFormState extends State<RegisterForm> {
  var _currMode = mode.login;
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;

  Map<String, String> data = {
    "email": "",
    "username": "",
  };

  void _saveForm() {
    setState(() {
      _isLoading = true;
    });

    final user = Provider.of<User>(context, listen: false);

    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();

    user.register(data["email"], data["username"]).then((value) {
      setState(() {
        _isLoading = false;
      });

      if (value != 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Some error occured.")));
      } else {
        Navigator.pushNamed(context, OtpScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _form,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: _currMode == mode.login
                            ? putHeadline(context, "Login")
                            : putHeadline(context, "Register"),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null ||
                              !value.contains("@") ||
                              !value.contains(".com")) {
                            return "Please enter a valid email";
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: "Email",
                        ),
                        onSaved: (email) {
                          data["email"] = email!;
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      if (_currMode == mode.register)
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "Username"),
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
                              _saveForm();
                            },
                            child: _currMode == mode.login
                                ? const Text("Login")
                                : const Text("Register")),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _currMode == mode.login
                                  ? _currMode = mode.register
                                  : _currMode = mode.login;
                            });
                          },
                          child: _currMode == mode.register
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

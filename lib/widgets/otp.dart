import 'package:provider/provider.dart';
//local
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../provider/user.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _form = GlobalKey<FormState>();
  String otp = '';
  bool _isLoading = false;

  void saveForm() {
    setState(() {
      _isLoading = true;
    });

    final auth = Provider.of<User>(context, listen: false);

    if (!_form.currentState!.validate()) {
      return;
    }

    auth.checkOtp(otp).then((value) {
      setState(() {
        _isLoading = false;
      });
      if (value == 200) {
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Some error occured")));
      }
    });

    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _isLoading ?const Center(child: CircularProgressIndicator(),) : Form(
      key: _form,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 48.0,
        ),
        child: Column(
          children: [
            Text(
              "Enter OTP",
              style: theme.textTheme.headline6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "OTP"),
                onSaved: (value) {
                  otp = value!;
                },
              ),
            ),
            SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      saveForm();
                    },
                    child: const Text("Submit")))
          ],
        ),
      ),
    );
  }
}

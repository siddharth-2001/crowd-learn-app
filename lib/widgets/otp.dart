import 'package:crowd_learn/provider/user.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
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
                decoration: InputDecoration(labelText: "OTP"),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("THEEK SE BHAR LAVDE")));
                    },
                    child: Text("Submit")))
          ],
        ),
      ),
    );
  }
}

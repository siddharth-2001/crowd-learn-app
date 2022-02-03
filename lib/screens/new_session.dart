import 'package:flutter/material.dart';
//local
import '../widgets/create_session_form.dart';

class NewSessionScreen extends StatelessWidget {
  const NewSessionScreen({Key? key}) : super(key: key);
  static const routeName = '/session/create';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Session"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 48,
            ),
            CreateSessionForm(),
          ],
        ),
      ),
    );
  }
}

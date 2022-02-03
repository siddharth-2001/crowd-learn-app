import 'dart:developer';

import 'package:crowd_learn/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//local
import '../provider/sessions.dart';

enum standard {
  below_10,
  below_12,
  above_12,
}

class CreateSessionForm extends StatefulWidget {
  const CreateSessionForm({Key? key}) : super(key: key);

  @override
  State<CreateSessionForm> createState() => _CreateSessionFormState();
}

class _CreateSessionFormState extends State<CreateSessionForm> {
  final _form = GlobalKey<FormState>();

  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  standard _std = standard.below_10;

  final Map<String, dynamic> _data = {
    'date': DateTime.now().toString(),
    'std': '',
    'ctgry': '',
    'meet': '',
    'topic': '',
    'epoch': 0
  };

  void _pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)))
        .then((value) {
      setState(() {
        _date = value!;
      });
    });
  }

  void _pickTime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _time = value!;
      });
    });
  }

  void _submit() {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();

    final sessions = Provider.of<Sessions>(context, listen: false);
    final user = Provider.of<User>(context, listen: false);

    sessions
        .createSession(
            inpStd: _data['std']!,
            inpCtgry: _data['ctgry']!,
            inpTopic: _data['topic']!,
            inpLink: _data['meet']!,
            inpDate: _data['date']!,
            inpToken: user.token,
            inpEpoch: _data['epoch']!
            )
        .then((value) {
      if (value == 201) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Session Created")));
      } else if (value != 201) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(value.toString())));
      }
    });
  }

  List<DropdownMenuItem> stdList = const [
    DropdownMenuItem(value: standard.below_10, child: Text("Below 10")),
    DropdownMenuItem(value: standard.below_12, child: Text("10-12")),
    DropdownMenuItem(value: standard.above_12, child: Text("Above 12"))
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
        key: _form,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Category"),
                validator: (value) {
                  if (value == null || value == "" || value.length < 3) {
                    return "Enter a valid category";
                  }
                },
                onSaved: (newValue) {
                  _data['ctgry'] = newValue!;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Topic"),
                validator: (value) {
                  if (value == null || value == "" || value.length < 3) {
                    return "Enter a valid topic";
                  }
                },
                onSaved: (newValue) {
                  _data['topic'] = newValue!;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: "Class",
                  ),
                  items: stdList,
                  onChanged: (dynamic value) {
                    setState(() {
                      _std = value;
                    });
                  }),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Class Link"),
                validator: (value) {
                  if (value == null ||
                      value == "" ||
                      !value.contains("https://meet.google.com/")) {
                    return "Enter a valid Google Meet link";
                  }
                },
                onSaved: (newValue) {
                  _data['meet'] = newValue!;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(DateFormat.yMMMMd().format(_date)),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () {
                        _pickDate();
                      },
                      child: Text(
                        "Select Date",
                        style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w400),
                      ))
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(_time.format(context)),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () {
                        _pickTime();
                      },
                      child: Text(
                        "Select Time",
                        style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w400),
                      ))
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      _data['std'] = _std.toString();
                      _date = _date.add(
                          Duration(hours: _time.hour, minutes: _time.minute));
                      _data['date'] = _date.toString();
                      _data['epoch'] = _date.millisecondsSinceEpoch;
                      _submit();
                    },
                    child: const Text("Create Session")),
              )
            ],
          ),
        ));
  }
}

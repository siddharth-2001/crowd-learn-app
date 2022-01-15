import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User extends ChangeNotifier {
  String username = "";
  String email = "";
  String token = "";

  // Future<void> login() async {
  //   final url = Uri.parse("https://crowd-learn.herokuapp.com/register");
  //   final 
  // }

  Future<void> register(final inputEmail, final inputUsername) async {
    final url = Uri.parse("https://crowd-learn.herokuapp.com/register");

    final response = await http.post(url,
        body: json.encode({
          "email": inputEmail,
          "username": inputUsername,
        }));

    int token = json.decode(response.body)["otp"];
  

    print(token.toString());
  }
}

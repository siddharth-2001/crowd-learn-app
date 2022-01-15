import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User extends ChangeNotifier {
  String username = "";
  String email = "";
  String token = "";
  String otp = "";

  bool isAuth() {
    if (token != "") return false;
    return true;
  }

  String getEmail() {
    return email;
  }

  Future<int> checkOtp(final inputOtp) async {
    final url =
        Uri.parse("https://crowd-learn.herokuapp.com/verifyuser/$email");
    http.Response response;

    if (otp == inputOtp) {
      response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
      );
    } else {
      response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
      );
      email = "";
      username = "";
      token = "";
    }
    return response.statusCode;
  }

  Future<int> register(final inputEmail, final inputUsername) async {
    final url = Uri.parse("https://crowd-learn.herokuapp.com/register");

    http.Response response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": inputEmail,
          "username": inputUsername,
        }));

    if (response.statusCode == 200) {
      token = json.decode(response.body)["token"];
      otp = json.decode(response.body)["otp"].toString();
      email = inputEmail;
      username = inputUsername;
    }

    return response.statusCode;
  }
}
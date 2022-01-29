import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User extends ChangeNotifier {
  String _username = "";
  String _email = "";
  String _token = "";
  String _otp = "";

  bool isAuth() {
    if (_token != "") return false;
    return true;
  }

  get email {
    String res = _email.toString();
    return res;
  }

  get username {
    String res = _username.toString();
    return res;
  }

  Future<bool> checkOtp(String inputOtp) async {
    final url =
        Uri.parse("https://crowd-learn.herokuapp.com/verifyuser/$_email");

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    if (_otp == inputOtp) {
      http.Response response = await http.put(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode > 200) return false;

      return true;
    }

    return false;
  }

  Future<int> retryOtp() async {
    final url = Uri.parse("https://crowd-learn.herokuapp.com/resendotp/");

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    http.Response response = await http.post(url,
        body: json.encode({
          "email": _email,
          "username": _username,
        }),
        headers: requestHeaders);

    log(response.body);

    if (response.statusCode > 200) return response.statusCode;

    final resBody = json.decode(response.body);
    _otp = resBody["otp"];
    _token = resBody["token"];

    return response.statusCode;
  }

  Future<int> register(String userEmail, String userName) async {
    final url = Uri.parse("http://crowd-learn.herokuapp.com/register/");

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    Map<String, String> body = {
      "email": userEmail,
      "username": userName,
    };

    var response =
        await http.post(url, headers: requestHeaders, body: json.encode(body));
    log(response.body);

    if (response.statusCode >= 200) {
      _token = json.decode(response.body)["token"];
      _otp = json.decode(response.body)["otp"];
      _email = userEmail;
      _username = userName;

      notifyListeners();
    }
    return response.statusCode;
  }
}

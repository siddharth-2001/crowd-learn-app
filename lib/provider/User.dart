import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
//import
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User extends ChangeNotifier {
  String _username = "";
  String _email = "";
  String _token = "";
  String _otp = "";

  Future<bool> tryAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("token")) {
      return false;
    } else if (prefs.getString("token") == "") {
      return false;
    }

    //fetch and set data on disk
    _token = prefs.getString("token")!;
    _email = prefs.getString("email")!;
    _username = prefs.getString("username")!;

    notifyListeners();

    return true;
  }

  get isAuth {
    if (_token == "") return false;
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

  get token {
    String tok = _token.toString();
    return tok;
  }

  Future<void> saveDisk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", _email);
    prefs.setString("token", _token);
    prefs.setString("username", _username);
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _email = "";
    _username = "";
    _otp = "";
    _token = "";
  }

  Future<bool> checkOtp(String inputOtp) async {
    final url =
        Uri.parse("https://crowd-learn.herokuapp.com/auth/verifyuser/$_email");

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    if (_otp == inputOtp) {
      http.Response response = await http.put(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode >= 300) return false;

      saveDisk();

      return true;
    }

    return false;
  }

  Future<int> retryOtp() async {
    final url = Uri.parse("https://crowd-learn.herokuapp.com/auth/resendotp/");

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

    if (response.statusCode >= 300) return response.statusCode;

    final resBody = json.decode(response.body);

    _otp = resBody["otp"];
    _token = resBody["token"];
    _username = resBody["user"];

    return response.statusCode;
  }

  Future<int> login(String userEmail) async {
    final url = Uri.parse("http://crowd-learn.herokuapp.com/auth/login/");

    //map for headers for the api
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final http.Response response = await http.post(
      url,
      body: json.encode({"email": userEmail}),
      headers: requestHeaders,
    );

    final Map<dynamic, dynamic> resBody =
        json.decode(response.body) as Map<dynamic, dynamic>;

    log(resBody.toString());

    Map<dynamic, dynamic> userData = resBody["user"];

    if (response.statusCode == 200) {
      _token = resBody["token"];
      _otp = resBody["otp"];
      _username = userData["username"];
      _email = userEmail;
    }

    return response.statusCode;
  }

  Future<int> register(String userEmail, String userName) async {
    final url = Uri.parse("http://crowd-learn.herokuapp.com/auth/register/");

    //map for headers for the api
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    //create map to send data
    Map<String, String> body = {
      "email": userEmail,
      "username": userName,
    };

    var response =
        await http.post(url, headers: requestHeaders, body: json.encode(body));

    if (response.statusCode == 201) {
      //set user data for current session
      _token = json.decode(response.body)["token"];
      _otp = json.decode(response.body)["otp"];
      _email = userEmail;
      _username = userName;

      notifyListeners();
    }

    return response.statusCode;
  }
}

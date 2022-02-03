import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//local

class Session {
  final standard;
  final category;
  final topic;
  final gLink;
  final date;
  final token;
  final epoch;

  Session({
    required this.standard,
    required this.category,
    required this.topic,
    required this.gLink,
    required this.date,
    required this.token,
    required this.epoch
  });
}

class Sessions extends ChangeNotifier {
  List<Session> _allSessions = [];

  Future<int> createSession({
    required String inpStd,
    required String inpCtgry,
    required String inpTopic,
    required String inpLink,
    required String inpDate,
    required String inpToken,
    required int inpEpoch,
  }) async {
    final url = Uri.parse("https://crowd-learn.herokuapp.com/session/create/");

    final requestHeaders = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $inpToken'
    };

    final http.Response response = await http.post(url,
        headers: requestHeaders,
        body: json.encode({
          'class': inpStd,
          'category': inpCtgry,
          'topic': inpTopic,
          'glink': inpLink,
          'dateToBeHeld': inpDate,
          'epochTime' : inpEpoch
        }));

    log(response.body);

    return response.statusCode;
  }
}

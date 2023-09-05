import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note_app/Models/user_model.dart';
import 'package:note_app/services/api_service.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  bool isLoding = false;
  bool isBack = false;
  Future<void> login(User user) async {
    isLoding = true;
    notifyListeners();
    http.Response response = (await ApiService.login(user))!;

    log(response.statusCode.toString());
    if (response.statusCode == 201) {
      isBack = true;
    }

    isLoding = false;
    notifyListeners();
  }

  Future<void> signup(User user) async {
    isLoding = true;
    notifyListeners();
    http.Response response = (await ApiService.signup(user))!;

    if (response.statusCode == 200) {
      isBack = true;
    }

    isLoding = false;
    notifyListeners();
  }

  void fatchData() async {
    // await Future<void>.delayed(const Duration(seconds: 2));

    isLoding = false;
  }
}

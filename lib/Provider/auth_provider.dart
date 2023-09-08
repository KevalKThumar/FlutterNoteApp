import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note_app/Models/user_model.dart';
import 'package:note_app/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  User _user = User(email: '', name: '', password: '', token: '');
  bool isLoding = false;
  bool isBack = false;
  Future<http.Response> login(User user, BuildContext context) async {
    isLoding = true;
    isBack = false;
    notifyListeners();
    http.Response response = (await ApiService.login(user, context))!;

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      isBack = true;
    }

    isLoding = false;
    notifyListeners();

    return response;
  }

  Future<void> signup(User user, BuildContext context) async {
    isLoding = true;
    isBack = false;
    notifyListeners();
    http.Response response = (await ApiService.signup(user, context))!;

    if (response.statusCode == 200) {
      isBack = true;
    }

    isLoding = false;
    notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences prefe = await SharedPreferences.getInstance();
    prefe.setString('x-auth-token', "");
    notifyListeners();
  }

  User get user => _user;
  void setUser(String user) async {
    _user = User.fromJson(user);
    notifyListeners();
  }
}

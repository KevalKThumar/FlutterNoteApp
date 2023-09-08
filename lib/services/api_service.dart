// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:note_app/Models/note_model.dart';
import 'package:http/http.dart' as http;
import 'package:note_app/Models/user_model.dart';
import 'package:note_app/Provider/auth_provider.dart';
import 'package:note_app/widget/show_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseURLNote =
      "https://flutter-notes-app-api.vercel.app/notes";
  static const String _baseURLAuth =
      "https://flutter-notes-app-api.vercel.app/auth";
  static String _userid = "";

  static Future<http.Response?> signup(User user, BuildContext context) async {
    http.Response? response;

    try {
      Uri requestURL = Uri.parse('$_baseURLAuth/register');
      response = await http.post(
        requestURL,
        body: user.toMap(),
      );
      var decoded = jsonDecode(response.body)['message'];
      showSnackBar(context, decoded.toString());
      // log(decoded.toString());
    } on Exception catch (e) {
      log(e.toString());
    }
    return response;
  }

  static Future<http.Response?> login(User user, BuildContext context) async {
    http.Response? response;
    try {
      Uri requestURL = Uri.parse('$_baseURLAuth/login');
      response = await http.post(
        requestURL,
        body: user.toMap(),
      );
      var decoded = jsonDecode(response.body)['message'];
      showSnackBar(context, decoded.toString());
      // log(decoded.toString());
    } on Exception catch (e) {
      log(e.toString());
    }
    return response;
  }

  static void getUser(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$_baseURLAuth/tokenIsValid'),
        headers: <String, String>{
          'Contant-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        // get the user data
        log("Tocken of user is:::->>>>>>>>>$token");
        http.Response userRes = await http.get(
          Uri.parse('$_baseURLAuth/getuser'),
          headers: <String, String>{
            'Contant-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );
        log(jsonDecode(userRes.body)['email']);
        _userid = jsonDecode(userRes.body)['email'];

        var userProvider = Provider.of<AuthProvider>(context, listen: false);

        userProvider.setUser(userRes.body);
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static Future<void> addNote(Note note) async {
    try {
      Uri requestURI = Uri.parse('$_baseURLNote/add');
      var responce = await http.post(requestURI, body: note.toMap());
      var decoded = jsonDecode(responce.body)['message'];
      log(decoded.toString());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static Future<void> deleteNode(Note note) async {
    try {
      Uri requestURI = Uri.parse('$_baseURLNote/delete');
      var responce = await http.post(requestURI, body: note.toMap());
      var decoded = jsonDecode(responce.body)['message'];
      log(decoded.toString());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static Future<List<Note>> fatchnotes() async {
    Uri requestURI = Uri.parse('$_baseURLNote/list');
    var responce = await http.post(requestURI, body: {"userid": _userid});
    var decoded = jsonDecode(responce.body);
    // log(decoded.toString());

    List<Note> notes = [];

    for (var noteMap in decoded) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }

    return notes;
  }
}

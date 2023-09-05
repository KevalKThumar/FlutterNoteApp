import 'dart:convert';
import 'dart:developer';
import 'package:note_app/Models/note_model.dart';
import 'package:http/http.dart' as http;
import 'package:note_app/Models/user_model.dart';

class ApiService {
  static const String _baseURLNote =
      "https://flutter-notes-app-api.vercel.app/notes";
  static const String _baseURLAuth =
      "https://flutter-notes-app-api.vercel.app/auth";

  static Future<http.Response?> signup(User user) async {
    http.Response? response;

    try {
      Uri requestURL = Uri.parse('$_baseURLAuth/register');
      response = await http.post(
        requestURL,
        body: user.toMap(),
      );
      var decoded = jsonDecode(response.body);
      log(decoded.toString());
    } on Exception catch (e) {
      log(e.toString());
    }
    return response;
  }

  static Future<http.Response?> login(User user) async {
    http.Response? response;
    try {
      Uri requestURL = Uri.parse('$_baseURLAuth/login');
      response = await http.post(
        requestURL,
        body: user.toMap(),
      );
      var decoded = jsonDecode(response.body);
      log(decoded.toString());
    } on Exception catch (e) {
      log(e.toString());
    }
    return response;
  }

  static Future<void> addNote(Note note) async {
    try {
      Uri requestURI = Uri.parse('$_baseURLNote/add');
      var responce = await http.post(requestURI, body: note.toMap());
      var decoded = jsonDecode(responce.body);
      log(decoded.toString());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static Future<void> deleteNode(Note note) async {
    try {
      Uri requestURI = Uri.parse('$_baseURLNote/delete');
      var responce = await http.post(requestURI, body: note.toMap());
      var decoded = jsonDecode(responce.body);
      log(decoded.toString());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static Future<List<Note>> fatchnotes(String usrid) async {
    Uri requestURI = Uri.parse('$_baseURLNote/list');
    var responce = await http.post(requestURI, body: {"userid": usrid});
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

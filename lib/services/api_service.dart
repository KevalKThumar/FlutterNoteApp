import 'dart:convert';
import 'dart:developer';

import 'package:note_app/Models/note_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseURL =
      "https://flutter-notes-app-api.vercel.app/notes";

  static Future<void> addNote(Note note) async {
    Uri requestURI = Uri.parse('$_baseURL/add');
    var responce = await http.post(requestURI, body: note.toMap());
    var decoded = jsonDecode(responce.body);
    log(decoded.toString());
  }

  static Future<void> deleteNode(Note note) async {
    Uri requestURI = Uri.parse('$_baseURL/delete');
    var responce = await http.post(requestURI, body: note.toMap());
    var decoded = jsonDecode(responce.body);
    log(decoded.toString());
  }

  static Future<List<Note>> fatchnotes(String usrid) async {
    Uri requestURI = Uri.parse('$_baseURL/list');
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

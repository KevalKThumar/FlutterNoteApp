import 'package:flutter/material.dart';

import '../Models/note_model.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
  }

  void updateNote() {}
  void deleteNote() {}
}
